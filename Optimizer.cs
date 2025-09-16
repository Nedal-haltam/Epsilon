#pragma warning disable RETURN0001
using System.Runtime.InteropServices;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Epsilon
{
    static class Optimizer
    {
        static Token? GetIdentFromStmt(NodeStmt stmt)
        {
            switch (stmt.type)
            {
                case NodeStmt.NodeStmtType.Declare:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "Declare");
                    //return stmt.declare.ident;
                    break;
                case NodeStmt.NodeStmtType.Assign:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "Assign");
                    if (stmt.assign.type == NodeStmtIdentifierType.SingleVar)
                        return stmt.assign.singlevar.ident;
                    else if (stmt.assign.type == NodeStmtIdentifierType.Array)
                        return stmt.assign.array.ident;
                    else
                        Shartilities.UNREACHABLE("GetIdentFromStmt");
                    break;
                case NodeStmt.NodeStmtType.If:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "If");
                    break;
                case NodeStmt.NodeStmtType.For:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "For");
                    break;
                case NodeStmt.NodeStmtType.While:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "While");
                    break;
                case NodeStmt.NodeStmtType.Asm:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "Asm");
                    break;
                case NodeStmt.NodeStmtType.Scope:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "Scope");
                    break;
                case NodeStmt.NodeStmtType.Break:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "Break");
                    break;
                case NodeStmt.NodeStmtType.Continue:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "Continue");
                    break;
                case NodeStmt.NodeStmtType.Function:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "Function");
                    break;
                case NodeStmt.NodeStmtType.Return:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "Return");
                    break;
                case NodeStmt.NodeStmtType.Exit:
                    Shartilities.Logln(Shartilities.LogType.ERROR, "Exit");
                    break;
                default:
                    Shartilities.UNREACHABLE("invalid statement type");
                    break;
            }
            return null;
        }
        static bool IsIdentUsedInTerm(Token ident, NodeTerm term)
        {
            switch (term.type)
            {
                case NodeTerm.NodeTermType.IntLit:
                case NodeTerm.NodeTermType.StringLit:
                    return false;
                case NodeTerm.NodeTermType.FunctionCall:
                    Shartilities.TODO("IsIdentUsedInTerm::case NodeTerm.NodeTermType.FunctionCall");
                    return false;
                case NodeTerm.NodeTermType.Ident:
                    return ident.Value == term.ident.ident.Value;
                case NodeTerm.NodeTermType.Paren:
                    return IsIdentUsedInExpr(ident, term.paren.expr);
                case NodeTerm.NodeTermType.Unary:
                    return IsIdentUsedInTerm(ident, term.unary.term);
                case NodeTerm.NodeTermType.Variadic:
                    return IsIdentUsedInExpr(ident, term.variadic.VariadicIndex);
                default:
                    Shartilities.UNREACHABLE("IsIdentUsedInTerm");
                    return false;
            }
        }
        static bool IsIdentUsedInExpr(Token ident, NodeExpr expr)
        {
            switch (expr.type)
            {
                case NodeExpr.NodeExprType.Term:
                    return IsIdentUsedInTerm(ident, expr.term);
                case NodeExpr.NodeExprType.BinExpr:
                    return IsIdentUsedInExpr(ident, expr.binexpr.lhs) || IsIdentUsedInExpr(ident, expr.binexpr.rhs);
                case NodeExpr.NodeExprType.None:
                    return false;
                default:
                    Shartilities.UNREACHABLE("IsIdentUsedInExpr");
                    return false;

            }
        }
        static bool IsIdentUsedInElifs(Token ident, NodeIfElifs elifs)
        {
            switch (elifs.type)
            {
                case NodeIfElifs.NodeIfElifsType.Elif:
                    if (IsIdentUsedInExpr(ident, elifs.elif.pred.cond)) return true;
                    if (IsIdentUsedInStmts(ident, elifs.elif.pred.scope.stmts)) return true;
                    if (elifs.elif.elifs.HasValue && IsIdentUsedInElifs(ident, elifs.elif.elifs.Value)) return true;
                    break;
                case NodeIfElifs.NodeIfElifsType.Else:
                    if (IsIdentUsedInStmts(ident, elifs.elsee.scope.stmts)) return true;
                    break;
                default:
                    Shartilities.UNREACHABLE("IsIdentUsedInElifs");
                    break;
            }
            return false;
        }
        static bool IsIdentUsedInFor(Token ident, NodeStmtFor For)
        {
            if (For.pred.init.HasValue)
            {
                switch (For.pred.init.Value.type)
                {
                    case NodeForInit.NodeForInitType.Declare:
                        if (IsIdentUsedInStmts(ident, [new() { type = NodeStmt.NodeStmtType.Declare, declare = For.pred.init.Value.declare }])) return true;
                        break;
                    case NodeForInit.NodeForInitType.Assign:
                        if (IsIdentUsedInStmts(ident, [new() { type = NodeStmt.NodeStmtType.Assign, assign = For.pred.init.Value.assign }])) return true;
                        break;
                    default:
                        Shartilities.UNREACHABLE("IsIdentUsedInFor");
                        break;
                }
            }
            if (For.pred.cond.HasValue && IsIdentUsedInExpr(ident, For.pred.cond.Value.cond)) return true;
            List<NodeStmt> AssignStmts = [];
            foreach (var s in For.pred.udpate.updates)
                AssignStmts.Add(new() { type = NodeStmt.NodeStmtType.Assign, assign = s });
            if (IsIdentUsedInStmts(ident, AssignStmts)) return true;
            if (IsIdentUsedInStmts(ident, For.pred.scope.stmts)) return true;
            return false;
        }
        static bool IsIdentUsedInStmts(Token ident, List<NodeStmt> stmts)
        {
            for (int i = 0; i < stmts.Count; i++)
            {
                NodeStmt stmt = stmts[i];
                switch (stmt.type)
                {
                    case NodeStmt.NodeStmtType.Declare:
                        switch (stmt.declare.type)
                        {
                            case NodeStmtIdentifierType.SingleVar:
                                if (IsIdentUsedInExpr(ident, stmt.declare.singlevar.expr)) return true;
                                break;
                            case NodeStmtIdentifierType.Array:
                                // TODO: implement when array initialization upon declaration is supported
                                break;
                            default:
                                Shartilities.UNREACHABLE("IdentIsUsedInStmt::case NodeStmt.NodeStmtType.Declare");
                                break;
                        }
                        break;
                    case NodeStmt.NodeStmtType.Assign:
                        switch (stmt.assign.type)
                        {
                            case NodeStmtIdentifierType.SingleVar:
                                if (IsIdentUsedInExpr(ident, stmt.assign.singlevar.expr)) return true;
                                break;
                            case NodeStmtIdentifierType.Array:
                                if (IsIdentUsedInExpr(ident, stmt.assign.array.expr)) return true;
                                break;
                            default:
                                Shartilities.UNREACHABLE("IdentIsUsedInStmt::case NodeStmt.NodeStmtType.Assign");
                                break;
                        }
                        break;
                    case NodeStmt.NodeStmtType.If:
                        if (IsIdentUsedInExpr(ident, stmt.If.pred.cond)) return true;
                        if (IsIdentUsedInStmts(ident, stmt.If.pred.scope.stmts)) return true;
                        if (stmt.If.elifs.HasValue && IsIdentUsedInElifs(ident, stmt.If.elifs.Value)) return true;
                        break;
                    case NodeStmt.NodeStmtType.For:
                        if (IsIdentUsedInFor(ident, stmt.For)) return true;
                        break;
                    case NodeStmt.NodeStmtType.While:
                        if (IsIdentUsedInExpr(ident, stmt.While.cond)) return true;
                        if (IsIdentUsedInStmts(ident, stmt.While.scope.stmts)) return true;
                        break;
                    case NodeStmt.NodeStmtType.Asm:
                        // TODO: have to analyze it but for now we will not optimize it out if there is inline assembly
                        return true;
                        //break;
                    case NodeStmt.NodeStmtType.Scope:
                        if (IsIdentUsedInStmts(ident, stmt.Scope.stmts)) return true;
                        break;
                    case NodeStmt.NodeStmtType.Break:
                        Shartilities.Logln(Shartilities.LogType.ERROR, "Break");
                        break;
                    case NodeStmt.NodeStmtType.Continue:
                        Shartilities.Logln(Shartilities.LogType.ERROR, "Continue");
                        break;
                    case NodeStmt.NodeStmtType.Function:
                        Shartilities.Logln(Shartilities.LogType.ERROR, "Function");
                        break;
                    case NodeStmt.NodeStmtType.Return:
                        Shartilities.Logln(Shartilities.LogType.ERROR, "Return");
                        break;
                    case NodeStmt.NodeStmtType.Exit:
                        Shartilities.Logln(Shartilities.LogType.ERROR, "Exit");
                        break;
                    default:
                        Shartilities.UNREACHABLE("invalid statement type");
                        break;
                }
            }
            return false;
        }
        public static void OptimizeProgram(ref NodeProg prog, ref Dictionary<string, NodeStmtFunction> funcs)
        {
            Shartilities.UNUSED(prog);
            // TODO: nested scopes
            // TODO: other functions, not only `main()`
            NodeStmtScope PrevMainScope = new(funcs["main"].FunctionBody.stmts);
            NodeStmtScope NewMainScope = new();
            int Runs = 2;
            for (int i = 0; i < Runs; i++)
            {
                for (int j = 0; j < PrevMainScope.stmts.Count; j++)
                {
                    NodeStmt stmt = PrevMainScope.stmts[j];
                    switch(stmt.type)
                    {
                        case NodeStmt.NodeStmtType.Declare:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "Declare");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.Assign:
                            Token? ident = GetIdentFromStmt(stmt);
                            if (!ident.HasValue)
                                Shartilities.UNREACHABLE("OptimizeProgram::case NodeStmt.NodeStmtType.Assign");
                            else if (IsIdentUsedInStmts(ident.Value, PrevMainScope.stmts[(j + 1)..]))
                                NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.If:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "didn't optimize: If");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.For:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "didn't optimize: For");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.While:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "didn't optimize: While");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.Asm:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "didn't optimize: Asm");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.Scope:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "didn't optimize: Scope");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.Break:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "didn't optimize: Break");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.Continue:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "didn't optimize: Continue");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.Function:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "didn't optimize: Function");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.Return:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "didn't optimize: Return");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        case NodeStmt.NodeStmtType.Exit:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "didn't optimize: Exit");
                            NewMainScope.stmts.Add(stmt);
                            break;
                        default:
                            Shartilities.UNREACHABLE("invalid statement type");
                            break;
                    }
                }
                PrevMainScope = new(NewMainScope.stmts);
                NewMainScope = new();
            }
            var temp = funcs["main"];
            temp.FunctionBody.stmts = [.. PrevMainScope.stmts];
            funcs["main"] = temp;
        }
    }
}
