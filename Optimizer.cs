#pragma warning disable RETURN0001
using System;
using System.Collections.Generic;
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
                    return stmt.declare.ident;
                case NodeStmt.NodeStmtType.Assign:
                    switch (stmt.assign.type)
                    {
                        case NodeStmtIdentifierType.SingleVar:
                            return stmt.assign.singlevar.ident;
                        case NodeStmtIdentifierType.Array:
                            return stmt.assign.array.ident;
                        default:
                            break;
                    }
                    break;
                case NodeStmt.NodeStmtType.If:
                case NodeStmt.NodeStmtType.For:
                case NodeStmt.NodeStmtType.While:
                case NodeStmt.NodeStmtType.Asm:
                case NodeStmt.NodeStmtType.Scope:
                case NodeStmt.NodeStmtType.Break:
                case NodeStmt.NodeStmtType.Continue:
                case NodeStmt.NodeStmtType.Function:
                case NodeStmt.NodeStmtType.Return:
                case NodeStmt.NodeStmtType.Exit:
                default:
                    Shartilities.Logln(Shartilities.LogType.ERROR, $"cannot get an identifier from {stmt.type}", 1);
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
                    foreach (var expr in term.functioncall.parameters)
                        if (IsIdentUsedInExpr(ident, expr)) return true;
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
        static NodeIfElifs FoldElifs(NodeIfElifs elifs)
        {
            switch (elifs.type)
            {
                case NodeIfElifs.NodeIfElifsType.Elif:
                    elifs.elif.pred.cond = FoldExpr(elifs.elif.pred.cond);
                    elifs.elif.pred.scope.stmts = [.. FoldStmts([.. elifs.elif.pred.scope.stmts])];
                    if (elifs.elif.elifs.HasValue)
                        elifs.elif.elifs = FoldElifs(elifs.elif.elifs.Value);
                    break;
                case NodeIfElifs.NodeIfElifsType.Else:
                    elifs.elsee.scope.stmts = [.. FoldStmts([.. elifs.elsee.scope.stmts])];
                    break;
                default:
                    Shartilities.UNREACHABLE("IsIdentUsedInElifs");
                    break;
            }
            return elifs;
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
                                if (ident.Value == stmt.assign.singlevar.ident.Value) return true;
                                if (IsIdentUsedInExpr(ident, stmt.assign.singlevar.expr)) return true;
                                break;
                            case NodeStmtIdentifierType.Array:
                                if (ident.Value == stmt.assign.array.ident.Value) return true;
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
                    case NodeStmt.NodeStmtType.Continue:
                        return false;
                    case NodeStmt.NodeStmtType.Function:
                        foreach (var expr in stmt.CalledFunction.parameters)
                            if (IsIdentUsedInExpr(ident, expr)) return true;
                        break;
                    case NodeStmt.NodeStmtType.Return:
                        if (IsIdentUsedInExpr(ident, stmt.Return.expr)) return true;
                        break;
                    case NodeStmt.NodeStmtType.Exit:
                        if (IsIdentUsedInExpr(ident, stmt.Exit.expr)) return true;
                        break;
                    default:
                        Shartilities.UNREACHABLE("invalid statement type");
                        break;
                }
            }
            return false;
        }
        static List<NodeStmt> EliminateStmts(List<NodeStmt> stmts)
        {
            List<NodeStmt> NewStmts = [];
            for (int j = 0; j < stmts.Count; j++)
            {
                NodeStmt stmt = stmts[j];
                switch (stmt.type)
                {
                    case NodeStmt.NodeStmtType.Declare:
                        {
                            Token? ident = GetIdentFromStmt(stmt);
                            if (!ident.HasValue)
                                Shartilities.UNREACHABLE("DeadCodeElimination::case NodeStmt.NodeStmtType.Declare");
                            else if (IsIdentUsedInStmts(ident.Value, stmts[(j + 1)..]))
                                NewStmts.Add(stmt);
                            break;
                        }
                    case NodeStmt.NodeStmtType.Assign:
                        {
                            Token? ident = GetIdentFromStmt(stmt);
                            if (!ident.HasValue)
                                Shartilities.UNREACHABLE("DeadCodeElimination::case NodeStmt.NodeStmtType.Assign");
                            else if (IsIdentUsedInStmts(ident.Value, stmts[(j + 1)..]))
                                NewStmts.Add(stmt);
                            break;
                        }
                    case NodeStmt.NodeStmtType.If:
                        // TODO: we could eliminate `if` statements if their behaviour can be know at compile time, like the condition results
                        // and optimize the scopes of the if, elifs, ..., else
                        NewStmts.Add(stmt);
                        break;
                    case NodeStmt.NodeStmtType.For:
                        // TODO: loop unrolling can be done as a for-loop optimization
                        // and general scope optimization
                        NewStmts.Add(stmt);
                        break;
                    case NodeStmt.NodeStmtType.While:
                        // TODO: general scope optimization, that's what i could think of righ now, may need more search
                        NewStmts.Add(stmt);
                        break;
                    case NodeStmt.NodeStmtType.Asm:
                        // TODO: should we analyze the inline assembly to optimize it out??
                        NewStmts.Add(stmt);
                        break;
                    case NodeStmt.NodeStmtType.Scope:
                        if (stmt.Scope.stmts.Count != 0)
                        {
                            // add more optimizations for nested scopes
                            NewStmts.Add(stmt);
                        }
                        break;
                    case NodeStmt.NodeStmtType.Break:
                    case NodeStmt.NodeStmtType.Continue:
                    case NodeStmt.NodeStmtType.Return:
                    case NodeStmt.NodeStmtType.Exit:
                        NewStmts.Add(stmt);
                        return NewStmts;
                    case NodeStmt.NodeStmtType.Function:
                        // TODO: have to further analyze what does the funciton does to optimize it out
                        NewStmts.Add(stmt);
                        break;
                    default:
                        Shartilities.UNREACHABLE("invalid statement type");
                        break;
                }
            }
            return NewStmts;
        }
        static void DeadCodeElimination(ref NodeProg prog)
        {
            Shartilities.UNUSED(prog);
            // TODO: nested scopes
            // TODO: other functions, not only `main()`
            List<NodeStmt> stmts = [.. prog.UserDefinedFunctions["main"].FunctionBody.stmts];
            int Runs = 1;
            for (int i = 0; i < Runs; i++)
            {
                stmts = [.. EliminateStmts([.. stmts])];
            }
            var temp = prog.UserDefinedFunctions["main"];
            temp.FunctionBody.stmts = [.. stmts];
            prog.UserDefinedFunctions["main"] = temp;
        }
        static bool IsExprIntLit(NodeExpr expr) => expr.type == NodeExpr.NodeExprType.Term && expr.term.type == NodeTerm.NodeTermType.IntLit;
        static string GetImmedOperation(string imm1, string imm2, NodeBinExpr.NodeBinExprType op)
        {
            Int64 a = Convert.ToInt64(imm1);
            Int64 b = Convert.ToInt64(imm2);

            switch (op)
            {
                case NodeBinExpr.NodeBinExprType.Add:
                    return (a + b).ToString();
                case NodeBinExpr.NodeBinExprType.Sub:
                    return (a - b).ToString();
                case NodeBinExpr.NodeBinExprType.Sll:
                    return (a << (Int32)b).ToString();
                case NodeBinExpr.NodeBinExprType.Srl:
                    return (a >>> (Int32)b).ToString();
                case NodeBinExpr.NodeBinExprType.EqualEqual:
                    return (a == b ? 1 : 0).ToString();
                case NodeBinExpr.NodeBinExprType.NotEqual:
                    return (a != b ? 1 : 0).ToString();
                case NodeBinExpr.NodeBinExprType.LessThan:
                    return (a < b ? 1 : 0).ToString();
                case NodeBinExpr.NodeBinExprType.And:
                    return (a & b).ToString();
                case NodeBinExpr.NodeBinExprType.Or:
                    return (a | b).ToString();
                case NodeBinExpr.NodeBinExprType.Xor:
                    return (a ^ b).ToString();
                case NodeBinExpr.NodeBinExprType.Mul:
                    return (a * b).ToString();
                case NodeBinExpr.NodeBinExprType.Div:
                    return (a / b).ToString();
                case NodeBinExpr.NodeBinExprType.Rem:
                    return (a % b).ToString();
                default:
                    Shartilities.UNREACHABLE("GetImmedOperation");
                    return "";
            }
        }
        static NodeTerm FoldTerm(NodeTerm term)
        {
            switch (term.type)
            {
                case NodeTerm.NodeTermType.IntLit:
                case NodeTerm.NodeTermType.StringLit:
                case NodeTerm.NodeTermType.FunctionCall:
                case NodeTerm.NodeTermType.Ident:
                    return term;
                case NodeTerm.NodeTermType.Paren:
                    term.paren.expr = FoldExpr(term.paren.expr);
                    if (IsExprIntLit(term.paren.expr))
                        return new() { type = NodeTerm.NodeTermType.IntLit, intlit = term.paren.expr.term.intlit };
                    return term;
                case NodeTerm.NodeTermType.Unary:
                    term.unary.term = FoldTerm(term.unary.term);
                    return term;
                case NodeTerm.NodeTermType.Variadic:
                    term.variadic.VariadicIndex = FoldExpr(term.variadic.VariadicIndex);
                    return term;
                default:
                    Shartilities.UNREACHABLE("FoldTerm");
                    return new();
            }
        }
        static NodeExpr FoldExpr(NodeExpr expr)
        {
            switch (expr.type)
            {
                case NodeExpr.NodeExprType.Term:
                    expr.term = FoldTerm(expr.term);
                    return expr;
                case NodeExpr.NodeExprType.BinExpr:
                    expr.binexpr.lhs = FoldExpr(expr.binexpr.lhs);
                    expr.binexpr.rhs = FoldExpr(expr.binexpr.rhs);
                    if (IsExprIntLit(expr.binexpr.lhs) && IsExprIntLit(expr.binexpr.rhs))
                    {
                        string constant1 = expr.binexpr.lhs.term.intlit.intlit.Value;
                        string constant2 = expr.binexpr.rhs.term.intlit.intlit.Value;
                        string value = GetImmedOperation(constant1, constant2, expr.binexpr.type);
                        return NodeExpr.Number(value, expr.binexpr.lhs.term.intlit.intlit.Line);
                    }
                    return expr;
                case NodeExpr.NodeExprType.None:
                    return expr;
                default:
                    Shartilities.UNREACHABLE("FoldExpr");
                    return expr;
            }
        }
        static List<NodeStmt> FoldStmts(List<NodeStmt> stmts)
        {
            List<NodeStmt> FoldedStmts = [];
            for (int j = 0; j < stmts.Count; j++)
            {
                NodeStmt stmt = stmts[j];
                switch (stmt.type)
                {
                    case NodeStmt.NodeStmtType.Declare:
                        switch (stmt.declare.type)
                        {
                            case NodeStmtIdentifierType.SingleVar:
                                stmt.declare.singlevar.expr = FoldExpr(stmt.declare.singlevar.expr);
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
                                stmt.assign.singlevar.expr = FoldExpr(stmt.assign.singlevar.expr);
                                break;
                            case NodeStmtIdentifierType.Array:
                                for (int i = 0; i < stmt.assign.array.indexes.Count; i++)
                                {
                                    stmt.assign.array.indexes[i] = FoldExpr(stmt.assign.array.indexes[i]);
                                }
                                stmt.assign.array.expr = FoldExpr(stmt.assign.array.expr);
                                break;
                            default:
                                Shartilities.UNREACHABLE("IdentIsUsedInStmt::case NodeStmt.NodeStmtType.Assign");
                                break;
                        }
                        break;
                    case NodeStmt.NodeStmtType.If:
                        stmt.If.pred.cond = FoldExpr(stmt.If.pred.cond);
                        stmt.If.pred.scope.stmts = [.. FoldStmts(stmt.If.pred.scope.stmts)];
                        if (stmt.If.elifs.HasValue)
                            stmt.If.elifs = FoldElifs(stmt.If.elifs.Value);
                        break;
                    case NodeStmt.NodeStmtType.For:
                        if (stmt.For.pred.init.HasValue)
                        {
                            switch (stmt.For.pred.init.Value.type)
                            {
                                case NodeForInit.NodeForInitType.Declare:
                                    stmt.For.pred.init = new() 
                                    {
                                        type = NodeForInit.NodeForInitType.Declare,
                                        declare = FoldStmts([new() { type = NodeStmt.NodeStmtType.Declare, declare = stmt.For.pred.init.Value.declare }])[0].declare,
                                    };
                                    break;
                                case NodeForInit.NodeForInitType.Assign:
                                    stmt.For.pred.init = new()
                                    {
                                        type = NodeForInit.NodeForInitType.Assign,
                                        assign = FoldStmts([new() { type = NodeStmt.NodeStmtType.Assign, assign = stmt.For.pred.init.Value.assign }])[0].assign,
                                    };
                                    break;
                                default:
                                    Shartilities.UNREACHABLE("IsIdentUsedInFor");
                                    break;
                            }
                        }
                        if (stmt.For.pred.cond.HasValue)
                        {
                            stmt.For.pred.cond = new(FoldExpr(stmt.For.pred.cond.Value.cond));
                        }
                        List<NodeStmt> AssignStmts = [];
                        foreach (var s in stmt.For.pred.udpate.updates)
                            AssignStmts.Add(new() { type = NodeStmt.NodeStmtType.Assign, assign = s });
                        AssignStmts = [.. FoldStmts([.. AssignStmts])];
                        for (int i = 0; i < AssignStmts.Count; i++)
                            stmt.For.pred.udpate.updates[i] = AssignStmts[i].assign;
                        stmt.For.pred.scope.stmts = [.. FoldStmts([.. stmt.For.pred.scope.stmts])];
                        break;
                    case NodeStmt.NodeStmtType.While:
                        stmt.While.cond = FoldExpr(stmt.While.cond);
                        stmt.While.scope.stmts = [.. FoldStmts(stmt.While.scope.stmts)];
                        break;
                    case NodeStmt.NodeStmtType.Scope:
                        stmt.Scope.stmts = [.. FoldStmts(stmt.Scope.stmts)];
                        break;
                    case NodeStmt.NodeStmtType.Asm:
                    case NodeStmt.NodeStmtType.Break:
                    case NodeStmt.NodeStmtType.Continue:
                        break;
                    case NodeStmt.NodeStmtType.Function:
                        for (int i = 0; i < stmt.CalledFunction.parameters.Count; i++)
                            stmt.CalledFunction.parameters[i] = FoldExpr(stmt.CalledFunction.parameters[i]);
                        break;
                    case NodeStmt.NodeStmtType.Return:
                        stmt.Return.expr = FoldExpr(stmt.Return.expr);
                        break;
                    case NodeStmt.NodeStmtType.Exit:
                        stmt.Exit.expr = FoldExpr(stmt.Exit.expr);
                        break;
                    default:
                        Shartilities.UNREACHABLE("invalid statement type");
                        break;
                }
                FoldedStmts.Add(stmt);
            }
            return FoldedStmts;
        }
        static void ConstantFolding(ref NodeProg prog)
        {
            Shartilities.UNUSED(prog);
            // TODO: other functions, not only `main()`
            foreach (var func in prog.UserDefinedFunctions)
            {
                var temp = prog.UserDefinedFunctions[func.Key];
                NodeStmtScope FoldedMainScope = new(FoldStmts([.. prog.UserDefinedFunctions[func.Key].FunctionBody.stmts]));
                temp.FunctionBody.stmts = [.. FoldedMainScope.stmts];
                prog.UserDefinedFunctions[func.Key] = temp;
            }
        }
        public static void OptimizeProgram(ref NodeProg prog)
        {
            //DeadCodeElimination(ref prog);
            ConstantFolding(ref prog);
        }
    }
}
