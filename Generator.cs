using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Linq;
namespace Epsilon
{
    public class RISCVGenerator(NodeProg prog, Dictionary<string, NodeStmtFunction> UserDefinedFunctions, string InputFilePath, List<string> std_functions)
    {
        ////////////////////////////////////////////////////////
        public NodeProg m_program = prog;
        public Dictionary<string, NodeStmtFunction> m_UserDefinedFunctions = UserDefinedFunctions;
        public readonly string m_inputFilePath = InputFilePath;
        public readonly List<string> STD_FUNCTIONS = std_functions;
        ////////////////////////////////////////////////////////
        readonly string m_FirstTempReg = "t0";
        readonly string m_SecondTempReg = "t1";
        readonly StringBuilder m_outputcode = new();
        int m_labels_count = 0;
        readonly List<string> m_CalledFunctions = [];
        readonly List<string> m_StringLits = [];
        ////////////////////////////////////////////////////////
        Variables m_vars = new();
        Stack<int> m_scopes = [];
        uint m_StackSize;
        Stack<string?> m_scopestart = new();
        Stack<string?> m_scopeend = new();
        string m_CurrentFunctionName = "NO_FUNCTION_NAME";
        ////////////////////////////////////////////////////////
        void GenPush(string reg, uint size = 8)
        {
            m_outputcode.AppendLine($"    ADDI sp, sp, -{size}");
            if (size == 1)
                m_outputcode.AppendLine($"    SB {reg}, 0(sp)");
            else if (size == 8)
                m_outputcode.AppendLine($"    SD {reg}, 0(sp)");
            else
                Shartilities.UNREACHABLE($"GenPush: size: {size}");
            m_StackSize += size;
        }
        void GenPush(uint size)
        {
            if (size > 0)
            {
                m_outputcode.AppendLine($"    ADDI sp, sp, -{size}");
                m_StackSize += size;
            }
        }
        void GenPushMany(List<string> regs)
        {
            m_outputcode.AppendLine($"    ADDI sp, sp, -{regs.Count * 8}");
            for (int i = 0; i < regs.Count; i++)
            {
                m_outputcode.AppendLine($"    SD {regs[i]}, {8 * i}(sp)");
            }
            m_StackSize += (uint)(8 * regs.Count);
        }
        void GenPop(string reg, uint size = 8)
        {
            if (size == 1)
                m_outputcode.AppendLine($"    LB {reg}, 0(sp)");
            else if (size == 8)
                m_outputcode.AppendLine($"    LD {reg}, 0(sp)");
            else
                Shartilities.UNREACHABLE("GenPop");
            m_outputcode.AppendLine($"    ADDI sp, sp, {size}");
            m_StackSize -= size;
        }
        void GenPop(uint size, bool Change_m_stacksize)
        {
            if (size > 0)
            {
                m_outputcode.AppendLine($"    ADDI sp, sp, {size}");
                if (Change_m_stacksize) m_StackSize -= size;
            }
        }
        void GenPopMany(List<string> regs)
        {
            for (int i = 0; i < regs.Count; i++)
            {
                m_outputcode.AppendLine($"    LD {regs[regs.Count - i - 1]}, {8 * (regs.Count - i - 1)}(sp)");
            }
            m_outputcode.AppendLine($"    ADDI sp, sp, {regs.Count * 8}");
            m_StackSize -= (uint)(8 * regs.Count);
        }
        void StackPopEndScope(uint popcount)
        {
            if (popcount != 0)
            {
                if (popcount >= 2048)
                {
                    m_outputcode.AppendLine($"    LI t0, {popcount}");
                    m_outputcode.AppendLine($"    ADD sp, sp, t0");
                }
                else
                {
                    m_outputcode.AppendLine($"    ADDI sp, sp, {popcount}");
                }
            }
        }
        void BeginScope()
        {
            m_outputcode.AppendLine($"# begin scope");
            m_scopes.Push(m_vars.VariablesCount());
        }
        void EndScope()
        {
            m_outputcode.AppendLine($"# end scope");
            int Vars_topop = m_vars.VariablesCount() - m_scopes.Pop();
            int i = m_vars.VariablesCount() - 1;
            int iterations = Vars_topop;
            uint popcount = 0;
            while (iterations-- > 0)
            {
                popcount += m_vars[i--].Size;
            }
            StackPopEndScope(popcount);
            m_StackSize -= popcount;
            m_vars.RemoveRange(m_vars.VariablesCount() - Vars_topop, Vars_topop);
        }
        void GenScope(NodeStmtScope scope)
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
        void GenExpr(NodeExpr expr, string? DestReg, uint size = 8)
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
        Var GenVariableDeclare(NodeStmtDeclare declare, bool PushExpressions, bool IsGlobal = false)
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
        Var GenStmtDeclare(NodeStmtDeclare declare, bool PushExpressions)
        {
            Token ident = declare.ident;
            if (m_vars.IsVariableDeclared(ident.Value))
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{ident.Line}:1: Generator: variable `{ident.Value}` is alread declared\n", 1);
            return GenVariableDeclare(declare, PushExpressions);
        }
        void GenArrayIndex(List<NodeExpr> indexes, List<uint> dims, Var var, string reg)
        {
            if (!var.IsArray)
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: variable `{var.Value}` is not declared as an array\n", 1);
            Shartilities.Assert(var.IsVariadic || indexes.Count == var.Dimensions.Count, "Generator: indexes and dimensionality are not equal");
            NodeExpr IndexExpr = GenIndexExpr(ref indexes, ref dims, 0);
            GenExpr(
                NodeExpr.BinExpr(
                    NodeBinExpr.NodeBinExprType.Mul,
                    NodeExpr.Number(var.TypeSize.ToString(), -1),
                    IndexExpr),
                reg, 8
            );
        }
        void GenArrayAddr(List<NodeExpr> indexes, Var var, uint? relative_location_of_base_reg = null)
        {
            m_outputcode.AppendLine($"# begin array address");
            string reg = m_FirstTempReg;
            GenArrayIndex(indexes, var.Dimensions, var, reg);
            if (relative_location_of_base_reg.HasValue)
            {
                m_outputcode.AppendLine($"# array address using another base register");
                string BaseReg = m_SecondTempReg;
                m_outputcode.AppendLine($"    LD {BaseReg}, {relative_location_of_base_reg}(sp)");
                m_outputcode.AppendLine($"    ADD {reg}, {BaseReg}, {reg}"); // plus the index
            }
            else
            {
                m_outputcode.AppendLine($"# array address using sp as a base register");
                uint relative_location = m_StackSize - m_vars.GetVariableLocation(var.Value) - var.Size;
                m_outputcode.AppendLine($"    ADDI {reg}, {reg}, {relative_location}"); // plus the relative location of the variable if "sp"
                m_outputcode.AppendLine($"    ADD {reg}, sp, {reg}"); // plus the index
            }
            GenPush(reg);
            m_outputcode.AppendLine($"# end array address");
        }
        void GenTerm(NodeTerm term, string? DestReg, uint size)
        {
            if (term.type == NodeTerm.NodeTermType.Unary)
            {
                if (term.unary.type == NodeTermUnaryExpr.NodeTermUnaryExprType.complement)
                {
                    string reg = DestReg ?? m_FirstTempReg;
                    GenTerm(term.unary.term, reg, size);
                    m_outputcode.AppendLine($"    SEQZ {reg}, {reg}");
                    if (DestReg == null)
                        GenPush(reg, size);
                }
                else if (term.unary.type == NodeTermUnaryExpr.NodeTermUnaryExprType.not)
                {
                    string reg = DestReg ?? m_FirstTempReg;
                    GenTerm(term.unary.term, reg, size);
                    m_outputcode.AppendLine($"    NOT {reg}, {reg}");
                    if (DestReg == null)
                        GenPush(reg, size);
                }
                else if (term.unary.type == NodeTermUnaryExpr.NodeTermUnaryExprType.negative)
                {
                    string reg = DestReg ?? m_FirstTempReg;
                    GenTerm(term.unary.term, reg, size);
                    m_outputcode.AppendLine($"    NEG {reg}, {reg}");
                    if (DestReg == null)
                        GenPush(reg, size);
                }
                else if (term.unary.type == NodeTermUnaryExpr.NodeTermUnaryExprType.addressof)
                {
                    string reg = DestReg ?? m_FirstTempReg;
                    NodeTermIdent ident = term.unary.term.ident;
                    if (ident.indexes.Count == 0)
                    {
                        Var var = m_vars.GetVariable(ident.ident.Value, m_inputFilePath, ident.ident.Line);
                        if (var.IsGlobal)
                        {
                            m_outputcode.AppendLine($"    LA {reg}, {var.Value}");
                        }
                        else
                        {
                            uint TypeSize = var.IsArray && var.IsParameter ? 8 : var.TypeSize;
                            uint Count = var.Size / var.TypeSize;
                            uint relative_location = m_StackSize - m_vars.GetVariableLocation(var.Value) - TypeSize;
                            if (var.IsParameter)
                                m_outputcode.AppendLine($"    ADDI {reg}, sp, {relative_location}");
                            else
                                m_outputcode.AppendLine($"    ADDI {reg}, sp, {relative_location - (TypeSize * (Count - 1))}");
                        }
                        if (DestReg == null)
                            GenPush(reg, size);
                    }
                }
                else
                {
                    Shartilities.UNREACHABLE("invalid unary oprator");
                }
            }
            else if (term.type == NodeTerm.NodeTermType.IntLit)
            {
                string reg = DestReg ?? m_FirstTempReg;
                m_outputcode.AppendLine($"    LI {reg}, {term.intlit.intlit.Value}");
                if (DestReg == null)
                    GenPush(reg, size);
            }
            else if (term.type == NodeTerm.NodeTermType.StringLit)
            {
                string reg = DestReg ?? m_FirstTempReg;
                int index = m_StringLits.IndexOf(term.stringlit.stringlit.Value);
                if (index == -1)
                {
                    m_StringLits.Add(term.stringlit.stringlit.Value);
                    index = m_StringLits.Count - 1;
                }
                m_outputcode.AppendLine($"    LA {reg}, StringLits{index}");
                if (DestReg == null)
                    GenPush(reg, size);
            }
            else if (term.type == NodeTerm.NodeTermType.FunctionCall)
            {
                string reg = DestReg ?? m_FirstTempReg;
                GenStmtFunctionCall(new() { FunctionName = term.functioncall.FunctionName, parameters = term.functioncall.parameters }, true);
                m_outputcode.AppendLine($"    MV {reg}, s0");
                if (DestReg == null)
                    GenPush(reg, size);
            }
            else if (term.type == NodeTerm.NodeTermType.Ident)
            {
                m_outputcode.AppendLine($"########## {term.ident.ident.Value}");
                NodeTermIdent ident = term.ident;
                string reg = DestReg ?? m_FirstTempReg;
                string reg_addr = reg == m_FirstTempReg ? m_SecondTempReg : m_FirstTempReg;
                Var var = m_vars.GetVariable(ident.ident.Value, m_inputFilePath, ident.ident.Line);
                if (ident.indexes.Count == 0)
                {
                    uint TypeSize = var.IsArray && var.IsParameter ? 8 : var.TypeSize;
                    uint Count = var.Size / var.TypeSize;
                    if (var.IsArray)
                    {
                        if (var.IsParameter)
                        {
                            if (var.IsGlobal)
                                Shartilities.Log(Shartilities.LogType.ERROR, $"cannot put global variable as a parameter\n", 1);
                            uint relative_location = m_StackSize - m_vars.GetVariableLocation(var.Value) - TypeSize;
                            m_outputcode.AppendLine($"    LD {reg}, {relative_location}(sp)");
                        }
                        else
                        {
                            if (var.IsGlobal)
                                m_outputcode.AppendLine($"    LA {reg}, {var.Value}");
                            else
                            {
                                uint relative_location = m_StackSize - m_vars.GetVariableLocation(var.Value) - TypeSize;
                                m_outputcode.AppendLine($"    ADDI {reg}, sp, {relative_location - (TypeSize * (Count - 1))}");
                            }
                        }
                    }
                    else
                    {
                        uint relative_location = 0;
                        string BaseReg = "sp";
                        if (var.IsGlobal)
                        {
                            BaseReg = m_SecondTempReg;
                            m_outputcode.AppendLine($"    LA {BaseReg}, {var.Value}");
                        }
                        else
                        {
                            relative_location = m_StackSize - m_vars.GetVariableLocation(var.Value) - TypeSize;
                        }

                        if (TypeSize == 1)
                            m_outputcode.AppendLine($"    LB {reg}, {relative_location}({BaseReg})");
                        else if (TypeSize == 8)
                            m_outputcode.AppendLine($"    LD {reg}, {relative_location}({BaseReg})");
                        else
                            Shartilities.UNREACHABLE("GenTerm:Ident:SingleVar");
                    }
                    if (DestReg == null)
                        GenPush(reg, size);
                }
                else
                {
                    if (var.IsParameter)
                    {
                        if (var.IsGlobal)
                            Shartilities.Log(Shartilities.LogType.ERROR, $"cannot put global variable as a parameter\n", 1);
                        uint relative_location_of_base_reg = m_StackSize - m_vars.GetVariableLocation(ident.ident.Value) - 8;
                        GenArrayAddr(ident.indexes, var, relative_location_of_base_reg);
                    }
                    else
                    {
                        if (var.IsGlobal)
                        {
                            GenArrayIndex(ident.indexes, var.Dimensions, var, reg);
                            m_outputcode.AppendLine($"    LA {reg_addr}, {var.Value}");
                            m_outputcode.AppendLine($"    ADD {reg_addr}, {reg_addr}, {reg}");
                            GenPush(reg_addr);
                        }
                        else
                        {
                            GenArrayAddr(ident.indexes, var);
                        }
                    }
                    GenPop(reg_addr);

                    if (var.TypeSize == 1)
                        m_outputcode.AppendLine($"    LB {reg}, 0({reg_addr})");
                    else if (var.TypeSize == 8)
                        m_outputcode.AppendLine($"    LD {reg}, 0({reg_addr})");
                    else
                        Shartilities.UNREACHABLE("No valid size");
                    if (DestReg == null)
                        GenPush(reg, size);
                }
            }
            else if (term.type == NodeTerm.NodeTermType.Variadic)
            {
                Var var = m_vars.GetVariadic();
                string reg = DestReg ?? m_FirstTempReg;
                string reg_addr = reg == m_FirstTempReg ? m_SecondTempReg : m_FirstTempReg;
                uint relative_location = m_StackSize - m_vars.GetVariableLocation(var.Value) - 8;

                GenExpr(NodeExpr.BinExpr(NodeBinExpr.NodeBinExprType.Mul, NodeExpr.Number("8", -1), term.variadic.VariadicIndex), reg_addr);
                m_outputcode.AppendLine($"    SUB {reg_addr}, sp, {reg_addr}");
                m_outputcode.AppendLine($"    LD {reg}, {relative_location}({reg_addr})");

                if (DestReg == null)
                    GenPush(reg, size);
            }
            else if (term.type == NodeTerm.NodeTermType.Paren)
            {
                string reg = DestReg ?? m_FirstTempReg;
                GenExpr(term.paren.expr, reg, size);
                if (DestReg == null)
                    GenPush(reg, size);
            }
            else
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: invalid term `{term.type}`\n", 1);
            }
        }
        void GenStmtAssign(NodeStmtAssign assign)
        {
            if (assign.type == NodeStmtIdentifierType.SingleVar)
            {
                Token ident = assign.singlevar.ident;
                string reg = m_FirstTempReg;
                Var var = m_vars.GetVariable(ident.Value, m_inputFilePath, ident.Line); 
                GenExpr(assign.singlevar.expr, reg, var.TypeSize);

                uint relative_location = 0;
                string BaseReg = "sp";
                if (var.IsGlobal)
                {
                    BaseReg = m_SecondTempReg;
                    m_outputcode.AppendLine($"    LA {BaseReg}, {var.Value}");
                }
                else
                {
                    relative_location = m_StackSize - m_vars.GetVariableLocation(ident.Value) - var.TypeSize;
                }

                if (var.TypeSize == 1)
                    m_outputcode.AppendLine($"    SB {reg}, {relative_location}({BaseReg})");
                else if (var.TypeSize == 8)
                    m_outputcode.AppendLine($"    SD {reg}, {relative_location}({BaseReg})");
                else
                    Shartilities.UNREACHABLE("GenTerm:Ident:SingleVar");
                return;
            }
            else if (assign.type == NodeStmtIdentifierType.Array)
            {
                Token ident = assign.array.ident;
                Var var = m_vars.GetVariable(ident.Value, m_inputFilePath, ident.Line); 
                string reg_addr = m_FirstTempReg;
                string reg_data = m_SecondTempReg;
                if (var.IsParameter)
                {
                    if (var.IsGlobal)
                        Shartilities.Log(Shartilities.LogType.ERROR, $"cannot put global variable as a parameter\n", 1);
                    uint relative_location_of_base_reg = m_StackSize - m_vars.GetVariableLocation(ident.Value) - 8;
                    GenArrayAddr(assign.array.indexes, var, relative_location_of_base_reg);
                }
                else
                {
                    if (var.IsGlobal)
                    {
                        GenArrayIndex(assign.array.indexes, var.Dimensions, var, reg_data);
                        m_outputcode.AppendLine($"    LA {reg_addr}, {var.Value}");
                        m_outputcode.AppendLine($"    ADD {reg_addr}, {reg_addr}, {reg_data}");
                        GenPush(reg_addr);
                    }
                    else
                    {
                        GenArrayAddr(assign.array.indexes, var);
                    }
                }
                GenExpr(assign.array.expr, reg_data, var.TypeSize);
                GenPop(reg_addr);

                if (var.TypeSize == 1)
                    m_outputcode.AppendLine($"    SB {reg_data}, 0({reg_addr})");
                else if (var.TypeSize == 8)
                    m_outputcode.AppendLine($"    SD {reg_data}, 0({reg_addr})");
                else
                    Shartilities.UNREACHABLE("not valid size");
                return;
            }
            Shartilities.UNREACHABLE("not valid identifier type");
        }
        NodeStmtFunction CheckFunctionCallCorrectness(NodeStmtFunctionCall CalledFunction)
        {
            if (m_UserDefinedFunctions.TryGetValue(CalledFunction.FunctionName.Value, out NodeStmtFunction CalledFunctionDefinition))
            {
                int MaxParamsCount = 7;
                int ProvidedParamsCount = CalledFunction.parameters.Count;
                if (ProvidedParamsCount > MaxParamsCount)
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{CalledFunction.FunctionName.Line}:1: Generator: Function call to `{CalledFunctionDefinition.FunctionName.Value}` provided too much parameters to function (bigger than {MaxParamsCount})\n", 1);
                if (CalledFunctionDefinition.parameters.Count > 0 && CalledFunctionDefinition.parameters[^1].IsVariadic)
                {
                    if (ProvidedParamsCount < CalledFunctionDefinition.parameters.Count - 1)
                        Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{CalledFunction.FunctionName.Line}:1: Generator: Function call to `{CalledFunctionDefinition.FunctionName.Value}` is not valid, check function arity\n", 1);
                }
                else
                {
                    if (ProvidedParamsCount != CalledFunctionDefinition.parameters.Count)
                        Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{CalledFunction.FunctionName.Line}:1: Generator: Function call to `{CalledFunctionDefinition.FunctionName.Value}` is not valid, check function arity\n", 1);
                }
                return CalledFunctionDefinition;
            }
            else if (!STD_FUNCTIONS.Contains(CalledFunction.FunctionName.Value))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{CalledFunction.FunctionName.Line}:1: Generator: Function `{CalledFunction.FunctionName.Value}` is not defined\n", 1);
            }
            return new();
        }
        void FillParametersOfFunction(NodeStmtFunctionCall CalledFunction, NodeStmtFunction CalledFunctionDefinition)
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
                        GenExpr(CalledFunction.parameters[i], $"a{i}", CalledFunctionDefinition.parameters[i].TypeSize);
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
        void GenStmtFunctionCall(NodeStmtFunctionCall CalledFunction, bool WillPushParams)
        {
            NodeStmtFunction CalledFunctionDefinition = CheckFunctionCallCorrectness(CalledFunction);
            if (!m_CalledFunctions.Contains(CalledFunction.FunctionName.Value))
                m_CalledFunctions.Add(CalledFunction.FunctionName.Value);
            List<string> regs = [];
            {
                if (WillPushParams)
                {
                    for (int i = 0; i < CalledFunction.parameters.Count; i++)
                    {
                        regs.Add($"a{i}");
                    }
                    GenPushMany(regs);
                }
            }
            FillParametersOfFunction(CalledFunction, CalledFunctionDefinition);
            m_outputcode.AppendLine($"    call {CalledFunction.FunctionName.Value}");
            {
                if (WillPushParams)
                {
                    GenPopMany(regs);
                }
            }
        }
        void GenPushFunctionParametersInDefinition(List<Var> parameters)
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
                        m_vars.AddVariable(new($"variadic({j - i})", 8, 8, [], false, true, true));
                    }
                    break;
                }
                else
                {
                    uint TypeSize = parameters[i].TypeSize;
                    uint Size = parameters[i].Size;
                    bool IsArray = parameters[i].IsArray;
                    if (IsArray)
                        GenPush($"a{i}");
                    else
                        GenPush($"a{i}", TypeSize);
                    m_vars.AddVariable(new(parameters[i].Value, Size, TypeSize, parameters[i].Dimensions, IsArray, true, false));
                }
            }
        }
        List<Var> Globals = [];
        void GetGlobalVariables(bool GenExpressions)
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
        void GenFunctionPrologue(string FunctionName)
        {
            m_vars.Reset();
            m_StackSize = new();
            m_scopes = new();
            m_scopestart = new();
            m_scopeend = new();
            m_CurrentFunctionName = FunctionName;
            m_outputcode.AppendLine($"{FunctionName}:");

            GenPush("ra");
            m_vars.AddVariable(new("", 8, 8, [], false, false, false));
            GenPushFunctionParametersInDefinition(m_UserDefinedFunctions[FunctionName].parameters);
        }
        void GenFunctionBody()
        {
            NodeStmtScope FunctionBody = m_UserDefinedFunctions[m_CurrentFunctionName].FunctionBody;
            foreach (NodeStmt stmt in FunctionBody.stmts)
                GenStmt(stmt);
        }
        void GenFunctionEpilogue()
        {
            NodeStmtScope FunctionBody = m_UserDefinedFunctions[m_CurrentFunctionName].FunctionBody;
            if (FunctionBody.stmts.Count == 0 || FunctionBody.stmts[^1].type != NodeStmt.NodeStmtType.Return)
            {
                m_outputcode.AppendLine($"    mv s0, zero");
                GenReturnFromFunction();
            }
        }
        void GenReturnFromFunction()
        {
            uint AllocatedStackSize = m_vars.GetAllocatedStackSize();
            Shartilities.Assert(AllocatedStackSize == m_StackSize, $"stack sizes are not equal");
            if (m_CurrentFunctionName == "main")
            {
                GenPop(m_StackSize, false);
                m_outputcode.AppendLine($"    mv a0, s0");
                m_outputcode.AppendLine($"    call exit");
                return;
            }
            GenPop(AllocatedStackSize, false);
            m_outputcode.AppendLine($"    LD ra, -8(sp)");
            m_outputcode.AppendLine($"    ret");
        }
        void GenFunction(string FunctionName)
        {
            GenFunctionPrologue(FunctionName);
            GenFunctionBody();
            GenFunctionEpilogue();
        }
        void GenBinExpr(NodeBinExpr binExpr, string? DestReg, uint size)
        {
            string reg = DestReg ?? m_FirstTempReg;
            string reg2 = reg == m_FirstTempReg ? m_SecondTempReg : m_FirstTempReg;
            GenExpr(binExpr.rhs, null, size);
            GenExpr(binExpr.lhs, reg, size);
            GenPop(reg2, size);
            switch (binExpr.type)
            {
                case NodeBinExpr.NodeBinExprType.Add:
                    m_outputcode.AppendLine($"    ADD {reg}, {reg}, {reg2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Sub:
                    m_outputcode.AppendLine($"    SUB {reg}, {reg}, {reg2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Sll:
                    m_outputcode.AppendLine($"    SLL {reg}, {reg}, {reg2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Srl:
                    m_outputcode.AppendLine($"    SRL {reg}, {reg}, {reg2}");
                    break;
                case NodeBinExpr.NodeBinExprType.EqualEqual:
                    m_outputcode.AppendLine($"    XOR {reg}, {reg}, {reg2}");
                    m_outputcode.AppendLine($"    SEQZ {reg}, {reg}");
                    break;
                case NodeBinExpr.NodeBinExprType.NotEqual:
                    m_outputcode.AppendLine($"    XOR {reg}, {reg}, {reg2}");
                    m_outputcode.AppendLine($"    SNEZ {reg}, {reg}");
                    break;
                case NodeBinExpr.NodeBinExprType.LessThan:
                    m_outputcode.AppendLine($"    SLT {reg}, {reg}, {reg2}");
                    break;
                case NodeBinExpr.NodeBinExprType.And:
                    m_outputcode.AppendLine($"    AND {reg}, {reg}, {reg2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Or:
                    m_outputcode.AppendLine($"    OR {reg}, {reg}, {reg2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Xor:
                    m_outputcode.AppendLine($"    XOR {reg}, {reg}, {reg2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Mul:
                    m_outputcode.AppendLine($"    MUL {reg}, {reg}, {reg2}");
                    //m_outputcode.AppendLine($"    MULH {reg}, {reg}, {reg2}"); // for upper 64-bit of the multiplication
                    break;
                case NodeBinExpr.NodeBinExprType.Rem:
                    m_outputcode.AppendLine($"    rem {reg}, {reg}, {reg2}");
                    break;
                case NodeBinExpr.NodeBinExprType.Div:
                    m_outputcode.AppendLine($"    div {reg}, {reg}, {reg2}");
                    break;
                default:
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: invalid binary operator `{binExpr.type}`\n", 1);
                    return;
            }
            if (DestReg == null)
                GenPush(reg, size);
        }
        void GenElifs(NodeIfElifs elifs, string label_end)
        {
            if (elifs.type == NodeIfElifs.NodeIfElifsType.Elif)
            {
                string reg = m_FirstTempReg;
                string label = $"LABEL{m_labels_count++}_elifs";
                GenExpr(elifs.elif.pred.cond, reg);
                m_outputcode.AppendLine($"    BEQZ {reg}, {label}");
                GenScope(elifs.elif.pred.scope);
                m_outputcode.AppendLine($"    J {label_end}");
                if (elifs.elif.elifs.HasValue)
                {
                    m_outputcode.AppendLine($"    J {label_end}");
                    m_outputcode.AppendLine($"{label}:");
                    GenElifs(elifs.elif.elifs.Value, label_end);
                }
                else
                {
                    m_outputcode.AppendLine($"{label}:");
                }
            }
            else if (elifs.type == NodeIfElifs.NodeIfElifsType.Else)
            {
                GenScope(elifs.elsee.scope);
            }
            else
                Shartilities.UNREACHABLE("GenElifs");
        }
        string GenStmtIF(NodeStmtIF iff)
        {
            string reg = m_FirstTempReg;
            string label_start = $"LABEL{m_labels_count++}_START";
            string label_end = $"LABEL{m_labels_count++}_END";
            string label = $"LABEL{m_labels_count++}_elifs";

            m_outputcode.AppendLine($"{label_start}:");
            GenExpr(iff.pred.cond, reg);
            m_outputcode.AppendLine($"    BEQZ {reg}, {label}");
            GenScope(iff.pred.scope);
            if (iff.elifs.HasValue)
            {
                m_outputcode.AppendLine($"    J {label_end}");
                m_outputcode.AppendLine($"{label}:");
                GenElifs(iff.elifs.Value, label_end);
            }
            else
            {
                m_outputcode.AppendLine($"{label}:");
            }
            m_outputcode.AppendLine($"{label_end}:");
            return label_start;
        }
        void GenStmtFor(NodeStmtFor forr)
        {
            m_outputcode.AppendLine($"# begin forloop");
            BeginScope();
            if (forr.pred.init.HasValue)
            {
                m_outputcode.AppendLine($"# begin init");
                if (forr.pred.init.Value.type == NodeForInit.NodeForInitType.Declare)
                    m_vars.AddVariable(GenStmtDeclare(forr.pred.init.Value.declare, true));
                else if (forr.pred.init.Value.type == NodeForInit.NodeForInitType.Assign)
                    GenStmtAssign(forr.pred.init.Value.assign);
                else
                    Shartilities.UNREACHABLE("not valid for init statement");
                m_outputcode.AppendLine($"# end init");
            }
            if (forr.pred.cond.HasValue)
            {
                m_outputcode.AppendLine($"# begin condition");
                string label_start = $"TEMP_LABEL{m_labels_count++}_START";
                string label_end = $"TEMP_LABEL{m_labels_count++}_END";
                string label_update = $"TEMP_LABEL{m_labels_count++}_START";

                m_outputcode.AppendLine($"{label_start}:");
                string reg = m_FirstTempReg;
                GenExpr(forr.pred.cond.Value.cond, reg);
                m_outputcode.AppendLine($"    BEQZ {reg}, {label_end}");
                m_outputcode.AppendLine($"# end condition");
                m_scopestart.Push(label_update);
                m_scopeend.Push(label_end);
                GenScope(forr.pred.scope);
                m_scopestart.Pop();
                m_scopeend.Pop();
                m_outputcode.AppendLine($"# begin update");
                m_outputcode.AppendLine($"{label_update}:");
                if (forr.pred.udpate.updates.Count != 0)
                {
                    for (int i = 0; i < forr.pred.udpate.updates.Count; i++)
                    {
                        GenStmtAssign(forr.pred.udpate.updates[i]);
                    }
                }
                m_outputcode.AppendLine($"# end update");
                m_outputcode.AppendLine($"    J {label_start}");
                m_outputcode.AppendLine($"{label_end}:");
            }
            else if (forr.pred.udpate.updates.Count != 0)
            {
                string label_start = $"TEMP_LABEL{m_labels_count++}_START";
                string label_end = $"TEMP_LABEL{m_labels_count++}_END";
                string label_update = $"TEMP_LABEL{m_labels_count++}_START";

                m_outputcode.AppendLine($"{label_start}:");
                m_scopestart.Push(label_update);
                m_scopeend.Push(label_end);
                GenScope(forr.pred.scope);
                m_scopestart.Pop();
                m_scopeend.Pop();
                m_outputcode.AppendLine($"# begin update");
                m_outputcode.AppendLine($"{label_update}:");
                for (int i = 0; i < forr.pred.udpate.updates.Count; i++)
                {
                    GenStmtAssign(forr.pred.udpate.updates[i]);
                }
                m_outputcode.AppendLine($"# end update");
                m_outputcode.AppendLine($"    J {label_start}");
                m_outputcode.AppendLine($"{label_end}:");
            }
            else
            {
                string label_start = $"TEMP_LABEL{m_labels_count++}_START";
                string label_end = $"TEMP_LABEL{m_labels_count++}_END";

                m_outputcode.AppendLine($"{label_start}:");
                m_scopestart.Push(label_start);
                m_scopeend.Push(label_end);
                GenScope(forr.pred.scope);
                m_scopestart.Pop();
                m_scopeend.Pop();
                m_outputcode.AppendLine($"    J {label_start}");
                m_outputcode.AppendLine($"{label_end}:");
            }
            EndScope();
            m_outputcode.AppendLine($"# end forloop");
        }
        void GenStmtWhile(NodeStmtWhile whilee)
        {
            m_outputcode.AppendLine($"# begin whileloop");
            BeginScope();
            m_outputcode.AppendLine($"# begin condition");
            string label_start = $"TEMP_LABEL{m_labels_count++}_START";
            string label_end = $"TEMP_LABEL{m_labels_count++}_END";

            m_outputcode.AppendLine($"{label_start}:");
            string reg = m_FirstTempReg;
            GenExpr(whilee.cond, reg);
            m_outputcode.AppendLine($"    BEQZ {reg}, {label_end}");
            m_outputcode.AppendLine($"# end condition");
            m_scopestart.Push(label_start);
            m_scopeend.Push(label_end);
            GenScope(whilee.scope);
            m_scopestart.Pop();
            m_scopeend.Pop();
            m_outputcode.AppendLine($"    J {label_start}");
            m_outputcode.AppendLine($"{label_end}:");
            EndScope();
            m_outputcode.AppendLine($"# end whileloop");
        }
        void GenStmtBreak(NodeStmtBreak breakk)
        {
            if (m_scopeend.Count == 0)
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{breakk.breakk.Line}:1: Generator: no enclosing loop out of which to break from\n", 1);
            }
            m_outputcode.AppendLine($"    J {m_scopeend.Peek()}");
        }
        void GenStmtContinue(NodeStmtContinuee continuee)
        {
            if (m_scopestart.Count == 0)
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{continuee.continuee.Line}:1: Generator: no enclosing loop out of which to continue\n", 1);
            }
            m_outputcode.AppendLine($"    J {m_scopestart.Peek()}");
        }
        void GenStmtExit(NodeStmtExit exit)
        {
            string reg = "a0";
            GenExpr(exit.expr, reg);
            m_outputcode.AppendLine($"    call exit");
        }
        void GenStmtReturn(NodeStmtReturn returnn)
        {
            GenExpr(returnn.expr, "s0");
            GenReturnFromFunction();
        }
        void GenStmt(NodeStmt stmt)
        {
            if (stmt.type == NodeStmt.NodeStmtType.Declare)
            {
                m_vars.AddVariable(GenStmtDeclare(stmt.declare, true));
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
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: invalid statement `{stmt.type}`\n", 1);
            }
        }
        void GenStdFunctions()
        {
            m_outputcode.AppendLine($"exit:");
            m_outputcode.AppendLine($"    li a7, 93");
            m_outputcode.AppendLine($"    ecall");
            m_outputcode.AppendLine($"    ret");
            if (m_CalledFunctions.Contains("strlen"))
            {
                m_outputcode.AppendLine($"strlen:");
                m_outputcode.AppendLine($"    mv t0, a0");
                m_outputcode.AppendLine($"    li s0, 0");
                m_outputcode.AppendLine($"strlen_loop:");
                m_outputcode.AppendLine($"    lbu t1, 0(t0)");
                m_outputcode.AppendLine($"    beqz t1, strlen_done");
                m_outputcode.AppendLine($"    ADDI s0, s0, 1");
                m_outputcode.AppendLine($"    ADDI t0, t0, 1");
                m_outputcode.AppendLine($"    j strlen_loop");
                m_outputcode.AppendLine($"strlen_done:");
                m_outputcode.AppendLine($"    ret");
            }
            if (m_CalledFunctions.Contains("stoa"))
            {
                m_outputcode.AppendLine($"stoa:");
                m_outputcode.AppendLine($"    mv t1, a0");
                //m_outputcode.AppendLine($"    ADDI t2, a1, 32");
                m_outputcode.AppendLine($"    la t2, itoaTempBuffer");
                m_outputcode.AppendLine($"    ADDI t2, t2, 32");
                m_outputcode.AppendLine($"    sb zero, 0(t2)");
                m_outputcode.AppendLine($"stoa_loop:");
                m_outputcode.AppendLine($"    beqz t1, stoa_done");
                m_outputcode.AppendLine($"    li t3, 10");
                m_outputcode.AppendLine($"    rem t4, t1, t3");
                m_outputcode.AppendLine($"    ADDI t4, t4, 48");
                m_outputcode.AppendLine($"    ADDI t2, t2, -1");
                m_outputcode.AppendLine($"    sb t4, 0(t2)");
                m_outputcode.AppendLine($"    div t1, t1, t3");
                m_outputcode.AppendLine($"    j stoa_loop");
                m_outputcode.AppendLine($"stoa_done:");
                m_outputcode.AppendLine($"    mv s0, t2");
                m_outputcode.AppendLine($"    ret");
            }
            if (m_CalledFunctions.Contains("unstoa"))
            {
                m_outputcode.AppendLine($"unstoa:");
                m_outputcode.AppendLine($"    mv t1, a0");
                //m_outputcode.AppendLine($"    ADDI t2, a1, 32");
                m_outputcode.AppendLine($"    la t2, itoaTempBuffer");
                m_outputcode.AppendLine($"    ADDI t2, t2, 32");
                m_outputcode.AppendLine($"    sb zero, 0(t2)");
                m_outputcode.AppendLine($"unstoa_loop:");
                m_outputcode.AppendLine($"    beqz t1, unstoa_done");
                m_outputcode.AppendLine($"    li t3, 10");
                m_outputcode.AppendLine($"    remu t4, t1, t3");
                m_outputcode.AppendLine($"    ADDI t4, t4, 48");
                m_outputcode.AppendLine($"    ADDI t2, t2, -1");
                m_outputcode.AppendLine($"    sb t4, 0(t2)");
                m_outputcode.AppendLine($"    divu t1, t1, t3");
                m_outputcode.AppendLine($"    j unstoa_loop");
                m_outputcode.AppendLine($"unstoa_done:");
                m_outputcode.AppendLine($"    mv s0, t2");
                m_outputcode.AppendLine($"    ret");
            }
            if (m_CalledFunctions.Contains("write"))
            {
                m_outputcode.AppendLine($"write:");
                m_outputcode.AppendLine($"    li a7, 64");
                m_outputcode.AppendLine($"    ecall");
                m_outputcode.AppendLine($"    ret");
            }
        }
        void GenProgramPrologue()
        {
            m_outputcode.AppendLine($".section .text");
            m_outputcode.AppendLine($".globl main");
            if (!m_UserDefinedFunctions.ContainsKey("main"))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: no entry point `main` is defined\n", 1);
            }
            GetGlobalVariables(false);
            m_vars.m_globals = [.. Globals];
        }
        void GenProgramEpilogue()
        {

        }
        void GenProgramDataSection()
        {
            m_outputcode.AppendLine($".section .data");
            for (int i = 0; i < Globals.Count; i++)
            {
                m_outputcode.AppendLine($"{Globals[i].Value}:");
                uint count = Globals[i].IsArray ? Globals[i].Size : Globals[i].TypeSize;
                m_outputcode.AppendLine($"    .space {count}");
            }
            for (int i = 0; i < m_StringLits.Count; i++)
            {
                m_outputcode.AppendLine($"StringLits{i}:");
                m_outputcode.AppendLine($"    .string \"{m_StringLits[i]}\"");
            }
            if (!m_UserDefinedFunctions.ContainsKey("stoa") && m_CalledFunctions.Contains("stoa")
            && !m_UserDefinedFunctions.ContainsKey("unstoa") && m_CalledFunctions.Contains("unstoa"))
            {
                m_outputcode.AppendLine($".section .bss");
                m_outputcode.AppendLine($"itoaTempBuffer:     ");
                m_outputcode.AppendLine($"    .space 32");
            }
        }
        void GenProgramFunctions()
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
        public StringBuilder GenProgram()
        {
            GenProgramPrologue();
            GenProgramFunctions();
            GenProgramDataSection();
            GenProgramEpilogue();
            return m_outputcode;
        }
    }
}