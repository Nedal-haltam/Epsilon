using System;
using System.Collections.Generic;
using System.Drawing;
using System.Reflection.Metadata;
using System.Text;
using System.Xml.Linq;
namespace Epsilon
{
    public static class RISCVGenerator
    {
        ////////////////////////////////////////////////////////
        static NodeProg m_program;
        ////////////////////////////////////////////////////////
        static Variables m_Variables;
#pragma warning disable CS8618 // Non-nullable field must contain a non-null value when exiting constructor. Consider adding the 'required' modifier or declaring as nullable.
        static Dictionary<string, NodeStmtFunction> m_UserDefinedFunctions;
        static string m_inputFilePath;
        static List<string> m_STD_FUNCTIONS;
        static List<Var> Globals;
        static Stack<int> m_scopes;
        static uint m_StackSize;
        static Stack<string?> m_scopestart;
        static Stack<string?> m_scopeend;
        static List<string> m_CalledFunctions;
        static List<string> m_StringLits;
        static ulong m_LabelsCount;
        static string m_CurrentFunctionName;

        static StringBuilder m_output;

        static string m_FirstTempReg;
        static string m_SecondTempReg;
#pragma warning restore CS8618 // Non-nullable field must contain a non-null value when exiting constructor. Consider adding the 'required' modifier or declaring as nullable.
        ////////////////////////////////////////////////////////
        static string GetLabel() => $"LABEL{m_LabelsCount++}";
        static void LoadStoreBasedOnSize(string inst, string DestinationRegister, string SourceRegister, string Offset, uint ElementSize)
        {
            string Mnem = "";
            if (inst == "store") Mnem = "S";
            else if (inst == "load") Mnem = "L";
            else Shartilities.Logln(Shartilities.LogType.ERROR, $"invalid argument {inst}, expected: <load|store>", 1);

            if (ElementSize == 1)
                m_output.AppendLine($"    {Mnem}B {DestinationRegister}, {Offset}({SourceRegister})");
            else if (ElementSize == 8)
                m_output.AppendLine($"    {Mnem}D {DestinationRegister}, {Offset}({SourceRegister})");
            else
                Shartilities.Logln(Shartilities.LogType.ERROR, $"invalid ElementSize {ElementSize}", 1);
        }
        static void GenPush(string reg, uint size = 8)
        {
            m_output.AppendLine($"    ADDI sp, sp, -{size}");
            LoadStoreBasedOnSize("store", reg, "sp", "0", size);
            m_StackSize += size;
        }
        static void GenPush(uint size)
        {
            if (size == 0) return;
            m_output.AppendLine($"    ADDI sp, sp, -{size}");
            m_StackSize += size;
        }
        static void GenPop(string reg, uint size = 8)
        {
            LoadStoreBasedOnSize("load", reg, "sp", "0", size);
            m_output.AppendLine($"    ADDI sp, sp, {size}");
            m_StackSize -= size;
        }
        static void GenPop(uint size, bool Change_m_stacksize)
        {
            if (size == 0) return;
            m_output.AppendLine($"    ADDI sp, sp, {size}");
            if (Change_m_stacksize) m_StackSize -= size;
        }
        static void GenPushMany(List<string> regs, uint RegisterSize)
        {
            if (regs.Count == 0) return;
            m_output.AppendLine($"    ADDI sp, sp, -{regs.Count * RegisterSize}");
            for (int i = 0; i < regs.Count; i++)
            {
                m_output.AppendLine($"    SD {regs[i]}, {RegisterSize * i}(sp)");
            }
            m_StackSize += (uint)(RegisterSize * regs.Count);
        }
        static void GenPopMany(List<string> regs, uint RegisterSize)
        {
            if (regs.Count == 0) return;
            for (int i = 0; i < regs.Count; i++)
            {
                m_output.AppendLine($"    LD {regs[regs.Count - i - 1]}, {RegisterSize * (regs.Count - i - 1)}(sp)");
            }
            m_output.AppendLine($"    ADDI sp, sp, {regs.Count * RegisterSize}");
            m_StackSize -= (uint)(RegisterSize * regs.Count);
        }
        static void StackPopEndScope(uint popcount)
        {
            if (popcount == 0) return;
            m_output.AppendLine($"    LI t0, {popcount}");
            m_output.AppendLine($"    ADD sp, sp, t0");
            m_StackSize -= popcount;
        }
        static void BeginScope()
        {
            m_scopes.Push(m_Variables.VariablesCount());
        }
        static void EndScope()
        {
            int Vars_topop = m_Variables.VariablesCount() - m_scopes.Pop();
            int i = m_Variables.VariablesCount() - 1;
            int iterations = Vars_topop;
            uint popcount = 0;
            while (iterations-- > 0)
            {
                popcount += m_Variables[i--].Size;
            }
            StackPopEndScope(popcount);
            m_Variables.RemoveRange(m_Variables.VariablesCount() - Vars_topop, Vars_topop);
        }
        static void GenScope(NodeStmtScope scope)
        {
            BeginScope();
            foreach (NodeStmt stmt in scope.stmts)
            {
                GenStmt(stmt);
            }
            EndScope();
        }
        static NodeExpr GenIndexExprMult(ref List<NodeExpr> indexes, ref List<uint> dims, int i)
        {
            if (i == dims.Count - 1)
            {
                return NodeExpr.Number(dims[^1].ToString(), -1);
            }
            return new()
            {
                type = NodeExpr.NodeExprType.BinExpr,
                binexpr = new()
                {
                    type = NodeBinExpr.NodeBinExprType.Mul,
                    lhs = NodeExpr.Number(dims[i].ToString(), -1),
                    rhs = GenIndexExprMult(ref indexes, ref dims, i + 1),
                },
            };
        }
        static NodeExpr GenIndexExpr(ref List<NodeExpr> indexes, ref List<uint> dims, int i)
        {
            if (i == indexes.Count - 1)
            {
                return new()
                {
                    type = NodeExpr.NodeExprType.Term,
                    term = new()
                    {
                        type = NodeTerm.NodeTermType.Paren,
                        paren = new() { expr = indexes[^1] },
                    }
                };
            }
            NodeExpr lhs = NodeExpr.BinExpr(NodeBinExpr.NodeBinExprType.Mul, indexes[i], GenIndexExprMult(ref indexes, ref dims, i + 1));
            NodeExpr rhs = GenIndexExpr(ref indexes, ref dims, i + 1);
            return NodeExpr.BinExpr(NodeBinExpr.NodeBinExprType.Add, lhs, rhs);
        }
        static void GenExpr(NodeExpr expr, string? DestReg, uint size = 8)
        {
            if (expr.type == NodeExpr.NodeExprType.Term)
            {
                GenTerm(expr.term, DestReg, size);
            }
            else if (expr.type == NodeExpr.NodeExprType.BinExpr)
            {
                GenBinExpr(expr.binexpr, DestReg, size);
            }
            else if (expr.type == NodeExpr.NodeExprType.None)
            {
                GenPush(size);
            }
            else
                Shartilities.UNREACHABLE("no valid expression");
        }
        static Var GenVariableDeclare(NodeStmtDeclare declare, bool PushExpressions, bool IsGlobal = false)
        {
            if (declare.type == NodeStmtIdentifierType.SingleVar)
            {
                if (declare.datatype == NodeStmtDataType.Auto)
                {
                    if (PushExpressions)
                        GenExpr(declare.singlevar.expr, null);
                    return new(declare.ident.Value, 8, 8, [], false, false, false, IsGlobal);
                }
                else if (declare.datatype == NodeStmtDataType.Char)
                {
                    if (PushExpressions)
                        GenExpr(declare.singlevar.expr, null, 1);
                    return new(declare.ident.Value, 1, 1, [], false, false, false, IsGlobal);
                }
            }
            else if (declare.type == NodeStmtIdentifierType.Array)
            {
                List<uint> dims = declare.array.Dimensions;
                uint count = 1;
                foreach (uint d in dims)
                    count *= d;
                uint SizePerVar = 0;
                if (declare.datatype == NodeStmtDataType.Auto)
                    SizePerVar = 8;
                else if (declare.datatype == NodeStmtDataType.Char)
                    SizePerVar = 1;
                else
                    Shartilities.UNREACHABLE("SizePerVar");
                if (PushExpressions)
                    GenPush(SizePerVar * count);
                return new(declare.ident.Value, SizePerVar * count, SizePerVar, dims, true, false, false, IsGlobal);
            }
            Shartilities.UNREACHABLE($"invalid identifier type");
            return new();
        }
        static Var GenStmtDeclare(NodeStmtDeclare declare, bool PushExpressions)
        {
            Token ident = declare.ident;
            if (m_Variables.IsVariableDeclared(ident.Value))
                Shartilities.Logln(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{ident.Line}:1: Generator: variable `{ident.Value}` is alread declared", 1);
            return GenVariableDeclare(declare, PushExpressions);
        }
        static void GenArrayIndex(List<NodeExpr> indexes, List<uint> dims, Var var, string reg)
        {
            if (!var.IsArray)
                Shartilities.Logln(Shartilities.LogType.ERROR, $"Generator: variable `{var.Value}` is not declared as an array", 1);
            Shartilities.Assert(var.IsVariadic || indexes.Count == var.Dimensions.Count, "Generator: indexes and dimensionality are not equal");
            NodeExpr IndexExpr = GenIndexExpr(ref indexes, ref dims, 0);
            GenExpr(
                NodeExpr.BinExpr(
                    NodeBinExpr.NodeBinExprType.Mul,
                    NodeExpr.Number(var.ElementSize.ToString(), -1),
                    IndexExpr),
                reg, 8
            );
        }
        static void GenArrayAddr(List<NodeExpr> indexes, Var var, uint? RelativeLocationOfBaseAddress= null)
        {
            string Address = m_FirstTempReg;
            GenArrayIndex(indexes, var.Dimensions, var, Address);
            if (RelativeLocationOfBaseAddress.HasValue)
            {
                string BaseReg = m_SecondTempReg;
                m_output.AppendLine($"    LD {BaseReg}, {RelativeLocationOfBaseAddress}(sp)");
                m_output.AppendLine($"    ADD {Address}, {BaseReg}, {Address}");
                // Base address + index
            }
            else
            {
                uint RelativeLocation = m_Variables.GetVariableRelativeLocation(var, m_StackSize) - (var.Size - var.ElementSize);
                m_output.AppendLine($"    ADDI {Address}, {Address}, {RelativeLocation}");
                m_output.AppendLine($"    ADD {Address}, sp, {Address}");
                // sp + index + (base address realtive address on the stack)
            }
            GenPush(Address);
        }
        static string GetOthertempRegisgter(string Register) => Register == m_FirstTempReg ? m_SecondTempReg : m_FirstTempReg;
        static void GenTerm(NodeTerm term, string? DestReg, uint size)
        {
            string RegData = DestReg ?? m_FirstTempReg;
            if (term.type == NodeTerm.NodeTermType.Unary)
            {
                if (term.unary.type == NodeTermUnaryExpr.NodeTermUnaryExprType.complement)
                {
                    GenTerm(term.unary.term, RegData, size);
                    m_output.AppendLine($"    SEQZ {RegData}, {RegData}");
                    if (DestReg == null)
                        GenPush(RegData, size);
                }
                else if (term.unary.type == NodeTermUnaryExpr.NodeTermUnaryExprType.not)
                {
                    GenTerm(term.unary.term, RegData, size);
                    m_output.AppendLine($"    NOT {RegData}, {RegData}");
                    if (DestReg == null)
                        GenPush(RegData, size);
                }
                else if (term.unary.type == NodeTermUnaryExpr.NodeTermUnaryExprType.negative)
                {
                    GenTerm(term.unary.term, RegData, size);
                    m_output.AppendLine($"    NEG {RegData}, {RegData}");
                    if (DestReg == null)
                        GenPush(RegData, size);
                }
                else if (term.unary.type == NodeTermUnaryExpr.NodeTermUnaryExprType.addressof)
                {
                    NodeTermIdent ident = term.unary.term.ident;
                    if (ident.indexes.Count == 0)
                    {
                        Var var = m_Variables.GetVariable(ident.ident.Value, m_inputFilePath, ident.ident.Line);
                        if (var.IsGlobal)
                        {
                            m_output.AppendLine($"    LA {RegData}, {var.Value}");
                        }
                        else
                        {
                            uint RelativeLocation = m_Variables.GetVariableRelativeLocation(var, m_StackSize);
                            if (var.IsParameter)
                                m_output.AppendLine($"    ADDI {RegData}, sp, {RelativeLocation}");
                            else
                                m_output.AppendLine($"    ADDI {RegData}, sp, {RelativeLocation - (var.TypeSize * (var.Count - 1))}");
                        }
                    }
                    if (DestReg == null)
                        GenPush(RegData, size);
                }
                else Shartilities.UNREACHABLE("invalid unary oprator");
            }
            else if (term.type == NodeTerm.NodeTermType.IntLit)
            {
                m_output.AppendLine($"    LI {RegData}, {term.intlit.intlit.Value}");
                if (DestReg == null)
                    GenPush(RegData, size);
            }
            else if (term.type == NodeTerm.NodeTermType.StringLit)
            {
                string literal = term.stringlit.stringlit.Value;
                if (!m_StringLits.Contains(literal))
                    m_StringLits.Add(literal);
                int index = m_StringLits.IndexOf(literal);
                m_output.AppendLine($"    LA {RegData}, StringLits{index}");
                if (DestReg == null)
                    GenPush(RegData, size);
            }
            else if (term.type == NodeTerm.NodeTermType.FunctionCall)
            {
                GenStmtFunctionCall(new() { FunctionName = term.functioncall.FunctionName, parameters = term.functioncall.parameters }, true);
                m_output.AppendLine($"    MV {RegData}, s0");
                if (DestReg == null)
                    GenPush(RegData, size);
            }
            else if (term.type == NodeTerm.NodeTermType.Ident)
            {
                NodeTermIdent ident = term.ident;
                Var var = m_Variables.GetVariable(ident.ident.Value, m_inputFilePath, ident.ident.Line);
                if (ident.indexes.Count == 0)
                {
                    if (var.IsArray)
                    {
                        if (var.IsParameter)
                        {
                            if (var.IsGlobal)
                                Shartilities.Logln(Shartilities.LogType.ERROR, $"cannot put global variable as a parameter", 1);
                            uint RelativeLocation = m_Variables.GetVariableRelativeLocation(var, m_StackSize);
                            m_output.AppendLine($"    LD {RegData}, {RelativeLocation}(sp)");
                        }
                        else
                        {
                            if (var.IsGlobal)
                                m_output.AppendLine($"    LA {RegData}, {var.Value}");
                            else
                            {
                                uint RelativeLocation = m_Variables.GetVariableRelativeLocation(var, m_StackSize);
                                m_output.AppendLine($"    ADDI {RegData}, sp, {RelativeLocation - (var.TypeSize * (var.Count - 1))}");
                            }
                        }
                    }
                    else
                    {
                        uint RelativeLocation = 0;
                        string BaseReg = var.IsGlobal ? GetOthertempRegisgter(RegData) : "sp";
                        if (var.IsGlobal)
                            m_output.AppendLine($"    LA {BaseReg}, {var.Value}");
                        else
                            RelativeLocation = m_Variables.GetVariableRelativeLocation(var, m_StackSize);
                        LoadStoreBasedOnSize("load", RegData, BaseReg, RelativeLocation.ToString(), var.ElementSize);
                    }
                }
                else
                {
                    string RegAddr = GetOthertempRegisgter(RegData);
                    if (var.IsParameter)
                    {
                        if (var.IsGlobal)
                            Shartilities.Logln(Shartilities.LogType.ERROR, $"cannot put global variable as a parameter", 1);
                        uint RelativeLocationOfBaseAddress= m_Variables.GetVariableRelativeLocation(var, m_StackSize);
                        GenArrayAddr(ident.indexes, var, RelativeLocationOfBaseAddress);
                    }
                    else
                    {
                        if (var.IsGlobal)
                        {
                            GenArrayIndex(ident.indexes, var.Dimensions, var, RegData);
                            m_output.AppendLine($"    LA {RegAddr}, {var.Value}");
                            m_output.AppendLine($"    ADD {RegAddr}, {RegAddr}, {RegData}");
                            GenPush(RegAddr);
                        }
                        else
                        {
                            GenArrayAddr(ident.indexes, var);
                        }
                    }
                    GenPop(RegAddr);
                    LoadStoreBasedOnSize("load", RegData, RegAddr, "0", var.ElementSize);
                }
                if (DestReg == null)
                    GenPush(RegData, size);
            }
            else if (term.type == NodeTerm.NodeTermType.Variadic)
            {
                Var var = m_Variables.GetVariadic();
                string RegAddr = GetOthertempRegisgter(RegData);

                uint RelativeLocation = m_Variables.GetVariableRelativeLocation(var, m_StackSize);
                GenExpr(NodeExpr.BinExpr(NodeBinExpr.NodeBinExprType.Mul, NodeExpr.Number("8", -1), term.variadic.VariadicIndex), RegAddr);
                m_output.AppendLine($"    SUB {RegAddr}, sp, {RegAddr}");
                m_output.AppendLine($"    LD {RegData}, {RelativeLocation}({RegAddr})");
                if (DestReg == null)
                    GenPush(RegData, size);
            }
            else if (term.type == NodeTerm.NodeTermType.Paren)
            {
                GenExpr(term.paren.expr, RegData, size);
                if (DestReg == null)
                    GenPush(RegData, size);
            }
            else
            {
                Shartilities.Logln(Shartilities.LogType.ERROR, $"Generator: invalid term `{term.type}`", 1);
            }
        }
        static void GenStmtAssign(NodeStmtAssign assign)
        {
            string RegData = m_FirstTempReg;
            if (assign.type == NodeStmtIdentifierType.SingleVar)
            {
                Token ident = assign.singlevar.ident;
                Var var = m_Variables.GetVariable(ident.Value, m_inputFilePath, ident.Line); 
                GenExpr(assign.singlevar.expr, RegData, var.ElementSize);

                uint RelativeLocation = 0;
                string BaseReg = var.IsGlobal ? GetOthertempRegisgter(RegData) : "sp";
                if (var.IsGlobal)
                    m_output.AppendLine($"    LA {BaseReg}, {var.Value}");
                else
                    RelativeLocation = m_Variables.GetVariableRelativeLocation(var, m_StackSize);
                LoadStoreBasedOnSize("store", RegData, BaseReg, RelativeLocation.ToString(), var.ElementSize);
                return;
            }
            else if (assign.type == NodeStmtIdentifierType.Array)
            {
                Token ident = assign.array.ident;
                Var var = m_Variables.GetVariable(ident.Value, m_inputFilePath, ident.Line); 
                string RegAddr = m_SecondTempReg;
                if (var.IsParameter)
                {
                    if (var.IsGlobal)
                        Shartilities.Logln(Shartilities.LogType.ERROR, $"cannot put global variable as a parameter", 1);
                    uint RelativeLocationOfBaseAddress= m_Variables.GetVariableRelativeLocation(var, m_StackSize);
                    GenArrayAddr(assign.array.indexes, var, RelativeLocationOfBaseAddress);
                }
                else
                {
                    if (var.IsGlobal)
                    {
                        GenArrayIndex(assign.array.indexes, var.Dimensions, var, RegData);
                        m_output.AppendLine($"    LA {RegAddr}, {var.Value}");
                        m_output.AppendLine($"    ADD {RegAddr}, {RegAddr}, {RegData}");
                        GenPush(RegAddr);
                    }
                    else
                    {
                        GenArrayAddr(assign.array.indexes, var);
                    }
                }
                GenExpr(assign.array.expr, RegData, var.ElementSize);
                GenPop(RegAddr);
                LoadStoreBasedOnSize("store", RegData, RegAddr, "0", var.ElementSize);
                return;
            }
            Shartilities.UNREACHABLE("not valid identifier type");
        }
        static NodeStmtFunction CheckFunctionCallCorrectness(NodeStmtFunctionCall CalledFunction)
        {
            if (m_UserDefinedFunctions.TryGetValue(CalledFunction.FunctionName.Value, out NodeStmtFunction CalledFunctionDefinition))
            {
                int MaxParamsCount = 7;
                int ProvidedParamsCount = CalledFunction.parameters.Count;
                if (ProvidedParamsCount > MaxParamsCount)
                    Shartilities.Logln(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{CalledFunction.FunctionName.Line}:1: Generator: Function call to `{CalledFunctionDefinition.FunctionName.Value}` provided too much parameters to function (bigger than {MaxParamsCount})", 1);
                if (CalledFunctionDefinition.parameters.Count > 0 && CalledFunctionDefinition.parameters[^1].IsVariadic)
                {
                    if (ProvidedParamsCount < CalledFunctionDefinition.parameters.Count - 1)
                        Shartilities.Logln(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{CalledFunction.FunctionName.Line}:1: Generator: Function call to `{CalledFunctionDefinition.FunctionName.Value}` is not valid, check function arity", 1);
                }
                else
                {
                    if (ProvidedParamsCount != CalledFunctionDefinition.parameters.Count)
                        Shartilities.Logln(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{CalledFunction.FunctionName.Line}:1: Generator: Function call to `{CalledFunctionDefinition.FunctionName.Value}` is not valid, check function arity", 1);
                }
                return CalledFunctionDefinition;
            }
            else if (!m_STD_FUNCTIONS.Contains(CalledFunction.FunctionName.Value))
            {
                Shartilities.Logln(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{CalledFunction.FunctionName.Line}:1: Generator: Function `{CalledFunction.FunctionName.Value}` is not defined", 1);
            }
            return new();
        }
        static void FunctionCallFillParameters(NodeStmtFunctionCall CalledFunction, NodeStmtFunction CalledFunctionDefinition)
        {
            if (m_UserDefinedFunctions.ContainsKey(CalledFunction.FunctionName.Value)) // user defined
            {
                bool filled = false;
                for (int i = 0; i < CalledFunction.parameters.Count; i++)
                {
                    if (CalledFunctionDefinition.parameters[i].IsVariadic)
                    {
                        filled = true;
                        Shartilities.Assert(i == CalledFunctionDefinition.parameters.Count - 1, $"variadic should be the last argument\n");
                        GenExpr(NodeExpr.Number((CalledFunction.parameters.Count - i).ToString(), -1), $"a{i}");
                        for (int j = i; j < CalledFunction.parameters.Count; j++)
                        {
                            GenExpr(CalledFunction.parameters[j], $"a{j + 1}");
                        }
                        break;
                    }
                    else
                    {
                        GenExpr(CalledFunction.parameters[i], $"a{i}", CalledFunctionDefinition.parameters[i].ElementSize);
                    }
                }
                if (!filled && CalledFunctionDefinition.parameters.Count > 0 && CalledFunctionDefinition.parameters[^1].IsVariadic)
                    GenExpr(NodeExpr.Number("0", -1), $"a{CalledFunction.parameters.Count}");
            }
            else // std function
            {
                for (int i = 0; i < CalledFunction.parameters.Count; i++)
                {
                    GenExpr(CalledFunction.parameters[i], $"a{i}");
                }
            }
        }
        static void FunctionCallPrologue(NodeStmtFunctionCall CalledFunction, ref List<string> ParametersRegisters, bool WillPushParams)
        {
            if (WillPushParams)
            {
                ParametersRegisters.Clear();
                for (int i = 0; i < CalledFunction.parameters.Count; i++)
                    ParametersRegisters.Add($"a{i}");
                GenPushMany(ParametersRegisters, 8);
            }
        }
        static void FunctionCallEpilogue(NodeStmtFunctionCall CalledFunction, List<string> ParametersRegisters, bool WillPushParams)
        {
            Shartilities.UNUSED(CalledFunction);
            if (WillPushParams)
            {
                GenPopMany(ParametersRegisters, 8);
            }
        }
        static void GenStmtFunctionCall(NodeStmtFunctionCall CalledFunction, bool WillPushParams)
        {
            NodeStmtFunction CalledFunctionDefinition = CheckFunctionCallCorrectness(CalledFunction);
            if (!m_CalledFunctions.Contains(CalledFunction.FunctionName.Value))
                m_CalledFunctions.Add(CalledFunction.FunctionName.Value);

            List<string> ParametersRegisters = [];
            FunctionCallPrologue(CalledFunction, ref ParametersRegisters, WillPushParams);
            FunctionCallFillParameters(CalledFunction, CalledFunctionDefinition);
            m_output.AppendLine($"    call {CalledFunction.FunctionName.Value}");
            FunctionCallEpilogue(CalledFunction, ParametersRegisters, WillPushParams);
        }
        static void GenPushFunctionParametersInDefinition(List<Var> parameters)
        {
            for (int i = 0; i < parameters.Count; i++)
            {
                if (parameters[i].IsVariadic)
                {
                    Shartilities.Assert(i == parameters.Count - 1, $"variadic should be the last argument\n");
                    // up until a7
                    for (int j = i; j <= 7; j++)
                    {
                        GenPush($"a{j}");
                        m_Variables.AddVariable(new($"variadic({j - i})", 8, 8, [], false, true, true));
                    }
                    break;
                }
                else
                {
                    uint TypeSize = parameters[i].ElementSize;
                    uint Size = parameters[i].Size;
                    bool IsArray = parameters[i].IsArray;
                    if (IsArray)
                        GenPush($"a{i}");
                    else
                        GenPush($"a{i}", TypeSize);
                    m_Variables.AddVariable(new(parameters[i].Value, Size, TypeSize, parameters[i].Dimensions, IsArray, true, false));
                }
            }
        }
        static void GetGlobalVariables(bool GenExpressions)
        {
            Globals = [];
            for (int i = 0; i < m_program.GlobalScope.stmts.Count; i++)
            {
                NodeStmt stmt = m_program.GlobalScope.stmts[i];
                if (stmt.type != NodeStmt.NodeStmtType.Declare)
                    Shartilities.Logln(Shartilities.LogType.ERROR, $"global statements should be Variable declarations", 1);
                Globals.Add(GenVariableDeclare(stmt.declare, GenExpressions, true));
            }
        }
        static void GenFunctionPrologue(string FunctionName)
        {
            m_Variables.Reset();
            m_StackSize = new();
            m_scopes = new();
            m_scopestart = new();
            m_scopeend = new();
            m_CurrentFunctionName = FunctionName;
            m_output.AppendLine($"{FunctionName}:");

            GenPush("ra");
            m_Variables.AddVariable(new("", 8, 8, [], false, false, false));
            GenPushFunctionParametersInDefinition(m_UserDefinedFunctions[FunctionName].parameters);
        }
        static void GenFunctionBody()
        {
            NodeStmtScope FunctionBody = m_UserDefinedFunctions[m_CurrentFunctionName].FunctionBody;
            foreach (NodeStmt stmt in FunctionBody.stmts)
                GenStmt(stmt);
        }
        static void GenFunctionEpilogue()
        {
            NodeStmtScope FunctionBody = m_UserDefinedFunctions[m_CurrentFunctionName].FunctionBody;
            if (FunctionBody.stmts.Count == 0 || FunctionBody.stmts[^1].type != NodeStmt.NodeStmtType.Return)
            {
                m_output.AppendLine($"    mv s0, zero");
                GenReturnFromFunction();
            }
        }
        static void GenReturnFromFunction()
        {
            uint AllocatedStackSize = m_Variables.GetAllocatedStackSize();
            Shartilities.Assert(AllocatedStackSize == m_StackSize, $"stack sizes are not equal");
            if (m_CurrentFunctionName == "main")
            {
                GenPop(m_StackSize, false);
                m_output.AppendLine($"    mv a0, s0");
                m_output.AppendLine($"    call exit");
                return;
            }
            GenPop(AllocatedStackSize, false);
            m_output.AppendLine($"    LD ra, -8(sp)");
            m_output.AppendLine($"    ret");
        }
        static void GenFunction(string FunctionName)
        {
            GenFunctionPrologue(FunctionName);
            GenFunctionBody();
            GenFunctionEpilogue();
        }
        static void GenBinExpr(NodeBinExpr binExpr, string? DestReg, uint size)
        {
            string RegData = DestReg ?? m_FirstTempReg;
            string RegData2 = GetOthertempRegisgter(RegData);
            GenExpr(binExpr.rhs, null, size);
            GenExpr(binExpr.lhs, RegData, size);
            GenPop(RegData2, size);
            switch (binExpr.type)
            {
                case NodeBinExpr.NodeBinExprType.Add:
                    m_output.AppendLine($"    ADD {RegData}, {RegData}, {RegData2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Sub:
                    m_output.AppendLine($"    SUB {RegData}, {RegData}, {RegData2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Sll:
                    m_output.AppendLine($"    SLL {RegData}, {RegData}, {RegData2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Srl:
                    m_output.AppendLine($"    SRL {RegData}, {RegData}, {RegData2}");
                    break;
                case NodeBinExpr.NodeBinExprType.EqualEqual:
                    m_output.AppendLine($"    XOR {RegData}, {RegData}, {RegData2}");
                    m_output.AppendLine($"    SEQZ {RegData}, {RegData}");
                    break;
                case NodeBinExpr.NodeBinExprType.NotEqual:
                    m_output.AppendLine($"    XOR {RegData}, {RegData}, {RegData2}");
                    m_output.AppendLine($"    SNEZ {RegData}, {RegData}");
                    break;
                case NodeBinExpr.NodeBinExprType.LessThan:
                    m_output.AppendLine($"    SLT {RegData}, {RegData}, {RegData2}");
                    break;
                case NodeBinExpr.NodeBinExprType.And:
                    m_output.AppendLine($"    AND {RegData}, {RegData}, {RegData2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Or:
                    m_output.AppendLine($"    OR {RegData}, {RegData}, {RegData2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Xor:
                    m_output.AppendLine($"    XOR {RegData}, {RegData}, {RegData2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Mul:
                    m_output.AppendLine($"    MUL {RegData}, {RegData}, {RegData2}");
                    //m_output.AppendLine($"    MULH {RegData}, {RegData}, {RegData2}"); // for upper 64-bit of the multiplication
                    break;
                case NodeBinExpr.NodeBinExprType.Rem:
                    m_output.AppendLine($"    rem {RegData}, {RegData}, {RegData2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Div:
                    m_output.AppendLine($"    div {RegData}, {RegData}, {RegData2}");
                    break;
                default:
                    Shartilities.Logln(Shartilities.LogType.ERROR, $"Generator: invalid binary operator `{binExpr.type}`", 1);
                    return;
            }
            if (DestReg == null)
                GenPush(RegData, size);
        }
        static void GenElifs(NodeIfElifs elifs, string label_end)
        {
            if (elifs.type == NodeIfElifs.NodeIfElifsType.Elif)
            {
                string RegData = m_FirstTempReg;
                string label = GetLabel() + "_elifs";
                GenExpr(elifs.elif.pred.cond, RegData);
                m_output.AppendLine($"    BEQZ {RegData}, {label}");
                GenScope(elifs.elif.pred.scope);
                m_output.AppendLine($"    J {label_end}");
                if (elifs.elif.elifs.HasValue)
                {
                    m_output.AppendLine($"    J {label_end}");
                    m_output.AppendLine($"{label}:");
                    GenElifs(elifs.elif.elifs.Value, label_end);
                }
                else
                {
                    m_output.AppendLine($"{label}:");
                }
            }
            else if (elifs.type == NodeIfElifs.NodeIfElifsType.Else)
            {
                GenScope(elifs.elsee.scope);
            }
            else
                Shartilities.UNREACHABLE("GenElifs");
        }
        static string GenStmtIF(NodeStmtIF iff)
        {
            string RegData = m_FirstTempReg;
            string label_start = GetLabel() + "_START";
            string label_end = GetLabel() + "_END";
            string label = GetLabel() + "_elifs";

            m_output.AppendLine($"{label_start}:");
            GenExpr(iff.pred.cond, RegData);
            m_output.AppendLine($"    BEQZ {RegData}, {label}");
            GenScope(iff.pred.scope);
            if (iff.elifs.HasValue)
            {
                m_output.AppendLine($"    J {label_end}");
                m_output.AppendLine($"{label}:");
                GenElifs(iff.elifs.Value, label_end);
            }
            else
            {
                m_output.AppendLine($"{label}:");
            }
            m_output.AppendLine($"{label_end}:");
            return label_start;
        }
        static void GenStmtFor(NodeStmtFor forr)
        {
            BeginScope();
            if (forr.pred.init.HasValue)
            {
                if (forr.pred.init.Value.type == NodeForInit.NodeForInitType.Declare)
                    m_Variables.AddVariable(GenStmtDeclare(forr.pred.init.Value.declare, true));
                else if (forr.pred.init.Value.type == NodeForInit.NodeForInitType.Assign)
                    GenStmtAssign(forr.pred.init.Value.assign);
                else
                    Shartilities.UNREACHABLE("not valid for init statement");
            }
            if (forr.pred.cond.HasValue)
            {
                string label_start = GetLabel() + "_START";
                string label_end = GetLabel() + "_END";
                string label_update = GetLabel() + "_START";

                m_output.AppendLine($"{label_start}:");
                string RegData = m_FirstTempReg;
                GenExpr(forr.pred.cond.Value.cond, RegData);
                m_output.AppendLine($"    BEQZ {RegData}, {label_end}");
                m_scopestart.Push(label_update);
                m_scopeend.Push(label_end);
                GenScope(forr.pred.scope);
                m_scopestart.Pop();
                m_scopeend.Pop();
                m_output.AppendLine($"{label_update}:");
                if (forr.pred.udpate.updates.Count != 0)
                {
                    for (int i = 0; i < forr.pred.udpate.updates.Count; i++)
                    {
                        GenStmtAssign(forr.pred.udpate.updates[i]);
                    }
                }
                m_output.AppendLine($"    J {label_start}");
                m_output.AppendLine($"{label_end}:");
            }
            else if (forr.pred.udpate.updates.Count != 0)
            {
                string label_start = GetLabel() + "_START";
                string label_end = GetLabel() + "_END";
                string label_update = GetLabel() + "_START";

                m_output.AppendLine($"{label_start}:");
                m_scopestart.Push(label_update);
                m_scopeend.Push(label_end);
                GenScope(forr.pred.scope);
                m_scopestart.Pop();
                m_scopeend.Pop();
                m_output.AppendLine($"{label_update}:");
                for (int i = 0; i < forr.pred.udpate.updates.Count; i++)
                {
                    GenStmtAssign(forr.pred.udpate.updates[i]);
                }
                m_output.AppendLine($"    J {label_start}");
                m_output.AppendLine($"{label_end}:");
            }
            else
            {
                string label_start = GetLabel() + "_START";
                string label_end = GetLabel() + "_END";

                m_output.AppendLine($"{label_start}:");
                m_scopestart.Push(label_start);
                m_scopeend.Push(label_end);
                GenScope(forr.pred.scope);
                m_scopestart.Pop();
                m_scopeend.Pop();
                m_output.AppendLine($"    J {label_start}");
                m_output.AppendLine($"{label_end}:");
            }
            EndScope();
        }
        static void GenStmtWhile(NodeStmtWhile whilee)
        {
            BeginScope();
            string label_start = GetLabel() + "_START";
            string label_end = GetLabel() + "_END";

            m_output.AppendLine($"{label_start}:");
            string RegData = m_FirstTempReg;
            GenExpr(whilee.cond, RegData);
            m_output.AppendLine($"    BEQZ {RegData}, {label_end}");
            m_scopestart.Push(label_start);
            m_scopeend.Push(label_end);
            GenScope(whilee.scope);
            m_scopestart.Pop();
            m_scopeend.Pop();
            m_output.AppendLine($"    J {label_start}");
            m_output.AppendLine($"{label_end}:");
            EndScope();
        }
        static void GenStmtAsm(NodeStmtAsm asm)
        {
            m_output.AppendLine(asm.assembly.Value);
        }
        static void GenStmtBreak(NodeStmtBreak breakk)
        {
            if (m_scopeend.Count == 0)
            {
                Shartilities.Logln(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{breakk.breakk.Line}:1: Generator: no enclosing loop out of which to break from", 1);
            }
            m_output.AppendLine($"    J {m_scopeend.Peek()}");
        }
        static void GenStmtContinue(NodeStmtContinuee continuee)
        {
            if (m_scopestart.Count == 0)
            {
                Shartilities.Logln(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{continuee.continuee.Line}:1: Generator: no enclosing loop out of which to continue", 1);
            }
            m_output.AppendLine($"    J {m_scopestart.Peek()}");
        }
        static void GenStmtExit(NodeStmtExit exit)
        {
            string reg = "a0";
            GenExpr(exit.expr, reg);
            m_output.AppendLine($"    call exit");
        }
        static void GenStmtReturn(NodeStmtReturn returnn)
        {
            GenExpr(returnn.expr, "s0");
            GenReturnFromFunction();
        }
        static void GenStmt(NodeStmt stmt)
        {
            if (stmt.type == NodeStmt.NodeStmtType.Declare)
            {
                m_Variables.AddVariable(GenStmtDeclare(stmt.declare, true));
            }
            else if (stmt.type == NodeStmt.NodeStmtType.Assign)
            {
                GenStmtAssign(stmt.assign);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.If)
            {
                GenStmtIF(stmt.If);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.For)
            {
                GenStmtFor(stmt.For);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.While)
            {
                GenStmtWhile(stmt.While);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.Asm)
            {
                GenStmtAsm(stmt.Asm);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.Break)
            {
                GenStmtBreak(stmt.Break);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.Continue)
            {
                GenStmtContinue(stmt.Continue);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.Function)
            {
                GenStmtFunctionCall(stmt.CalledFunction, false);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.Return)
            {
                GenStmtReturn(stmt.Return);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.Exit)
            {
                GenStmtExit(stmt.Exit);
            }
            else
            {
                Shartilities.Logln(Shartilities.LogType.ERROR, $"Generator: invalid statement `{stmt.type}`", 1);
            }
        }
        static void GenStdFunctions()
        {
            m_output.AppendLine($"exit:");
            m_output.AppendLine($"    li a7, 93");
            m_output.AppendLine($"    ecall");
            m_output.AppendLine($"    ret");
            if (m_CalledFunctions.Contains("strlen"))
            {
                m_output.AppendLine($"strlen:");
                m_output.AppendLine($"    mv t0, a0");
                m_output.AppendLine($"    li s0, 0");
                m_output.AppendLine($"strlen_loop:");
                m_output.AppendLine($"    lbu t1, 0(t0)");
                m_output.AppendLine($"    beqz t1, strlen_done");
                m_output.AppendLine($"    ADDI s0, s0, 1");
                m_output.AppendLine($"    ADDI t0, t0, 1");
                m_output.AppendLine($"    j strlen_loop");
                m_output.AppendLine($"strlen_done:");
                m_output.AppendLine($"    ret");
            }
            if (m_CalledFunctions.Contains("stoa"))
            {
                m_output.AppendLine($"stoa:");
                m_output.AppendLine($"    mv t1, a0");
                //m_output.AppendLine($"    ADDI t2, a1, 32");
                m_output.AppendLine($"    la t2, itoaTempBuffer");
                m_output.AppendLine($"    ADDI t2, t2, 32");
                m_output.AppendLine($"    sb zero, 0(t2)");
                m_output.AppendLine($"stoa_loop:");
                m_output.AppendLine($"    beqz t1, stoa_done");
                m_output.AppendLine($"    li t3, 10");
                m_output.AppendLine($"    rem t4, t1, t3");
                m_output.AppendLine($"    ADDI t4, t4, 48");
                m_output.AppendLine($"    ADDI t2, t2, -1");
                m_output.AppendLine($"    sb t4, 0(t2)");
                m_output.AppendLine($"    div t1, t1, t3");
                m_output.AppendLine($"    j stoa_loop");
                m_output.AppendLine($"stoa_done:");
                m_output.AppendLine($"    mv s0, t2");
                m_output.AppendLine($"    ret");
            }
            if (m_CalledFunctions.Contains("unstoa"))
            {
                m_output.AppendLine($"unstoa:");
                m_output.AppendLine($"    mv t1, a0");
                //m_output.AppendLine($"    ADDI t2, a1, 32");
                m_output.AppendLine($"    la t2, itoaTempBuffer");
                m_output.AppendLine($"    ADDI t2, t2, 32");
                m_output.AppendLine($"    sb zero, 0(t2)");
                m_output.AppendLine($"unstoa_loop:");
                m_output.AppendLine($"    beqz t1, unstoa_done");
                m_output.AppendLine($"    li t3, 10");
                m_output.AppendLine($"    remu t4, t1, t3");
                m_output.AppendLine($"    ADDI t4, t4, 48");
                m_output.AppendLine($"    ADDI t2, t2, -1");
                m_output.AppendLine($"    sb t4, 0(t2)");
                m_output.AppendLine($"    divu t1, t1, t3");
                m_output.AppendLine($"    j unstoa_loop");
                m_output.AppendLine($"unstoa_done:");
                m_output.AppendLine($"    mv s0, t2");
                m_output.AppendLine($"    ret");
            }
            if (m_CalledFunctions.Contains("write"))
            {
                m_output.AppendLine($"write:");
                m_output.AppendLine($"    li a7, 64");
                m_output.AppendLine($"    ecall");
                m_output.AppendLine($"    ret");
            }
        }
        static void GenProgramPrologue()
        {
            m_output.AppendLine($".section .text");
            m_output.AppendLine($".globl main");
            if (!m_UserDefinedFunctions.ContainsKey("main"))
            {
                Shartilities.Logln(Shartilities.LogType.ERROR, $"Generator: no entry point `main` is defined", 1);
            }
            GetGlobalVariables(false);
            m_Variables.m_globals = [.. Globals];
        }
        static void GenProgramEpilogue()
        {
            // nothing to do, for now...
        }
        static void GenProgramDataSection()
        {
            m_output.AppendLine($".section .data");
            for (int i = 0; i < Globals.Count; i++)
            {
                m_output.AppendLine($"{Globals[i].Value}:");
                uint count = Globals[i].IsArray ? Globals[i].Size : Globals[i].ElementSize;
                m_output.AppendLine($"    .space {count}");
            }
            for (int i = 0; i < m_StringLits.Count; i++)
            {
                m_output.AppendLine($"StringLits{i}:");
                m_output.AppendLine($"    .string \"{m_StringLits[i]}\"");
            }
            if (!m_UserDefinedFunctions.ContainsKey("stoa") && m_CalledFunctions.Contains("stoa")
            && !m_UserDefinedFunctions.ContainsKey("unstoa") && m_CalledFunctions.Contains("unstoa"))
            {
                m_output.AppendLine($".section .bss");
                m_output.AppendLine($"itoaTempBuffer:     ");
                m_output.AppendLine($"    .space 32");
            }
        }
        static void GenProgramFunctions()
        {
            GenFunction("main");
            for (int i = 0; i < m_CalledFunctions.Count; i++)
            {
                if (m_UserDefinedFunctions.ContainsKey(m_CalledFunctions[i]))
                {
                    GenFunction(m_CalledFunctions[i]);
                }
            }
            GenStdFunctions();
        }
        static void CodeGeneratorPrologue(NodeProg prog, Dictionary<string, NodeStmtFunction> UserDefinedFunctions, string InputFilePath, List<string> std_functions)
        {
            m_program = prog;
            m_UserDefinedFunctions = new(UserDefinedFunctions);
            m_inputFilePath = new(InputFilePath);
            m_STD_FUNCTIONS = [.. std_functions];


            m_Variables = new();
            Globals = [];
            m_scopes = [];
            m_StackSize = 0;
            m_scopestart = new();
            m_scopeend = new();
            m_CalledFunctions = [];
            m_StringLits = [];
            m_LabelsCount = 1;
            m_CurrentFunctionName = "NO_FUNCTION_NAME";

            m_output = new();

            m_FirstTempReg = "t0";
            m_SecondTempReg = "t1";
        }
        public static StringBuilder GenProgram(NodeProg prog, Dictionary<string, NodeStmtFunction> UserDefinedFunctions, string InputFilePath, List<string> std_functions)
        {
            CodeGeneratorPrologue(prog, UserDefinedFunctions, InputFilePath, std_functions);

            GenProgramPrologue();
            GenProgramFunctions();
            GenProgramDataSection();
            GenProgramEpilogue();

            return m_output;
        }
    }
}