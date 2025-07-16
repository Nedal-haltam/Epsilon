using System.Collections.Generic;
using System.Text;

namespace Epsilon
{
    public struct Var(string value, uint size, uint TypeSize, bool IsArray, bool IsParameter, bool IsVariadic)
    {
        public uint TypeSize { get; set; } = TypeSize;
        public string Value { get; set; } = value;
        public uint Size { get; set; } = size;
        public bool IsParameter = IsParameter;
        public bool IsArray = IsArray;
        public bool IsVariadic = IsVariadic;
    }
    class RISCVGenerator(NodeProg prog, Dictionary<string, NodeStmtFunction> UserDefinedFunctions, string InputFilePath, List<string> std_functions)
    {
        public readonly string m_FirstTempReg = "t0";
        public readonly string m_SecondTempReg = "t1";
        public readonly StringBuilder m_outputcode = new();
        public int m_labels_count = 0;
        public readonly List<string> m_CalledFunctions = [];
        public List<string> m_StringLits = [];

        private readonly string m_inputFilePath = InputFilePath;
        public NodeProg m_prog = prog;
        public Dictionary<string, NodeStmtFunction> m_UserDefinedFunctions = UserDefinedFunctions;

        public Dictionary<string, List<uint>> m_DimensionsOfArrays = [];
        public List<Var> m_vars = [];
        public Stack<int> m_scopes = [];
        public uint m_StackSize;
        public Stack<string?> m_scopestart = new();
        public Stack<string?> m_scopeend = new();
        public List<Var> m_parameters = [];
        public string m_CurrentFunction = "NO_FUNCTION_NAME";
        readonly List<string> STD_FUNCTIONS = std_functions;


        void GenPush(string reg, uint size)
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
        void GenPushMany(List<string> regs)
        {
            m_outputcode.AppendLine($"    ADDI sp, sp, -{regs.Count * 8}");
            for (int i = 0; i < regs.Count; i++)
            {
                m_outputcode.AppendLine($"    SD {regs[i]}, {8 * i}(sp)");
            }
            m_StackSize += (uint)(8 * regs.Count);
        }

