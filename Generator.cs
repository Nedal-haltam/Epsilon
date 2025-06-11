using System.Text;

namespace Epsilon
{
    public struct Var(string value, int size)
    {
        public string Value { get; set; } = value;
        public int Size { get; set; } = size;
    }
    class Generator
    {
        public readonly string FirstTempReg = "t0";
        public readonly string SecondTempReg = "t1";
        public readonly int STACK_CAPACITY = 500;
        public NodeProg m_prog;
        public readonly StringBuilder m_outputcode = new();
        public int m_labels_count = 0;
        public Dictionary<string, NodeStmtFunction> m_Functions = [];
        public List<string> m_STD_FUNCTIONS  = [];
        public readonly List<string> CalledFunctions = [];
        public List<string> StringLits = [];


        public List<Var> m_vars = [];
        public readonly Stack<int> m_scopes = [];
        public int m_StackSize = 0;
        public readonly Stack<string?> m_scopestart = [];
        public readonly Stack<string?> m_scopeend = [];
        public Dictionary<string, List<NodeTermIntLit>> DimensionsOfArrays = [];
        public static string GetImmedOperation(string imm1, string imm2, NodeBinExpr.NodeBinExprType op)
        {
            if (op == NodeBinExpr.NodeBinExprType.add)
                return (Convert.ToInt32(imm1) + Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.sub)
                return (Convert.ToInt32(imm1) - Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.sll)
                return (Convert.ToInt32(imm1) << Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.srl)
                return (Convert.ToInt32(imm1) >> Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.equalequal)
                return (Convert.ToInt32(imm1) == Convert.ToInt32(imm2) ? 1 : 0).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.notequal)
                return (Convert.ToInt32(imm1) != Convert.ToInt32(imm2) ? 1 : 0).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.lessthan)
                return (Convert.ToInt32(imm1) < Convert.ToInt32(imm2) ? 1 : 0).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.greaterthan)
                return (Convert.ToInt32(imm1) > Convert.ToInt32(imm2) ? 1 : 0).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.and)
                return (Convert.ToInt32(imm1) & Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.or)
                return (Convert.ToInt32(imm1) | Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.xor)
                return (Convert.ToInt32(imm1) ^ Convert.ToInt32(imm2)).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.mult)
                return (Convert.ToInt32(imm1) * Convert.ToInt32(imm2)).ToString();
            Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: invalid operation `{op}`\n");
            Environment.Exit(1);
            return "";
        }
    }
    class RISCVGenerator : Generator
    {
        public RISCVGenerator(NodeProg prog, Dictionary<string, List<NodeTermIntLit>> Arraydims, Dictionary<string, NodeStmtFunction> Functions, List<string> STD_FUNCTIONS)
        {
            m_prog = prog;
            DimensionsOfArrays = Arraydims;
            m_Functions = Functions;
            m_STD_FUNCTIONS = STD_FUNCTIONS;
        }

        void GenPush(string reg)
        {
            m_outputcode.AppendLine($"    addi sp, sp, -8");
            m_outputcode.AppendLine($"    sw {reg}, 8(sp)");
            m_StackSize++;
        }

        void GenPop(string reg)
        {
            m_outputcode.AppendLine($"    lw {reg}, 8(sp)");
            m_outputcode.AppendLine($"    addi sp, sp, 8");
            m_StackSize--;
        }
        void StackPopEndScope(int popcount)
        {
            if (popcount != 0)
                m_outputcode.AppendLine($"    ADDI sp, sp, {8*popcount}");
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
        bool IsVariableDeclared(string name)
        {
            for (int i = 0; i < m_vars.Count; i++)
                if (m_vars[i].Value == name)
                    return true;
            return false;
        }
        int VariableLocation(string name)
        {
            int index = 0;
            for (int i = 0; i < m_vars.Count; i++)
            {
                if (m_vars[i].Value == name)
                    break;
                else
                    index += m_vars[i].Size;
            }
            return index;
        }
        NodeExpr GenIndexExprMult(ref List<NodeExpr> indexes, ref List<NodeTermIntLit> dims, int i)
        {
            NodeExpr expr = new();
            if (i == dims.Count - 1)
            {
                expr.type = NodeExpr.NodeExprType.term;
                expr.term = new()
                {
                    type = NodeTerm.NodeTermType.intlit,
                    intlit = new()
                };
                expr.term.intlit.intlit = new() 
                { 
                    Type = TokenType.IntLit, 
                    Value = $"{dims[^1].intlit.Value}" 
                };
                return expr;
            }
            expr.type = NodeExpr.NodeExprType.binExpr;
            expr.binexpr = new()
            {
                type = NodeBinExpr.NodeBinExprType.mult,
                lhs = new()
            };
            expr.binexpr.lhs.type = NodeExpr.NodeExprType.term;
            expr.binexpr.lhs.term = new()
            {
                type = NodeTerm.NodeTermType.intlit,
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
        NodeExpr GenIndexExpr(ref List<NodeExpr> indexes, ref List<NodeTermIntLit> dims, int i)
        {
            NodeExpr expr = new();
            if (i == dims.Count - 1)
            {
                expr.type = NodeExpr.NodeExprType.term;
                expr.term = new()
                {
                    type = NodeTerm.NodeTermType.paren,
                    paren = new()
                };
                expr.term.paren.expr = indexes[^1];
                return expr;
            }
            expr.type = NodeExpr.NodeExprType.binExpr;
            expr.binexpr = new()
            {
                type = NodeBinExpr.NodeBinExprType.add,
                lhs = new()
            };
            expr.binexpr.lhs.type = NodeExpr.NodeExprType.binExpr;
            expr.binexpr.lhs.binexpr = new()
            {
                type = NodeBinExpr.NodeBinExprType.mult,
                lhs = indexes[i],
                rhs = GenIndexExprMult(ref indexes, ref dims, i + 1)
            };

            expr.binexpr.rhs = GenIndexExpr(ref indexes, ref dims, i + 1);
            return expr;
        }
        void GenArrayAddr(List<NodeExpr> indexes, Token ident, string? DestReg = null)
        {
            m_outputcode.AppendLine($"# begin array address");
            string reg = DestReg ?? $"{FirstTempReg}";
            List<NodeTermIntLit> dims = DimensionsOfArrays[ident.Value];
            Shartilities.Assert(indexes.Count == dims.Count, "Generator: indexes and dimensionality are not equal");

            // arr[i][j][k] = arr[index], s.t index = (i * dim[1] * dim[2]) + (j * dim[2]) + k
            // we get the address from GenExpr(index), then GenPop(reg)
            NodeExpr index = GenIndexExpr(ref indexes, ref dims, 0);
            GenExpr(index, reg);

            int relative_location = m_StackSize - VariableLocation(ident.Value);
            m_outputcode.AppendLine($"    SUB {reg}, zero, {reg}");
            m_outputcode.AppendLine($"    ADDI {reg}, {reg}, {relative_location}");
            m_outputcode.AppendLine($"    ADD {reg}, {reg}, sp");
            if (DestReg == null)
                GenPush(reg);
            m_outputcode.AppendLine($"# end array address");
        }
        void GenTerm(NodeTerm term, string? DestReg = null)
        {
            if (term.type == NodeTerm.NodeTermType.intlit)
            {
                string reg = DestReg ?? $"{FirstTempReg}";
                string sign = (term.Negative) ? "-" : "";
                m_outputcode.AppendLine($"    ADDI {reg}, zero, {sign}{term.intlit.intlit.Value}");
                if (DestReg == null)
                    GenPush(reg);
            }
            else if (term.type == NodeTerm.NodeTermType.stringlit)
            {
                string reg = DestReg ?? $"{FirstTempReg}";
                StringLits.Add(term.stringlit.stringlit.Value);
                m_outputcode.AppendLine($"    la {reg}, StringLits{StringLits.Count - 1}");
                if (DestReg == null)
                    GenPush(reg);
            }
            else if (term.type == NodeTerm.NodeTermType.functioncall)
            {
                string reg = DestReg ?? $"{FirstTempReg}";
                GenStmtFunction(new() { FunctionName = term.functioncall.FunctionName, parameters = term.functioncall.parameters });
                m_outputcode.AppendLine($"    mv {reg}, s0");
                if (DestReg == null)
                    GenPush(reg);
            }
            else if (term.type == NodeTerm.NodeTermType.ident)
            {
                m_outputcode.AppendLine($"########## {term.ident.ident.Value}");
                NodeTermIdent ident = term.ident;
                if (!IsVariableDeclared(ident.ident.Value))
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"variable {ident.ident.Value} is not declared on line {ident.ident.Line}\n");
                    Environment.Exit(1);
                }
                if (ident.indexes.Count == 0)
                {
                    string reg = DestReg ?? $"{FirstTempReg}";
                    int relative_location = m_StackSize - VariableLocation(ident.ident.Value);
                    m_outputcode.AppendLine($"    LW {reg}, {relative_location * 8}(sp)");
                    if (term.Negative)
                        m_outputcode.AppendLine($"    SUB {reg}, zero, {reg}");
                    if (DestReg == null)
                        GenPush(reg);
                }
                else
                {
                    string reg_addr = $"{FirstTempReg}";
                    string reg = DestReg ?? $"{SecondTempReg}";

                    m_outputcode.AppendLine($"# begin index");
                    GenArrayAddr(ident.indexes, ident.ident, reg_addr);
                    m_outputcode.AppendLine($"# end index");

                    m_outputcode.AppendLine($"# begin data");
                    m_outputcode.AppendLine($"    LW {reg}, 0({reg_addr})");
                    if (term.Negative)
                        m_outputcode.AppendLine($"    SUB {reg}, zero, {reg}");
                    if (DestReg == null)
                        GenPush(reg);
                    m_outputcode.AppendLine($"# end data");
                }
            }
            else if (term.type == NodeTerm.NodeTermType.paren)
            {
                GenExpr(term.paren.expr, DestReg);
            }
            else
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: invalid term `{term.type}`\n");
                Environment.Exit(1);
            }
        }
        void GenBinExpr(NodeBinExpr binExpr, string? DestReg = null)
        {
            string reg = DestReg ?? $"{FirstTempReg}";
            string reg2 = $"{SecondTempReg}";
            GenExpr(binExpr.rhs);
            GenExpr(binExpr.lhs, reg);
            GenPop(reg2);
            switch (binExpr.type)
            {
                case NodeBinExpr.NodeBinExprType.add:
                    m_outputcode.AppendLine($"    ADD {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.sub:
                    m_outputcode.AppendLine($"    SUB {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.sll:
                    m_outputcode.AppendLine($"    SLL {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.srl:
                    m_outputcode.AppendLine($"    SRL {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.equalequal:
                    m_outputcode.AppendLine($"    SEQ {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.notequal:
                    m_outputcode.AppendLine($"    SNE {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.lessthan:
                    m_outputcode.AppendLine($"    SLT {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.greaterthan:
                    m_outputcode.AppendLine($"    SGT {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.and:
                    m_outputcode.AppendLine($"    AND {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.or:
                    m_outputcode.AppendLine($"    OR {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.xor:
                    m_outputcode.AppendLine($"    XOR {reg}, {reg}, {reg2}");
                    break;    
                case NodeBinExpr.NodeBinExprType.mult:
                    m_outputcode.AppendLine($"    MUL {reg}, {reg}, {reg2}");
                    break;    
                default:
                    Shartilities.Log(Shartilities.LogType.ERROR, $"invalide binary operator `{binExpr.type}`\n");
                    Environment.Exit(1);
                    return;
            }
            if (DestReg == null)
                GenPush(reg);
        }
        void GenExpr(NodeExpr expr, string? DestReg = null)
        {
            if (expr.type == NodeExpr.NodeExprType.term)
            {
                GenTerm(expr.term, DestReg);
            }
            else if (expr.type == NodeExpr.NodeExprType.binExpr)
            {
                GenBinExpr(expr.binexpr, DestReg);
            }
        }

        string? GenImmedTerm(NodeTerm term)
        {
            if (term.type == NodeTerm.NodeTermType.intlit)
            {
                return term.intlit.intlit.Value;
            }
            else if (term.type == NodeTerm.NodeTermType.paren)
            {
                return GenImmedExpr(term.paren.expr);
            }
            else
            {
                return null;
            }
        }
        string? GenImmedBinExpr(NodeBinExpr binExpr)
        {
            string? imm2 = GenImmedExpr(binExpr.rhs);
            string? imm1 = GenImmedExpr(binExpr.lhs);
            if (imm1 != null && imm2 != null)
            {
                return GetImmedOperation(imm1, imm2, binExpr.type);
            }
            return null;

        }
        string? GenImmedExpr(NodeExpr Iexpr)
        {
            if (Iexpr.type == NodeExpr.NodeExprType.term)
            {
                return GenImmedTerm(Iexpr.term);
            }
            else if (Iexpr.type == NodeExpr.NodeExprType.binExpr)
            {
                return GenImmedBinExpr(Iexpr.binexpr);
            }
            return null;
        }
        //void GenArrayInit1D(List<NodeExpr> init)
        //{
        //    for (int i = 0; i < init.Count; i++)
        //    {
        //        GenExpr(init[i]);
        //    }
        //}
        //void GenArrayInit2D(List<List<NodeExpr>> init)
        //{
        //    for (int i = 0; i < init.Count; i++)
        //    {
        //        GenArrayInit1D(init[i]);
        //    }
        //}
        void GenStmtDeclare(NodeStmtDeclare declare)
        {
            if (declare.type == NodeStmtDeclare.NodeStmtDeclareType.SingleVar)
            {
                Token ident = declare.singlevar.ident;
                if (IsVariableDeclared(ident.Value))
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"variable {ident.Value} is already declared on line {ident.Line}\n");
                    Environment.Exit(1);
                }
                GenExpr(declare.singlevar.expr);
                m_vars.Add(new(ident.Value, 1));
            }
            else if (declare.type == NodeStmtDeclare.NodeStmtDeclareType.Array)
            {
                Token ident = declare.array.ident;
                if (IsVariableDeclared(ident.Value))
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"variable {ident.Value} is already declared on line {ident.Line}\n");
                    Environment.Exit(1);
                }
                List<NodeTermIntLit> dims = DimensionsOfArrays[declare.array.ident.Value];
                int count = 1;
                foreach (NodeTermIntLit l in dims)
                {
                    if (int.TryParse(l.intlit.Value, out int dim))
                    {
                        count *= dim;
                    }
                    else
                    {
                        Shartilities.Log(Shartilities.LogType.ERROR, "Generator: could not parse to int\n");
                        Environment.Exit(1);
                    }
                }
                m_outputcode.AppendLine($"    ADDI sp, sp, -{8*count}");
                m_StackSize += (count);
                m_vars.Add(new(ident.Value, count));
            }
        }
        void GenArrayAssign(NodeStmtAssignArray array)
        {
            string reg_addr = $"{FirstTempReg}";
            string reg_data = $"{SecondTempReg}";
            GenArrayAddr(array.indexes, array.ident);
            GenExpr(array.expr, reg_data);
            GenPop(reg_addr);
            m_outputcode.AppendLine($"    SW {reg_data}, 0({reg_addr})");
        }
        void GenStmtAssign(NodeStmtAssign assign)
        {
            if (assign.type == NodeStmtAssign.NodeStmtAssignType.SingleVar)
            {
                Token ident = assign.singlevar.ident;
                string reg = $"{FirstTempReg}";
                if (!IsVariableDeclared(ident.Value))
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"variable {ident.Value} is not declared on line {ident.Line}\n");
                    Environment.Exit(1);
                }
                GenExpr(assign.singlevar.expr, reg);
                int relative_location = m_StackSize - VariableLocation(ident.Value);
                m_outputcode.AppendLine($"    SW {reg}, {relative_location*8}(sp)");
            }
            else if (assign.type == NodeStmtAssign.NodeStmtAssignType.Array)
            {
                Token ident = assign.array.ident;
                if (!IsVariableDeclared(ident.Value))
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"variable {ident.Value} is not declared on line {ident.Line}\n");
                    Environment.Exit(1);
                }
                GenArrayAssign(assign.array);
            }
        }
        void GenElifs(NodeIfElifs elifs, string label_end)
        {
            if (elifs.type == NodeIfElifs.NodeIfElifsType.elif)
            {
                string reg = $"{FirstTempReg}";
                string label = $"LABEL{m_labels_count++}_elifs";
                GenExpr(elifs.elif.pred.cond, reg);
                m_outputcode.AppendLine($"    BEQ {reg}, zero, {label}");
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
            else if (elifs.type == NodeIfElifs.NodeIfElifsType.elsee)
            {
                GenScope(elifs.elsee.scope);
            }
        }
        string GenStmtIF(NodeStmtIF iff)
        {
            string reg = $"{FirstTempReg}";
            string label_start = $"LABEL{m_labels_count++}_START";
            string label_end = $"LABEL{m_labels_count++}_END";
            string label = $"LABEL{m_labels_count++}_elifs";

            m_outputcode.AppendLine($"{label_start}:");
            GenExpr(iff.pred.cond, reg);
            m_outputcode.AppendLine($"    BEQ {reg}, zero, {label}");
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
                if (forr.pred.init.Value.type == NodeForInit.NodeForInitType.declare)
                    GenStmtDeclare(forr.pred.init.Value.declare);
                else if (forr.pred.init.Value.type == NodeForInit.NodeForInitType.assign)
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
                string reg = $"{FirstTempReg}";
                GenExpr(forr.pred.cond.Value.cond, reg);
                m_outputcode.AppendLine($"    BEQ {reg}, zero, {label_end}");
                m_outputcode.AppendLine($"# end condition");
                m_scopestart.Push(label_update);
                m_scopeend.Push(label_end);
                GenScope(forr.pred.scope);
                m_scopestart.Pop();
                m_scopeend.Pop();
                m_outputcode.AppendLine($"# begin update");
                m_outputcode.AppendLine($"{label_update}:");
                if (forr.pred.udpate.udpates.Count != 0)
                {
                    for (int i = 0; i < forr.pred.udpate.udpates.Count; i++)
                    {
                        GenStmtAssign(forr.pred.udpate.udpates[i]);
                    }
                }
                m_outputcode.AppendLine($"# end update");
                m_outputcode.AppendLine($"    J {label_start}");
                m_outputcode.AppendLine($"{label_end}:");
            }
            else if (forr.pred.udpate.udpates.Count != 0)
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
                for (int i = 0; i < forr.pred.udpate.udpates.Count; i++)
                {
                    GenStmtAssign(forr.pred.udpate.udpates[i]);
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
            string reg = $"{FirstTempReg}";
            GenExpr(whilee.cond, reg);
            m_outputcode.AppendLine($"    BEQ {reg}, zero, {label_end}");
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
                Shartilities.Log(Shartilities.LogType.ERROR, $"no enclosing loop out of which to break from on line {breakk.breakk.Line}\n");
                Environment.Exit(1);
            }
            m_outputcode.AppendLine($"    J {m_scopeend.Peek()}");
        }
        void GenStmtContinue(NodeStmtContinuee continuee)
        {
            if (m_scopestart.Count == 0)
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"no enclosing loop out of which to continue on line {continuee.continuee.Line}\n");
                Environment.Exit(1);
            }
            m_outputcode.AppendLine($"    J {m_scopestart.Peek()}");
        }
        void GenStmtFunction(NodeStmtFunctionCall Function)
        {
            if (!CalledFunctions.Contains(Function.FunctionName.Value))
                CalledFunctions.Add(Function.FunctionName.Value);
            for (int i = 0; i < Function.parameters.Count; i++)
            {
                GenPush($"a{i}");
            }
            for (int i = 0; i < Function.parameters.Count; i++)
            {
                GenExpr(Function.parameters[i], $"a{i}");
            }
            m_outputcode.AppendLine($"    call {Function.FunctionName.Value}");
            for (int i = Function.parameters.Count - 1; i >= 0; i--)
            {
                GenPop($"a{i}");
            }
        }
        void GenFunction(string FunctionName)
        {
            NodeStmtFunction Function = m_Functions[FunctionName];

            m_outputcode.AppendLine($"{FunctionName}:");

            GenPush("ra");
            GenScope(Function.FunctionBody);
            GenPop("ra");
            m_outputcode.AppendLine($"    ret");
        }
        void GenStmtExit(NodeStmtExit exit)
        {
            string reg = "a0";
            GenExpr(exit.expr, reg);
            m_outputcode.AppendLine($"    call exit");
        }
        void GenStmt(NodeStmt stmt)
        {
            if (stmt.type == NodeStmt.NodeStmtType.declare)
            {
                GenStmtDeclare(stmt.declare);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.assign)
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
                GenStmtFunction(stmt.CalledFunction);
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
        void ResetBeforeGenFunction()
        {
            m_StackSize = 0;
            m_vars.Clear();
            m_scopes.Clear();
            m_scopestart.Clear();
            m_scopeend.Clear();
            DimensionsOfArrays.Clear();
        }
        public StringBuilder GenProg()
        {

            m_outputcode.AppendLine($"    .equ SYS_WRITE, 64");
            m_outputcode.AppendLine($"    .equ SYS_EXIT, 93");
            m_outputcode.AppendLine($"    .section .text");
            m_outputcode.AppendLine($"    .globl _start");
            m_outputcode.AppendLine($"    _start:");

            if (!m_Functions.ContainsKey("main"))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Generator: no entry point `main` is defined\n");
                Environment.Exit(1);
            }
            ResetBeforeGenFunction();
            DimensionsOfArrays = m_Functions["main"].DimensionsOfArrays;
            GenScope(m_Functions["main"].FunctionBody);
            m_outputcode.AppendLine($"    ADDI a0, zero, 0");
            m_outputcode.AppendLine($"    call exit");
            for (int i = 0; i < CalledFunctions.Count; i++)
            {
                if (m_STD_FUNCTIONS.Contains(CalledFunctions[i]))
                    continue;
                ResetBeforeGenFunction();
                DimensionsOfArrays = m_Functions[CalledFunctions[i]].DimensionsOfArrays;
                GenFunction(CalledFunctions[i]);
            }

            m_outputcode.AppendLine($"strlen:");
            m_outputcode.AppendLine($"    mv t0, a0");
            m_outputcode.AppendLine($"    li s0, 0");
            m_outputcode.AppendLine($"strlen_loop:");
            m_outputcode.AppendLine($"    lbu t1, 0(t0)");
            m_outputcode.AppendLine($"    beqz t1, strlen_done");
            m_outputcode.AppendLine($"    addi s0, s0, 1");
            m_outputcode.AppendLine($"    addi t0, t0, 1");
            m_outputcode.AppendLine($"    j strlen_loop");
            m_outputcode.AppendLine($"strlen_done:");
            m_outputcode.AppendLine($"    ret");

            m_outputcode.AppendLine($"print:");
            m_outputcode.AppendLine($"    li a7, SYS_WRITE");
            m_outputcode.AppendLine($"    ecall");
	        m_outputcode.AppendLine($"    ret");
            m_outputcode.AppendLine($"exit:");
	        m_outputcode.AppendLine($"    li a7, SYS_EXIT");
	        m_outputcode.AppendLine($"    ecall");
            m_outputcode.AppendLine($"    ret\n\n");

            for (int i = 0; i < StringLits.Count; i++)
            {
                m_outputcode.AppendLine($"StringLits{i}:");
                m_outputcode.AppendLine($"    .string \"{StringLits[i]}\\n\"");
            }
            return m_outputcode;
        }
    }
}