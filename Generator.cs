using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Runtime.Intrinsics.X86;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
#pragma warning disable CS8500


namespace Epsilon
{
    public struct Var
    {
        public Var(string value, int size)
        {
            Value = value;
            Size = size;
        }
        public string Value { get; set; }
        public int Size { get; set; }
    }
    public struct Vars
    {
        public Vars()
        {
            m_vars = [];
        }
        public List<Var> m_vars = [];
    }
    class Generator
    {
        public readonly int STACK_CAPACITY = 500;
        public NodeProg m_prog;
        public readonly StringBuilder m_outputcode = new();
        public Vars vars = new();
        public readonly Stack<int> m_scopes = [];
        public int m_labels_count = 0;
        public int m_StackSize = 0;
        public readonly Stack<string?> m_scopestart = [];
        public readonly Stack<string?> m_scopeend = [];
        public Dictionary<string, List<NodeTermIntLit>> m_Arraydims = new();
        public void Error(string msg, int line)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Generator: Error: {msg} on line: {line}");
            Console.ResetColor();
            Environment.Exit(1);
        }
        public static string? GetImmedOperation(string imm1, string imm2, NodeBinExpr.NodeBinExprType op)
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
            return null;
        }
    }
    class MIPSGenerator : Generator
    {
        public MIPSGenerator(NodeProg prog, Dictionary<string, List<NodeTermIntLit>> Arraydims)
        {
            m_prog = prog;
            m_Arraydims = Arraydims;
        }

        void GenPush(string reg)
        {
            m_outputcode.Append($"SW {reg}, 0($sp)\n");
            m_outputcode.Append("ADDI $sp, $sp, -1\n");
            m_StackSize++;
        }

        void GenPop(string reg)
        {
            m_outputcode.Append("ADDI $sp, $sp, 1\n");
            m_outputcode.Append($"LW {reg}, 0($sp)\n");
            m_StackSize--;
        }
        void StackPopEndScope(int popcount)
        {
            m_outputcode.Append($"ADDi $sp, $sp, {popcount}\n");
        }
        void BeginScope()
        {
            m_outputcode.Append("# begin scope\n");
            m_scopes.Push(vars.m_vars.Count);
        }
        void EndScope()
        {
            m_outputcode.Append("# end scope\n");
            int Vars_topop = vars.m_vars.Count - m_scopes.Pop();
            int i = vars.m_vars.Count - 1;
            int iterations = Vars_topop;
            int popcount = 0;
            while (iterations-- > 0)
            {
                popcount += vars.m_vars[i--].Size;
            }
            StackPopEndScope(popcount);
            m_StackSize -= popcount;
            vars.m_vars.RemoveRange(vars.m_vars.Count - Vars_topop, Vars_topop);
        }
        void GenScope(NodeScope scope)
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
            for (int i = 0; i < vars.m_vars.Count; i++)
                if (vars.m_vars[i].Value == name)
                    return true;
            return false;
        }
        int VariableLocation(string name)
        {
            int index = 0;
            for (int i = 0; i < vars.m_vars.Count; i++)
            {
                if (vars.m_vars[i].Value == name)
                    break;
                else
                    index += vars.m_vars[i].Size;
            }
            return index;
        }
        NodeExpr GenIndexExprMult(ref List<NodeExpr> indexes, ref List<NodeTermIntLit> dims, int i)
        {
            NodeExpr expr = new();
            if (i == dims.Count - 1)
            {
                expr.type = NodeExpr.NodeExprType.term;
                expr.term = new();
                expr.term.type = NodeTerm.NodeTermType.intlit;
                expr.term.intlit = new();
                expr.term.intlit.intlit = new() { Type = TokenType.IntLit, Value = $"{dims[^1].intlit.Value}" };
                return expr;
            }
            expr.type = NodeExpr.NodeExprType.binExpr;
            expr.binexpr = new();
            expr.binexpr.type = NodeBinExpr.NodeBinExprType.mult;
            expr.binexpr.lhs = new();
            expr.binexpr.lhs.type = NodeExpr.NodeExprType.term;
            expr.binexpr.lhs.term = new();
            expr.binexpr.lhs.term.type = NodeTerm.NodeTermType.intlit;
            expr.binexpr.lhs.term.intlit = new();
            expr.binexpr.lhs.term.intlit.intlit = new() { Type = TokenType.IntLit, Value = $"{dims[i].intlit.Value}" };
            expr.binexpr.rhs = GenIndexExprMult(ref indexes, ref dims, i + 1);
            return expr;
        }
        NodeExpr GenIndexExpr(ref List<NodeExpr> indexes, ref List<NodeTermIntLit> dims, int i)
        {
            NodeExpr expr = new();
            if (i == dims.Count - 1)
            {
                expr.type = NodeExpr.NodeExprType.term;
                expr.term = new();
                expr.term.type = NodeTerm.NodeTermType.paren;
                expr.term.paren = new();
                expr.term.paren.expr = indexes[^1];
                return expr;
            }
            expr.type = NodeExpr.NodeExprType.binExpr;
            expr.binexpr = new();
            expr.binexpr.type = NodeBinExpr.NodeBinExprType.add;
            expr.binexpr.lhs = new();
            expr.binexpr.lhs.type = NodeExpr.NodeExprType.binExpr;
            expr.binexpr.lhs.binexpr = new();
            expr.binexpr.lhs.binexpr.type = NodeBinExpr.NodeBinExprType.mult;
            expr.binexpr.lhs.binexpr.lhs = indexes[i];
            expr.binexpr.lhs.binexpr.rhs = GenIndexExprMult(ref indexes, ref dims, i + 1);

            expr.binexpr.rhs = GenIndexExpr(ref indexes, ref dims, i + 1);
            return expr;
        }
        void GenArrayAddr(List<NodeExpr> indexes, Token ident, string? DestReg = null)
        {
            m_outputcode.AppendLine($"# begin array address");
            string reg = DestReg ?? "$1";
            List<NodeTermIntLit> dims = m_Arraydims[ident.Value];
            Shartilities.Assert(indexes.Count == dims.Count, "Generator: indexes and dimensionality are not equal\n");

            // arr[i][j][k] = arr[index], s.t index = (i * dim[1] * dim[2]) + (j * dim[2]) + k
            // we get the address from GenExpr(index), then GenPop(reg)
            NodeExpr index = GenIndexExpr(ref indexes, ref dims, 0);
            GenExpr(index, reg);

            int relative_location = m_StackSize - VariableLocation(ident.Value);
            m_outputcode.Append($"SUB {reg}, $zero, {reg}\n");
            m_outputcode.Append($"ADDI {reg}, {reg}, {relative_location}\n");
            m_outputcode.Append($"ADD {reg}, {reg}, $sp\n");
            if (DestReg == null)
                GenPush(reg);
            m_outputcode.AppendLine($"# end array address");
        }
        void GenTerm(NodeTerm term, string? DestReg = null)
        {
            if (term.type == NodeTerm.NodeTermType.intlit)
            {
                string reg = DestReg ?? "$1";
                string sign = (term.Negative) ? "-" : "";
                m_outputcode.Append($"ADDI {reg}, $zero, {sign}{term.intlit.intlit.Value}\n");
                if (DestReg == null)
                    GenPush(reg);
            }
            else if (term.type == NodeTerm.NodeTermType.ident)
            {
                m_outputcode.Append($"########## {term.ident.ident.Value}\n");
                NodeTermIdent ident = term.ident;
                if (!IsVariableDeclared(ident.ident.Value))
                {
                    Error($"variable {ident.ident.Value} is not declared", ident.ident.Line);
                }
                if (ident.indexes.Count == 0)
                {
                    string reg = DestReg ?? "$1";
                    int relative_location = m_StackSize - VariableLocation(ident.ident.Value);
                    m_outputcode.Append($"LW {reg}, {relative_location}($sp)\n");
                    if (term.Negative)
                        m_outputcode.Append($"SUB {reg}, $zero, {reg}\n");
                    if (DestReg == null)
                        GenPush(reg);
                }
                else
                {
                    string reg_addr = "$1";
                    string reg = DestReg ?? "$2";

                    m_outputcode.Append($"# begin index\n");
                    GenArrayAddr(ident.indexes, ident.ident, reg_addr);
                    m_outputcode.Append($"# end index\n");

                    m_outputcode.Append($"# begin data\n");
                    m_outputcode.Append($"LW {reg}, 0({reg_addr})\n");
                    if (term.Negative)
                        m_outputcode.Append($"SUB {reg}, $zero, {reg}\n");
                    if (DestReg == null)
                        GenPush(reg);
                    m_outputcode.Append($"# end data\n");
                }
            }
            else if (term.type == NodeTerm.NodeTermType.paren)
            {
                GenExpr(term.paren.expr, DestReg);
            }
        }
        void GenBinExpr(NodeBinExpr binExpr, string? DestReg = null)
        {
            string reg = DestReg ?? "$1";
            string reg2 = "$2";
            GenExpr(binExpr.rhs);
            GenExpr(binExpr.lhs, reg);
            GenPop(reg2);
            switch (binExpr.type)
            {
                case NodeBinExpr.NodeBinExprType.add:
                    m_outputcode.Append($"ADD {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.sub:
                    m_outputcode.Append($"SUB {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.sll:
                    m_outputcode.Append($"SLL {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.srl:
                    m_outputcode.Append($"SRL {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.equalequal:
                    m_outputcode.Append($"SEQ {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.notequal:
                    m_outputcode.Append($"SNE {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.lessthan:
                    m_outputcode.Append($"SLT {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.greaterthan:
                    m_outputcode.Append($"SGT {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.and:
                    m_outputcode.Append($"AND {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.or:
                    m_outputcode.Append($"OR {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.xor:
                    m_outputcode.Append($"XOR {reg}, {reg}, {reg2}\n");
                    break;    
                case NodeBinExpr.NodeBinExprType.mult:
                    m_outputcode.Append($"MUL {reg}, {reg}, {reg2}\n");
                    break;    
                default:
                    Error("expected binary operator", -1);
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
                    Error($"variable {ident.Value} is already declared", ident.Line);
                }
                else
                {
                    GenExpr(declare.singlevar.expr);
                    vars.m_vars.Add(new(ident.Value, 1));
                }
            }
            else if (declare.type == NodeStmtDeclare.NodeStmtDeclareType.Array)
            {
                Token ident = declare.array.ident;
                if (IsVariableDeclared(ident.Value))
                {
                    Error($"variable {ident.Value} is already declared", ident.Line);
                }
                else
                {
                    List<NodeTermIntLit> dims = m_Arraydims[declare.array.ident.Value];
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
                    m_outputcode.Append($"ADDI $sp, $sp, -{count}\n");
                    m_StackSize += (count);
                    vars.m_vars.Add(new(ident.Value, count));
                }
            }
        }
        void GenMult(string reg, string intlit)
        {
            string count = "$8";
            string temp = "$9";
            m_outputcode.Append($"ADDI {count}, $zero, {intlit}\n");
            m_outputcode.Append($"ADD {temp}, $zero, {reg}\n");
            string label_start = $"LABEL{m_labels_count++}_START";
            string label_end = $"LABEL{m_labels_count++}_END";

            m_outputcode.Append($"{label_start}:\n");
            m_outputcode.Append($"ADDI {count}, {count}, -1\n");
            m_outputcode.Append($"BEQ {count}, $zero, {label_end}\n");
            m_outputcode.Append($"ADD {reg}, {reg}, {temp}\n");
            m_outputcode.Append($"J {label_start}\n");
            m_outputcode.Append($"{label_end}:\n");
        }

        void GenArrayAssign(NodeStmtAssignArray array)
        {
            string reg_addr = "$1";
            string reg_data = "$2";
            GenArrayAddr(array.indexes, array.ident);
            GenExpr(array.expr, reg_data);
            GenPop(reg_addr);
            m_outputcode.Append($"SW {reg_data}, 0({reg_addr})\n");
        }
        void GenStmtAssign(NodeStmtAssign assign)
        {
            if (assign.type == NodeStmtAssign.NodeStmtAssignType.SingleVar)
            {
                Token ident = assign.singlevar.ident;
                string reg = "$1";
                if (!IsVariableDeclared(ident.Value))
                {
                    Error($"variable {ident.Value} is not declared", ident.Line);
                }
                GenExpr(assign.singlevar.expr, reg);
                int relative_location = m_StackSize - VariableLocation(ident.Value);
                m_outputcode.Append($"SW {reg}, {relative_location}($sp)\n");
            }
            else if (assign.type == NodeStmtAssign.NodeStmtAssignType.Array)
            {
                Token ident = assign.array.ident;
                if (!IsVariableDeclared(ident.Value))
                {
                    Error($"variable {ident.Value} is not declared", ident.Line);
                }
                GenArrayAssign(assign.array);
            }
        }
        void GenElifs(NodeIfElifs elifs, string label_end)
        {
            if (elifs.type == NodeIfElifs.NodeIfElifsType.elif)
            {
                string reg = "$1";
                string label = $"LABEL{m_labels_count++}_elifs";
                GenExpr(elifs.elif.pred.cond, reg);
                m_outputcode.Append($"BEQ $1, $zero, {label}\n");
                GenScope(elifs.elif.pred.scope);
                m_outputcode.Append($"J {label_end}\n");
                if (elifs.elif.elifs.HasValue)
                {
                    m_outputcode.Append($"J {label_end}\n");
                    m_outputcode.Append($"{label}:\n");
                    GenElifs(elifs.elif.elifs.Value, label_end);
                }
                else
                {
                    m_outputcode.Append($"{label}:\n");
                }
            }
            else if (elifs.type == NodeIfElifs.NodeIfElifsType.elsee)
            {
                GenScope(elifs.elsee.scope);
            }
            else
            {
                Error("UNREACHABLE", -1);
            }
        }
        string GenStmtIF(NodeStmtIF iff)
        {
            string reg = "$1";
            string label_start = $"LABEL{m_labels_count++}_START";
            string label_end = $"LABEL{m_labels_count++}_END";
            string label = $"LABEL{m_labels_count++}_elifs";

            m_outputcode.Append($"{label_start}:\n");
            GenExpr(iff.pred.cond, reg);
            m_outputcode.Append($"BEQ $1, $zero, {label}\n");
            GenScope(iff.pred.scope);
            if (iff.elifs.HasValue)
            {
                m_outputcode.Append($"J {label_end}\n");
                m_outputcode.Append($"{label}:\n");
                GenElifs(iff.elifs.Value, label_end);
            }
            else
            {
                m_outputcode.Append($"{label}:\n");
            }
            m_outputcode.Append($"{label_end}:\n");
            return label_start;
        }
        void GenStmtFor(NodeStmtFor forr)
        {
            m_outputcode.Append("# begin forloop\n");
            BeginScope();
            if (forr.pred.init.HasValue)
            {
                m_outputcode.Append("# begin init\n");
                if (forr.pred.init.Value.type == NodeForInit.NodeForInitType.declare)
                    GenStmtDeclare(forr.pred.init.Value.declare);
                else if (forr.pred.init.Value.type == NodeForInit.NodeForInitType.assign)
                    GenStmtAssign(forr.pred.init.Value.assign);
                m_outputcode.Append("# end init\n");
            }
            if (forr.pred.cond.HasValue)
            {
                m_outputcode.Append("# begin condition\n");
                string label_start = $"TEMP_LABEL{m_labels_count++}_START";
                string label_end = $"TEMP_LABEL{m_labels_count++}_END";
                string label_update = $"TEMP_LABEL{m_labels_count++}_START";

                m_outputcode.Append($"{label_start}:\n");
                string reg = "$1";
                GenExpr(forr.pred.cond.Value.cond, reg);
                m_outputcode.Append($"BEQ $1, $zero, {label_end}\n");
                m_outputcode.Append("# end condition\n");
                m_scopestart.Push(label_update);
                m_scopeend.Push(label_end);
                GenScope(forr.pred.scope);
                m_scopestart.Pop();
                m_scopeend.Pop();
                m_outputcode.Append("# begin update\n");
                m_outputcode.Append($"{label_update}:\n");
                if (forr.pred.udpate.HasValue)
                {
                    for (int i = 0; i < forr.pred.udpate.Value.udpates.Count; i++)
                    {
                        GenStmtAssign(forr.pred.udpate.Value.udpates[i]);
                    }
                }
                m_outputcode.Append("# end update\n");
                m_outputcode.Append($"J {label_start}\n");
                m_outputcode.Append($"{label_end}:\n");
            }
            else if (forr.pred.udpate.HasValue)
            {
                string label_start = $"TEMP_LABEL{m_labels_count++}_START";
                string label_end = $"TEMP_LABEL{m_labels_count++}_END";
                string label_update = $"TEMP_LABEL{m_labels_count++}_START";

                m_outputcode.Append($"{label_start}:\n");
                m_scopestart.Push(label_update);
                m_scopeend.Push(label_end);
                GenScope(forr.pred.scope);
                m_scopestart.Pop();
                m_scopeend.Pop();
                m_outputcode.Append("# begin update\n");
                m_outputcode.Append($"{label_update}:\n");
                for (int i = 0; i < forr.pred.udpate.Value.udpates.Count; i++)
                {
                    GenStmtAssign(forr.pred.udpate.Value.udpates[i]);
                }
                m_outputcode.Append("# end update\n");
                m_outputcode.Append($"J {label_start}\n");
                m_outputcode.Append($"{label_end}:\n");
            }
            else
            {
                string label_start = $"TEMP_LABEL{m_labels_count++}_START";
                string label_end = $"TEMP_LABEL{m_labels_count++}_END";

                m_outputcode.Append($"{label_start}:\n");
                m_scopestart.Push(label_start);
                m_scopeend.Push(label_end);
                GenScope(forr.pred.scope);
                m_scopestart.Pop();
                m_scopeend.Pop();
                m_outputcode.Append($"J {label_start}\n");
                m_outputcode.Append($"{label_end}:\n");
            }
            EndScope();
            m_outputcode.Append("# end forloop\n");
        }
        void GenStmtWhile(NodeStmtWhile whilee)
        {
            m_outputcode.Append("# begin whileloop\n");
            BeginScope();
            m_outputcode.Append("# begin condition\n");
            string label_start = $"TEMP_LABEL{m_labels_count++}_START";
            string label_end = $"TEMP_LABEL{m_labels_count++}_END";

            m_outputcode.Append($"{label_start}:\n");
            string reg = "$1";
            GenExpr(whilee.cond, reg);
            m_outputcode.Append($"BEQ $1, $zero, {label_end}\n");
            m_outputcode.Append("# end condition\n");
            m_scopestart.Push(label_start);
            m_scopeend.Push(label_end);
            GenScope(whilee.scope);
            m_scopestart.Pop();
            m_scopeend.Pop();
            m_outputcode.Append($"J {label_start}\n");
            m_outputcode.Append($"{label_end}:\n");
            EndScope();
            m_outputcode.Append("# end whileloop\n");
        }
        void GenStmtBreak(NodeStmtBreak breakk)
        {
            if (m_scopeend.Count == 0)
                Error("no enclosing loop out of which to break", breakk.breakk.Line);
            m_outputcode.Append($"J {m_scopeend.Peek()}\n");
        }
        void GenStmtContinue(NodeStmtContinuee continuee)
        {
            if (m_scopestart.Count == 0)
                Error("no enclosing loop out of which to break", continuee.continuee.Line);
            m_outputcode.Append($"J {m_scopestart.Peek()}\n");
        }
        void GenStmtExit(NodeStmtExit exit)
        {
            string reg = "$1";
            GenExpr(exit.expr, reg);
            m_outputcode.Append("HLT\n");
        }
        void GenStmtCleanStack(NodeStmtCleanStack CleanStack)
        {
            m_outputcode.Append($"ADDI $1, $zero, 0\n");
            m_outputcode.Append($"ADDI $2, $zero, {STACK_CAPACITY + 1}\n");
            m_outputcode.Append($"Clean_Loop:\n");
            m_outputcode.Append($"SW $zero, 0($1)\n");
            m_outputcode.Append($"ADDI $1, $1, 1\n");
            m_outputcode.Append($"BNE $1, $2, Clean_Loop\n");
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
            else if (stmt.type == NodeStmt.NodeStmtType.Exit)
            {
                GenStmtExit(stmt.Exit);
            }
            else if (stmt.type == NodeStmt.NodeStmtType.CleanSack)
            {
                GenStmtCleanStack(stmt.CleanStack);
            }
        }

        public StringBuilder GenProg()
        {
            m_outputcode.Append(".text\n");
            m_outputcode.Append("main:\n");
            m_outputcode.Append($"ADDI $sp, $zero, {STACK_CAPACITY}\n");
            foreach (NodeStmt stmt in m_prog.scope.stmts)
                GenStmt(stmt);

            return m_outputcode;
        }
    }
}
#pragma warning restore CS8500