        void GenPop(string reg, uint size)
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
            m_scopes.Push(m_vars.Count);
        }
        void EndScope()
        {
            m_outputcode.AppendLine($"# end scope");
            int Vars_topop = m_vars.Count - m_scopes.Pop();
            int i = m_vars.Count - 1;
            int iterations = Vars_topop;
            uint popcount = 0;
            while (iterations-- > 0)
            {
                popcount += m_vars[i--].Size;
            }
            StackPopEndScope(popcount);
            m_StackSize -= popcount;
            m_vars.RemoveRange(m_vars.Count - Vars_topop, Vars_topop);
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
        uint VariableLocation(string name)
        {
            uint size = 0;
            int index = m_vars.FindIndex(x => x.Value == name);
            for (int i = 0; i < index; i++)
            {
                if (m_vars[i].IsArray && m_vars[i].IsParameter)
                    size += 8;
                else
                    size += m_vars[i].Size;
            }
            return size;
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
            if (i == dims.Count - 1)
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
        void GenArrayAddrFrom_m_vars(List<NodeExpr> indexes, Var var, uint? relative_location_of_base_reg = null)
        {
            m_outputcode.AppendLine($"# begin array address");
            string reg = m_FirstTempReg;

            if (!var.IsArray)
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: variable `{var.Value}` is not declared as an array\n", 1);

            List<uint> dims = m_DimensionsOfArrays[var.Value];
            Shartilities.Assert(var.IsVariadic || indexes.Count == dims.Count, "Generator: indexes and dimensionality are not equal");

            NodeExpr IndexExpr = GenIndexExpr(ref indexes, ref dims, 0);
            GenExpr(
                NodeExpr.BinExpr(
                    NodeBinExpr.NodeBinExprType.Mul,
                    NodeExpr.Number(var.TypeSize.ToString(), -1),
                    IndexExpr), 
                reg, 8
            );

            string BaseReg = "sp";
            if (relative_location_of_base_reg.HasValue)
            {
                BaseReg = m_SecondTempReg;
                m_outputcode.AppendLine($"    LD {BaseReg}, {relative_location_of_base_reg}(sp)");
            }
            m_outputcode.AppendLine($"    ADD {reg}, {BaseReg}, {reg}");

            if (BaseReg == "sp")
            {
                uint relative_location = m_StackSize - VariableLocation(var.Value) - var.Size;
                m_outputcode.AppendLine($"    ADDI {reg}, {reg}, {relative_location}");
            }

            GenPush(reg, 8);
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
                        int index = m_vars.FindIndex(x => x.Value == ident.ident.Value);
                        if (index != -1)
                        {
                            Var var = m_vars[index];
                            uint TypeSize = var.IsArray && var.IsParameter ? 8 : var.TypeSize;
                            uint Count = var.Size / var.TypeSize;
                            uint relative_location = m_StackSize - VariableLocation(var.Value) - TypeSize;
                            if (!var.IsParameter)
                                m_outputcode.AppendLine($"    ADDI {reg}, sp, {relative_location - (TypeSize * (Count - 1))}");
                            else
                                m_outputcode.AppendLine($"    ADDI {reg}, sp, {relative_location}");
                        }
                        else
                        {
                            Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{ident.ident.Line}:1:  variable `{ident.ident.Value}` is undeclared\n", 1);
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
                if (ident.indexes.Count == 0)
                {
                    int index = m_vars.FindIndex(x => x.Value == ident.ident.Value);
                    if (index != -1)
                    {
                        Var var = m_vars[index];
                        string reg = DestReg ?? m_FirstTempReg;
                        uint TypeSize = var.IsArray && var.IsParameter ? 8 : var.TypeSize;
                        uint Count = var.Size / var.TypeSize;
                        uint relative_location = m_StackSize - VariableLocation(var.Value) - TypeSize;

                        if (ident.ByRef)
                        {
                            if (!var.IsParameter)
                                m_outputcode.AppendLine($"    ADDI {reg}, sp, {relative_location - (TypeSize * (Count - 1))}");
                            else
                                m_outputcode.AppendLine($"    LD {reg}, {relative_location}(sp)");
                        }
                        else
                        {
                            if (TypeSize == 1)
                                m_outputcode.AppendLine($"    LB {reg}, {relative_location}(sp)");
                            else if (TypeSize == 8)
                                m_outputcode.AppendLine($"    LD {reg}, {relative_location}(sp)");
                            else
                                Shartilities.UNREACHABLE("GenTerm:Ident:SingleVar");
                        }
                        if (DestReg == null)
                            GenPush(reg, size);
                    }
                    else
                    {
                        Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{ident.ident.Line}:1:  variable `{ident.ident.Value}` is undeclared\n", 1);
                    }
                }
                else
                {
                    string reg = DestReg ?? m_FirstTempReg;
                    string reg_addr = reg == m_FirstTempReg ? m_SecondTempReg : m_FirstTempReg;
                    int index = m_vars.FindIndex(x => x.Value == ident.ident.Value);
                    if (index != -1)
                    {
                        Var var = m_vars[index];
                        if (var.IsParameter)
                        {
                            uint relative_location_of_base_reg = m_StackSize - VariableLocation(ident.ident.Value) - 8;
                            GenArrayAddrFrom_m_vars(ident.indexes, var, relative_location_of_base_reg);
                        }
                        else
                        {
                            GenArrayAddrFrom_m_vars(ident.indexes, var);
                        }
                        GenPop(reg_addr, 8);

                        if (var.TypeSize == 1)
                            m_outputcode.AppendLine($"    LB {reg}, 0({reg_addr})");
                        else if (var.TypeSize == 8)
                            m_outputcode.AppendLine($"    LD {reg}, 0({reg_addr})");
                        else
                            Shartilities.UNREACHABLE("No valid size");

                        if (DestReg == null)
                            GenPush(reg, size);
                    }
                    else
                    {
                        Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{ident.ident.Line}:1: variable `{ident.ident.Value}` is not declared\n", 1);
                    }
                }
            }
            else if (term.type == NodeTerm.NodeTermType.Variadic)
            {
                int index = m_vars.FindIndex(x => x.IsVariadic);
                if (index != -1)
                {
                    Var var = m_vars[index];
                    string reg = DestReg ?? m_FirstTempReg;
                    string reg_addr = reg == m_FirstTempReg ? m_SecondTempReg : m_FirstTempReg;
                    uint TypeSize = var.TypeSize;
                    uint Count = var.Size / var.TypeSize;
                    uint relative_location = m_StackSize - VariableLocation(var.Value) - 8;

                    GenExpr(NodeExpr.BinExpr(NodeBinExpr.NodeBinExprType.Mul, NodeExpr.Number("8", -1), term.variadic.VariadicIndex), reg_addr, 8);
                    m_outputcode.AppendLine($"    SUB {reg_addr}, sp, {reg_addr}");
                    m_outputcode.AppendLine($"    LD {reg}, {relative_location}({reg_addr})");

                    if (DestReg == null)
                        GenPush(reg, size);
                }
                else
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"no variadic are declared\n", 1);
                }

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
        void GenExpr(NodeExpr expr, string? DestReg, uint size)
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
                m_outputcode.AppendLine($"    ADDI sp, sp, -{size}");
                m_StackSize += size;
            }
            else
                Shartilities.UNREACHABLE("no valid expression");
        }
        void GenStmtDeclare(NodeStmtDeclare declare)
        {
            if (declare.type == NodeStmtIdentifierType.SingleVar)
            {
                Token ident = declare.singlevar.ident;
                if (m_vars.Any(x => x.Value == ident.Value))
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{ident.Line}:1: Generator: variable `{ident.Value}` is alread declared\n", 1);
                }
                else
                {
                    if (declare.datatype == NodeStmtDataType.Auto)
                    {
                        GenExpr(declare.singlevar.expr, null, 8);
                        m_vars.Add(new(ident.Value, 8, 8, false, false, false));
                    }
                    else if (declare.datatype == NodeStmtDataType.Char)
                    {
                        GenExpr(declare.singlevar.expr, null, 1);
                        m_vars.Add(new(ident.Value, 1, 1, false, false, false));
                    }
                    else
                        Shartilities.UNREACHABLE("not valid data type");
                }
            }
            else if (declare.type == NodeStmtIdentifierType.Array)
            {
                Token ident = declare.array.ident;
                if (m_vars.Any(x => x.Value == ident.Value))
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{ident.Line}:1: Generator: variable `{ident.Value}` is alread declared\n", 1);
                }
                else
                {
                    List<uint> dims = m_DimensionsOfArrays[ident.Value];
                    uint count = 1;
                    foreach (uint d in dims)
                    {
                        count *= d;
                    }
                    uint SizePerVar = 0;
                    if (declare.datatype == NodeStmtDataType.Auto)
                        SizePerVar = 8;
                    else if (declare.datatype == NodeStmtDataType.Char)
                        SizePerVar = 1;
                    else
                        Shartilities.UNREACHABLE("SizePerVar");

                    m_outputcode.AppendLine($"    ADDI sp, sp, -{SizePerVar * count}");
                    m_StackSize += SizePerVar * count;
                    m_vars.Add(new(ident.Value, SizePerVar * count, SizePerVar, true, false, false));
                }
            }
            else
                Shartilities.UNREACHABLE("not valid identifier type");
        }
        void GenStmtAssign(NodeStmtAssign assign)
        {
            if (assign.type == NodeStmtIdentifierType.SingleVar)
            {
                Token ident = assign.singlevar.ident;
                string reg = m_FirstTempReg;
                int index = m_vars.FindIndex(x => x.Value == ident.Value);
                if (index != -1)
                {
                    Var var = m_vars[index];
                    GenExpr(assign.singlevar.expr, reg, var.TypeSize);
                    uint relative_location = m_StackSize - VariableLocation(ident.Value);
                    if (var.TypeSize == 1)
                        m_outputcode.AppendLine($"    SB {reg}, {relative_location - var.TypeSize}(sp)");
                    if (var.TypeSize == 8)
                        m_outputcode.AppendLine($"    SD {reg}, {relative_location - var.TypeSize}(sp)");
                }
                else
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{ident.Line}:1: variable `{ident.Value}` is not declared\n", 1);
                }
            }
            else if (assign.type == NodeStmtIdentifierType.Array)
            {
                Token ident = assign.array.ident;
                int index = m_vars.FindIndex(x => x.Value == ident.Value);
                if (index != -1)
                {
                    string reg_addr = m_FirstTempReg;
                    string reg_data = m_SecondTempReg;
                    Var var = m_vars[index];
                    if (var.IsParameter)
                    {
                        uint relative_location_of_base_reg = m_StackSize - VariableLocation(ident.Value) - 8;
                        GenArrayAddrFrom_m_vars(assign.array.indexes, var, relative_location_of_base_reg);
                    }
                    else
                    {
                        GenArrayAddrFrom_m_vars(assign.array.indexes, var);
                    }

                    GenExpr(assign.array.expr, reg_data, var.TypeSize);
                    GenPop(reg_addr, 8);

                    if (var.TypeSize == 1)
                        m_outputcode.AppendLine($"    SB {reg_data}, 0({reg_addr})");
                    else if (var.TypeSize == 8)
                        m_outputcode.AppendLine($"    SD {reg_data}, 0({reg_addr})");
                    else
                        Shartilities.UNREACHABLE("not valid size");
                }
                else
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{ident.Line}:1: variable `{ident.Value}` is not declared\n", 1);
                }
            }
            else
                Shartilities.UNREACHABLE("not valid identifier type");
        }
        void GenElifs(NodeIfElifs elifs, string label_end)
        {
            if (elifs.type == NodeIfElifs.NodeIfElifsType.Elif)
            {
                string reg = m_FirstTempReg;
                string label = $"LABEL{m_labels_count++}_elifs";
                GenExpr(elifs.elif.pred.cond, reg, 8);
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
            GenExpr(iff.pred.cond, reg, 8);
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
                    GenStmtDeclare(forr.pred.init.Value.declare);
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
                GenExpr(forr.pred.cond.Value.cond, reg, 8);
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
            GenExpr(whilee.cond, reg, 8);
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
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{breakk.breakk.Line}:1: Generator: no enclosing loop out of which to break from on line {breakk.breakk.Line}\n", 1);
            }
            m_outputcode.AppendLine($"    J {m_scopeend.Peek()}");
        }
        void GenStmtContinue(NodeStmtContinuee continuee)
        {
            if (m_scopestart.Count == 0)
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{continuee.continuee.Line}:1: Generator: no enclosing loop out of which to continue on line {continuee.continuee.Line}\n", 1);
            }
            m_outputcode.AppendLine($"    J {m_scopestart.Peek()}");
        }
        void GenStmtFunctionCall(NodeStmtFunctionCall Function, bool WillPushParams)
        {
            if (m_UserDefinedFunctions.TryGetValue(Function.FunctionName.Value, out NodeStmtFunction CalledFunction))
            {
                int MaxParamsCount = 8;
                int ProvidedParamsCount = Function.parameters.Count;
                if (ProvidedParamsCount > MaxParamsCount)
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{Function.FunctionName.Line}:1: Generator: Function call to `{CalledFunction.FunctionName.Value}` provided too much parameters to function (bigger than {MaxParamsCount})\n", 1);
                if (CalledFunction.parameters.Count > 0 && CalledFunction.parameters[^1].IsVariadic)
                {
                    if (ProvidedParamsCount < CalledFunction.parameters.Count - 1)
                        Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{Function.FunctionName.Line}:1: Generator: Function call to `{CalledFunction.FunctionName.Value}` is not valid, check function arity\n", 1);
                }
                else
                {
                    if (ProvidedParamsCount != CalledFunction.parameters.Count)
                        Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{Function.FunctionName.Line}:1: Generator: Function call to `{CalledFunction.FunctionName.Value}` is not valid, check function arity\n", 1);
                }
            }
            else if (!STD_FUNCTIONS.Contains(Function.FunctionName.Value))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{Function.FunctionName.Line}:1: Generator: Function `{Function.FunctionName.Value}` is not defined\n", 1);
            }

            if (!m_CalledFunctions.Contains(Function.FunctionName.Value))
                m_CalledFunctions.Add(Function.FunctionName.Value);
            List<string> regs = [];
            if (WillPushParams)
            {
                for (int i = 0; i < Function.parameters.Count; i++)
                {
                    regs.Add($"a{i}");
                }
                GenPushMany(regs);
            }

            if (m_UserDefinedFunctions.ContainsKey(Function.FunctionName.Value))
            {
                for (int i = 0; i < Function.parameters.Count; i++)
                {
                    if (CalledFunction.parameters[i].IsVariadic)
                    {
                        Shartilities.Assert(i == CalledFunction.parameters.Count - 1, $"variadic should be the last argument\n");

                        for (int j = i; j < Function.parameters.Count; j++)
                        {
                            GenExpr(Function.parameters[j], $"a{j}", 8);
                        }
                        break;
                    }
                    else
                    {
                        GenExpr(Function.parameters[i], $"a{i}", CalledFunction.parameters[i].TypeSize);
                    }
                }
            }
            else
            {
                for (int i = 0; i < Function.parameters.Count; i++)
                {
                    GenExpr(Function.parameters[i], $"a{i}", 8);
                }
            }
            m_outputcode.AppendLine($"    call {Function.FunctionName.Value}");
            if (WillPushParams)
            {
                GenPopMany(regs);
            }
        }
        void GenReturnFromFunction()
        {
            uint stacksize = 0;
            foreach (Var v in m_vars)
            {
                if (v.IsParameter && v.IsArray)
                    stacksize += 8;
                else
                    stacksize += v.Size;
            }
            Shartilities.Assert(stacksize == m_StackSize, $"stack sizes are not equal");
            if (stacksize > 0)
                m_outputcode.AppendLine($"    ADDI sp, sp, {stacksize}");
            if (m_CurrentFunction == "main")
            {
                m_outputcode.AppendLine($"    mv a0, s0");
                m_outputcode.AppendLine($"    call exit");
            }
            else
            {
                m_outputcode.AppendLine($"    LD ra, 0(sp)");
                m_outputcode.AppendLine($"    ADDI sp, sp, 8");
                m_outputcode.AppendLine($"    ret");
            }
        }
        void GenFunctionDefinition(string FunctionName)
        {
            m_vars = [];
            m_scopes = new();
            m_StackSize = new();
            m_scopestart = new();
            m_scopeend = new();
            m_CurrentFunction = "NO_FUNCTION_NAME";
            m_DimensionsOfArrays = [];
            m_parameters = [];

            if (FunctionName != "main")
                m_outputcode.AppendLine($"{FunctionName}:");
            m_CurrentFunction = FunctionName;
            m_DimensionsOfArrays = m_UserDefinedFunctions[FunctionName].DimensionsOfArrays;
            m_parameters = m_UserDefinedFunctions[FunctionName].parameters;

            NodeStmtFunction Function = m_UserDefinedFunctions[m_CurrentFunction];


            if (m_CurrentFunction != "main")
            {
                m_outputcode.AppendLine($"    ADDI sp, sp, -8");
                m_outputcode.AppendLine($"    SD ra, 0(sp)");
            }
            for (int i = 0; i < Function.parameters.Count; i++)
            {
                if (Function.parameters[i].IsVariadic)
                {
                    Shartilities.Assert(i == Function.parameters.Count - 1, $"variadic should be the last argument\n");
                    // up until a7
                    for (int j = i; j <= 7; j++)
                    {
                        GenPush($"a{j}", 8);
                        m_vars.Add(new($"variadic({j - i})", 8, 8, false, true, true));
                    }
                    break;
                }
                else
                {
                    uint TypeSize = Function.parameters[i].TypeSize;
                    uint Size = Function.parameters[i].Size;
                    bool IsArray = Function.DimensionsOfArrays.ContainsKey(Function.parameters[i].Value);
                    if (IsArray)
                        GenPush($"a{i}", 8);
                    else
                        GenPush($"a{i}", TypeSize);
                    m_vars.Add(new(Function.parameters[i].Value, Size, TypeSize, IsArray, true, false));
                }
            }
            foreach (NodeStmt stmt in Function.FunctionBody.stmts)
            {
                GenStmt(stmt);
            }

            if (Function.FunctionBody.stmts.Count == 0 || Function.FunctionBody.stmts[^1].type != NodeStmt.NodeStmtType.Return)
            {
                m_outputcode.AppendLine($"    mv s0, zero");
                GenReturnFromFunction();
            }
        }
        void GenStmtExit(NodeStmtExit exit)
        {
            string reg = "a0";
            GenExpr(exit.expr, reg, 8);
            m_outputcode.AppendLine($"    call exit");
        }
        void GenStmtReturn(NodeStmtReturn returnn)
        {
            GenExpr(returnn.expr, "s0", 8);
            GenReturnFromFunction();
        }
        void GenStmt(NodeStmt stmt)
        {
            if (stmt.type == NodeStmt.NodeStmtType.Declare)
            {
                GenStmtDeclare(stmt.declare);
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
        public StringBuilder GenProg()
        {
            string MainFunctionName = "main";
            m_outputcode.AppendLine($".section .text");
            m_outputcode.AppendLine($".globl {MainFunctionName}");

            if (!m_UserDefinedFunctions.ContainsKey("main"))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: no entry point `main` is defined\n", 1);
            }
            m_outputcode.AppendLine($"{MainFunctionName}:");
            GenFunctionDefinition("main");
            for (int i = 0; i < m_CalledFunctions.Count; i++)
            {
                if (m_UserDefinedFunctions.ContainsKey(m_CalledFunctions[i]))
                {
                    GenFunctionDefinition(m_CalledFunctions[i]);
                }
            }

            GenStdFunctions();
            if (m_StringLits.Count > 0)
                m_outputcode.AppendLine($".section .data");
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
            return m_outputcode;
        }
    }
}