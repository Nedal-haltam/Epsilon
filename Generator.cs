using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using static System.Formats.Asn1.AsnWriter;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Epsilon
{
    public struct Var(string value, int size, int TypeSize)
    {
        public int TypeSize { get; set; } = TypeSize;
        public string Value { get; set; } = value;
        public int Size { get; set; } = size;
    }
    class Generator
    {
        public readonly string m_FirstTempReg = "t0";
        public readonly string m_SecondTempReg = "t1";
        public NodeProg m_prog;
        public readonly StringBuilder m_outputcode = new();
        public int m_labels_count = 0;
        public Dictionary<string, NodeStmtFunction> m_UserDefinedFunctions = [];
        public readonly List<string> m_CalledFunctions = [];
        public List<string> m_StringLits = [];

        public List<Var> m_vars = [];
        public Stack<int> m_scopes = [];
        public int m_StackSize;
        public Stack<string?> m_scopestart = new();
        public Stack<string?> m_scopeend = new();
        public Dictionary<string, List<NodeTermIntLit>> m_DimensionsOfArrays = [];
        public List<Var> m_parameters = [];
        public string m_CurrentFunction = "NO_FUNCTION_NAME";
        public static string GetImmedOperation(string imm1, string imm2, NodeBinExpr.NodeBinExprType op)
        {
            if (op == NodeBinExpr.NodeBinExprType.Add)
                return (Convert.ToInt32(imm1) + Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Sub)
                return (Convert.ToInt32(imm1) - Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Sll)
                return (Convert.ToInt32(imm1) << Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Srl)
                return (Convert.ToInt32(imm1) >> Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.EqualEqual)
                return (Convert.ToInt32(imm1) == Convert.ToInt32(imm2) ? 1 : 0).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.NotEqual)
                return (Convert.ToInt32(imm1) != Convert.ToInt32(imm2) ? 1 : 0).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.LessThan)
                return (Convert.ToInt32(imm1) < Convert.ToInt32(imm2) ? 1 : 0).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.And)
                return (Convert.ToInt32(imm1) & Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Or)
                return (Convert.ToInt32(imm1) | Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Xor)
                return (Convert.ToInt32(imm1) ^ Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Mul)
                return (Convert.ToInt32(imm1) * Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Div)
                return (Convert.ToInt32(imm1) / Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Rem)
                return (Convert.ToInt32(imm1) % Convert.ToInt32(imm2)).ToString();
            Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: invalid operation `{op}`\n");
            Environment.Exit(1);
            return "";
        }
    }
    class RISCVGenerator : Generator
    {
        public RISCVGenerator(NodeProg prog, Dictionary<string, List<NodeTermIntLit>> Arraydims, Dictionary<string, NodeStmtFunction> UserDefinedFunctions)
        {
            m_prog = prog;
            m_DimensionsOfArrays = Arraydims;
            m_UserDefinedFunctions = UserDefinedFunctions;
        }

        void GenPush(string reg, int size)
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
            m_StackSize += 8 * regs.Count;
        }

        void GenPop(string reg, int size)
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
            m_StackSize -= 8 * regs.Count;
        }
        void StackPopEndScope(int popcount)
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
            int popcount = 0;
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
        int VariableLocationm_vars(string name)
        {
            int size = 0;
            for (int i = 0; i < m_vars.Count; i++)
            {
                if (m_vars[i].Value == name)
                {
                    break;
                }
                else
                {
                    if (m_DimensionsOfArrays.ContainsKey(m_vars[i].Value) && m_parameters.Any(x => x.Value == m_vars[i].Value))
                        size += 8;
                    else
                        size += m_vars[i].Size;
                }
            }
            return size;
        }
        static NodeExpr GenIndexExprMult(ref List<NodeExpr> indexes, ref List<NodeTermIntLit> dims, int i)
        {
            NodeExpr expr = new();
            if (i == dims.Count - 1)
            {
                expr.type = NodeExpr.NodeExprType.Term;
                expr.term = new()
                {
                    type = NodeTerm.NodeTermType.IntLit,
                    intlit = new()
                };
                expr.term.intlit.intlit = new() 
                { 
                    Type = TokenType.IntLit, 
                    Value = $"{dims[^1].intlit.Value}" 
                };
                return expr;
            }
            expr.type = NodeExpr.NodeExprType.BinExpr;
            expr.binexpr = new()
            {
                type = NodeBinExpr.NodeBinExprType.Mul,
                lhs = new()
            };
            expr.binexpr.lhs.type = NodeExpr.NodeExprType.Term;
            expr.binexpr.lhs.term = new()
            {
                type = NodeTerm.NodeTermType.IntLit,
                intlit = new()
            };
            expr.binexpr.lhs.term.intlit.intlit = new() 
            { 
                Type = TokenType.IntLit, 
                Value = $"{dims[i].intlit.Value}" 
            };
            expr.binexpr.rhs = GenIndexExprMult(ref indexes, ref dims, i + 1);
            return expr;
        }
        static NodeExpr GenIndexExpr(ref List<NodeExpr> indexes, ref List<NodeTermIntLit> dims, int i)
        {
            NodeExpr expr = new();
            if (i == dims.Count - 1)
            {
                expr.type = NodeExpr.NodeExprType.Term;
                expr.term = new()
                {
                    type = NodeTerm.NodeTermType.Paren,
                    paren = new()
                };
                expr.term.paren.expr = indexes[^1];
                return expr;
            }
            expr.type = NodeExpr.NodeExprType.BinExpr;
            expr.binexpr = new()
            {
                type = NodeBinExpr.NodeBinExprType.Add,
                lhs = new()
            };
            expr.binexpr.lhs.type = NodeExpr.NodeExprType.BinExpr;
            expr.binexpr.lhs.binexpr = new()
            {
                type = NodeBinExpr.NodeBinExprType.Mul,
                lhs = indexes[i],
                rhs = GenIndexExprMult(ref indexes, ref dims, i + 1)
            };

            expr.binexpr.rhs = GenIndexExpr(ref indexes, ref dims, i + 1);
            return expr;
        }
        void GenArrayAddrFrom_m_vars(List<NodeExpr> indexes, Token ident, int TypeSize, string BaseReg = "sp")
        {
            m_outputcode.AppendLine($"# begin array address");
            string reg = BaseReg == m_FirstTempReg ? m_SecondTempReg : m_FirstTempReg;
            if (!m_DimensionsOfArrays.ContainsKey(ident.Value))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: variable `{ident.Value}` is not declared as an array\n");
                Environment.Exit(1);
            }
            List<NodeTermIntLit> dims = m_DimensionsOfArrays[ident.Value];
            Shartilities.Assert(indexes.Count == dims.Count, "Generator: indexes and dimensionality are not equal");

            NodeExpr IndexExpr = GenIndexExpr(ref indexes, ref dims, 0);
            int index = m_vars.FindIndex(x => x.Value == ident.Value);
            int Count = m_vars[index].Size / TypeSize;
            if (BaseReg != "sp")
                GenPush(BaseReg, 8);

            GenExpr(
            new()
            {
                type = NodeExpr.NodeExprType.BinExpr,
                binexpr = new()
                {
                    type = NodeBinExpr.NodeBinExprType.Mul,
                    lhs = NodeExpr.Number(TypeSize.ToString(), -1),
                    rhs = IndexExpr,
                }
            },
            reg, 8);

            if (BaseReg != "sp")
                GenPop(BaseReg, 8);
            m_outputcode.AppendLine($"    ADD {reg}, {BaseReg}, {reg}");
            if (BaseReg == "sp")
            {
                int relative_location = m_StackSize - VariableLocationm_vars(ident.Value) - m_vars[index].Size;
                m_outputcode.AppendLine($"    ADDI {reg}, {reg}, {relative_location}");
            }

            GenPush(reg, 8);
            m_outputcode.AppendLine($"# end array address");
        }
        void GenTerm(NodeTerm term, string? DestReg, int size)
        {
            if (term.type == NodeTerm.NodeTermType.IntLit)
            {
                string reg = DestReg ?? m_FirstTempReg;
                string sign = (term.Negative) ? "-" : "";
                m_outputcode.AppendLine($"    LI {reg}, {sign}{term.intlit.intlit.Value}");
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
                m_outputcode.AppendLine($"    la {reg}, StringLits{index}");
                if (DestReg == null)
                    GenPush(reg, size);
            }
            else if (term.type == NodeTerm.NodeTermType.FunctionCall)
            {
                string reg = DestReg ?? m_FirstTempReg;
                GenStmtFunctionCall(new() { FunctionName = term.functioncall.FunctionName, parameters = term.functioncall.parameters }, true);
                m_outputcode.AppendLine($"    mv {reg}, s0");
                if (DestReg == null)
                    GenPush(reg, size);
            }
            else if (term.type == NodeTerm.NodeTermType.Ident)
            {
                m_outputcode.AppendLine($"########## {term.ident.ident.Value}");
                NodeTermIdent ident = term.ident;
                if (ident.indexes.Count == 0)
                {
                    if (m_vars.Any(x => x.Value == ident.ident.Value))
                    {
                        string reg = DestReg ?? m_FirstTempReg;
                        int index = m_vars.FindIndex(x => x.Value == ident.ident.Value);
                        int TypeSize = 
                            m_DimensionsOfArrays.ContainsKey(m_vars[index].Value) && 
                            m_parameters.Any(x => x.Value == m_vars[index].Value) ? 8 : m_vars[index].TypeSize;
                        int Count = m_vars[index].Size / m_vars[index].TypeSize;
                        int relative_location = m_StackSize - VariableLocationm_vars(ident.ident.Value) - TypeSize;

                        if (ident.ByRef)
                        {
                            if (!m_parameters.Any(x => x.Value == ident.ident.Value))
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
                                Shartilities.UNREACHABLE("");
                        }

                        if (term.Negative)
                            m_outputcode.AppendLine($"    SUB {reg}, zero, {reg}");
                        if (DestReg == null)
                            GenPush(reg, size);
                    }
                    else
                    {
                        Shartilities.Log(Shartilities.LogType.ERROR, $"variable `{ident.ident.Value}` is undeclared\n");
                        Environment.Exit(1);
                    }
                }
                else
                {
                    string reg = DestReg ?? m_FirstTempReg;
                    string reg_addr = reg == m_FirstTempReg ? m_SecondTempReg : m_FirstTempReg;
                    if (m_vars.Any(x => x.Value == ident.ident.Value))
                    {
                        int index = m_vars.FindIndex(x => x.Value == ident.ident.Value);
                        int TypeSize = m_vars[index].TypeSize;
                        if (m_parameters.Any(x => x.Value == ident.ident.Value))
                        {
                            int relative_location = m_StackSize - VariableLocationm_vars(ident.ident.Value) - 8;
                            m_outputcode.AppendLine($"    LD {reg}, {relative_location}(sp)");
                            GenArrayAddrFrom_m_vars(ident.indexes, ident.ident, TypeSize, reg);
                        }
                        else
                        {
                            GenArrayAddrFrom_m_vars(ident.indexes, ident.ident, TypeSize);
                        }
                        GenPop(reg_addr, 8);

                        if (TypeSize == 1)
                            m_outputcode.AppendLine($"    LB {reg}, 0({reg_addr})");
                        else if (TypeSize == 8)
                            m_outputcode.AppendLine($"    LD {reg}, 0({reg_addr})");
                        else
                            Shartilities.UNREACHABLE("");

                        if (term.Negative)
                            m_outputcode.AppendLine($"    SUB {reg}, zero, {reg}");
                        if (DestReg == null)
                            GenPush(reg, size);
                    }
                    else
                    {
                        Shartilities.Log(Shartilities.LogType.ERROR, $"variable `{ident.ident.Value}` is not declared\n");
                        Environment.Exit(1);
                    }
                }
            }
            else if (term.type == NodeTerm.NodeTermType.Paren)
            {
                string reg = DestReg ?? m_FirstTempReg;
                GenExpr(term.paren.expr, reg, size);
                if (term.Negative)
                    m_outputcode.AppendLine($"    SUB {reg}, zero, {reg}");
                if (DestReg == null)
                    GenPush(reg, size);
            }
            else
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: invalid term `{term.type}`\n");
                Environment.Exit(1);
            }
        }
        void GenBinExpr(NodeBinExpr binExpr, string? DestReg, int size)
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
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: invalid binary operator `{binExpr.type}`\n");
                    Environment.Exit(1);
                    return;
            }
            if (DestReg == null)
                GenPush(reg, size);
        }
        void GenExpr(NodeExpr expr, string? DestReg, int size)
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
        }
        void GenStmtDeclare(NodeStmtDeclare declare)
        {
            if (declare.type == NodeStmtIdentifierType.SingleVar)
            {
                Token ident = declare.singlevar.ident;
                if (m_vars.Any(x => x.Value == ident.Value))
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: variable `{ident.Value}` is alread declared\n");
                    Environment.Exit(1);
                }
                else
                {
                    if (declare.datatype == NodeStmtDataType.Auto)
                    {
                        GenExpr(declare.singlevar.expr, null, 8);
                        m_vars.Add(new(ident.Value, 8, 8));
                    }
                    else if (declare.datatype == NodeStmtDataType.Char)
                    {
                        GenExpr(declare.singlevar.expr, null, 1);
                        m_vars.Add(new(ident.Value, 1, 1));
                    }
                }
            }
            else if (declare.type == NodeStmtIdentifierType.Array)
            {
                Token ident = declare.array.ident;
                if (m_vars.Any(x => x.Value == ident.Value))
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: variable `{ident.Value}` is alread declared\n");
                    Environment.Exit(1);
                }
                else
                {
                    List<NodeTermIntLit> dims = m_DimensionsOfArrays[ident.Value];
                    int count = 1;
                    foreach (NodeTermIntLit l in dims)
                    {
                        if (int.TryParse(l.intlit.Value, out int dim))
                        {
                            count *= dim;
                        }
                        else
                        {
                            Shartilities.UNREACHABLE("GenStmtDeclare_arrays");
                        }
                    }
                    int SizePerVar = 0;
                    if (declare.datatype == NodeStmtDataType.Auto)
                        SizePerVar = 8;
                    else if (declare.datatype == NodeStmtDataType.Char)
                        SizePerVar = 1;
                    else
                        Shartilities.UNREACHABLE("SizePerVar");

                    m_outputcode.AppendLine($"    ADDI sp, sp, -{SizePerVar * count}");
                    m_StackSize += SizePerVar * count;
                    m_vars.Add(new(ident.Value, SizePerVar * count, SizePerVar));
                }
            }
        }
        void GenStmtAssign(NodeStmtAssign assign)
        {
            if (assign.type == NodeStmtIdentifierType.SingleVar)
            {
                Token ident = assign.singlevar.ident;
                string reg = $"{m_FirstTempReg}";
                if (m_vars.Any(x => x.Value == ident.Value))
                {
                    int index = m_vars.FindIndex(x => x.Value == ident.Value);
                    int TypeSize = m_vars[index].TypeSize;

                    GenExpr(assign.singlevar.expr, reg, TypeSize);
                    int relative_location = m_StackSize - VariableLocationm_vars(ident.Value);
                    if (TypeSize == 1)
                        m_outputcode.AppendLine($"    SB {reg}, {relative_location - TypeSize}(sp)");
                    if (TypeSize == 8)
                        m_outputcode.AppendLine($"    SD {reg}, {relative_location - TypeSize}(sp)");
                }
                else
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"variable `{ident.Value}` is not declared\n");
                    Environment.Exit(1);
                }
            }
            else if (assign.type == NodeStmtIdentifierType.Array)
            {
                Token ident = assign.array.ident;
                if (m_vars.Any(x => x.Value == ident.Value))
                {
                    string reg_addr = $"{m_FirstTempReg}";
                    string reg_data = $"{m_SecondTempReg}";
                    int index = m_vars.FindIndex(x => x.Value == ident.Value);
                    int TypeSize = m_vars[index].TypeSize;
                    if (m_parameters.Any(x => x.Value == ident.Value))
                    {
                        int relative_location = m_StackSize - VariableLocationm_vars(ident.Value) - 8;
                        m_outputcode.AppendLine($"    LD {reg_addr}, {relative_location}(sp)");
                        GenArrayAddrFrom_m_vars(assign.array.indexes, ident, TypeSize, reg_addr);
                    }
                    else
                    {
                        GenArrayAddrFrom_m_vars(assign.array.indexes, ident, TypeSize);
                    }

                    GenExpr(assign.array.expr, reg_data, TypeSize);
                    GenPop(reg_addr, 8);

                    if (TypeSize == 1)
                        m_outputcode.AppendLine($"    SB {reg_data}, 0({reg_addr})");
                    else if (TypeSize == 8)
                        m_outputcode.AppendLine($"    SD {reg_data}, 0({reg_addr})");
                    else
                        Shartilities.UNREACHABLE("");
                }
                else
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"variable `{ident.Value}` is not declared\n");
                    Environment.Exit(1);
                }
            }
        }
        void GenElifs(NodeIfElifs elifs, string label_end)
        {
            if (elifs.type == NodeIfElifs.NodeIfElifsType.Elif)
            {
                string reg = $"{m_FirstTempReg}";
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
        }
        string GenStmtIF(NodeStmtIF iff)
        {
            string reg = $"{m_FirstTempReg}";
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
                m_outputcode.AppendLine($"# end init");
            }
            if (forr.pred.cond.HasValue)
            {
                m_outputcode.AppendLine($"# begin condition");
                string label_start = $"TEMP_LABEL{m_labels_count++}_START";
                string label_end = $"TEMP_LABEL{m_labels_count++}_END";
                string label_update = $"TEMP_LABEL{m_labels_count++}_START";

                m_outputcode.AppendLine($"{label_start}:");
                string reg = $"{m_FirstTempReg}";
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
            string reg = $"{m_FirstTempReg}";
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
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: no enclosing loop out of which to break from on line {breakk.breakk.Line}\n");
                Environment.Exit(1);
            }
            m_outputcode.AppendLine($"    J {m_scopeend.Peek()}");
        }
        void GenStmtContinue(NodeStmtContinuee continuee)
        {
            if (m_scopestart.Count == 0)
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: no enclosing loop out of which to continue on line {continuee.continuee.Line}\n");
                Environment.Exit(1);
            }
            m_outputcode.AppendLine($"    J {m_scopestart.Peek()}");
        }
        void GenStmtFunctionCall(NodeStmtFunctionCall Function, bool WillPushParams)
        {
            if (m_UserDefinedFunctions.TryGetValue(Function.FunctionName.Value, out NodeStmtFunction CalledFunction))
            {
                if (CalledFunction.parameters.Count != Function.parameters.Count)
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: Function call to `{CalledFunction.FunctionName.Value}` is not valid, check function arity\n");
                    Environment.Exit(1);
                }
            }
            else if (STD_FUNCTIONS.Contains(Function.FunctionName.Value))
            {

            }
            else
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: Function `{Function.FunctionName.Value}` is not defined\n");
                Environment.Exit(1);
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

            if (m_UserDefinedFunctions.TryGetValue(Function.FunctionName.Value, out NodeStmtFunction func))
            {
                for (int i = 0; i < Function.parameters.Count; i++)
                {
                    GenExpr(Function.parameters[i], $"a{i}", func.parameters[i].Size);
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
            int stacksize = 0;
            foreach (Var v in m_vars)
            {
                if (m_parameters.Any(x => x.Value == v.Value) && m_DimensionsOfArrays.ContainsKey(v.Value))
                    stacksize += 8;
                else
                    stacksize += v.Size;
            }
            Shartilities.Assert(stacksize == m_StackSize, $"stack sizes are not equal");
            if (stacksize > 0)
                m_outputcode.AppendLine($"    ADDI sp, sp, {stacksize}");
            if (m_CurrentFunction == "main")
            {
                m_outputcode.AppendLine($"    ADDI a0, zero, 0");
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
                int TypeSize = Function.parameters[i].TypeSize;
                int Size = Function.parameters[i].Size;
                if (Function.DimensionsOfArrays.ContainsKey(Function.parameters[i].Value))
                {
                    GenPush($"a{i}", 8);
                }
                else
                {
                    GenPush($"a{i}", TypeSize);
                }
                m_vars.Add(new(Function.parameters[i].Value, Size, TypeSize));
            }
            foreach (NodeStmt stmt in Function.FunctionBody.stmts)
            {
                GenStmt(stmt);
            }
            if (Function.FunctionBody.stmts[^1].type != NodeStmt.NodeStmtType.Return)
            {
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
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: invalid statement `{stmt.type}`\n");
                Environment.Exit(1);
            }
        }
        List<string> STD_FUNCTIONS = ["exit", "strlen", "itoa", "printf"];
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
            if (m_CalledFunctions.Contains("itoa"))
            {
                m_outputcode.AppendLine($"itoa:");
                m_outputcode.AppendLine($"    mv t1, a0");
                //m_outputcode.AppendLine($"    ADDI t2, a1, 32");
                m_outputcode.AppendLine($"    la t2, itoaTempBuffer");
                m_outputcode.AppendLine($"    ADDI t2, t2, 32");
                m_outputcode.AppendLine($"    sb zero, 0(t2)");
                m_outputcode.AppendLine($"itoa_loop:");
                m_outputcode.AppendLine($"    beqz t1, itoa_done");
                m_outputcode.AppendLine($"    li t3, 10");
                m_outputcode.AppendLine($"    rem t4, t1, t3");
                m_outputcode.AppendLine($"    ADDI t4, t4, '0'");
                m_outputcode.AppendLine($"    ADDI t2, t2, -1");
                m_outputcode.AppendLine($"    sb t4, 0(t2)");
                m_outputcode.AppendLine($"    div t1, t1, t3");
                m_outputcode.AppendLine($"    j itoa_loop");
                m_outputcode.AppendLine($"itoa_done:");
                m_outputcode.AppendLine($"    mv s0, t2");
                m_outputcode.AppendLine($"    ret");
            }
        }
        public StringBuilder GenProg()
        {
            m_outputcode.AppendLine($".section .text");
            m_outputcode.AppendLine($".globl main");

            if (!m_UserDefinedFunctions.ContainsKey("main"))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: no entry point `main` is defined\n");
                Environment.Exit(1);
            }
            // TODO: should resolve and generate global and keep them without resetting
            GenFunctionDefinition(m_UserDefinedFunctions["main"].FunctionName.Value);
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
            if (!m_UserDefinedFunctions.ContainsKey("itoa") && m_CalledFunctions.Contains("itoa"))
            {
                m_outputcode.AppendLine($".section .bss");
                m_outputcode.AppendLine($"itoaTempBuffer:     ");
                m_outputcode.AppendLine($"    .space 32");
            }
            //m_outputcode.AppendLine($".extern printf");
            return m_outputcode;
        }
    }
}