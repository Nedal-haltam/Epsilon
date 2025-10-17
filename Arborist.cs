using Epsilon;
using System.Text;
using static Epsilon.NodeBinExpr;
using static Epsilon.NodeTermUnaryExpr;

static class Arborist
{
    static string GetBinOpStr(NodeBinExprType type)
    {
        switch (type)
        {
            case NodeBinExprType.Add: return "+";
            case NodeBinExprType.Sub: return "-";
            case NodeBinExprType.Mul: return "*";
            case NodeBinExprType.Rem: return "%";
            case NodeBinExprType.Div: return "/";
            case NodeBinExprType.Sll: return "<<";
            case NodeBinExprType.Sra: return ">>";
            case NodeBinExprType.EqualEqual: return "==";
            case NodeBinExprType.NotEqual: return "!=";
            case NodeBinExprType.LessThan: return "<";
            case NodeBinExprType.And: return "&";
            case NodeBinExprType.Or: return "|";
            case NodeBinExprType.Xor: return "^";
            default:
                Shartilities.UNREACHABLE("GetBinOpStr");
                break;
        }
        return "";
    }
    static string GetUnOpStr(NodeTermUnaryExprType type)
    {
        switch (type)
        {
            case NodeTermUnaryExprType.negative: return "-";
            case NodeTermUnaryExprType.complement: return "!";
            case NodeTermUnaryExprType.not: return "~";
            case NodeTermUnaryExprType.addressof: return "&";
            case NodeTermUnaryExprType.deref: return "*";
            default:
                Shartilities.UNREACHABLE("GetUnOpStr");
                break;
        }
        return "";
    }
    static StringBuilder CutTerm(NodeTerm term)
    {
        StringBuilder sb = new();
        switch (term.type)
        {
            case NodeTerm.NodeTermType.IntLit:
                sb.Append($"{term.intlit.intlit.Value}");
                break;
            case NodeTerm.NodeTermType.StringLit:
                sb.Append($"\"{term.stringlit.stringlit.Value}\"");
                break;
            case NodeTerm.NodeTermType.FunctionCall:
                sb.Append($"{term.functioncall.FunctionName.Value}");
                sb.Append($"(");
                for (int j = 0; j < term.functioncall.parameters.Count; j++)
                {
                    sb.Append($"{CutExpr(term.functioncall.parameters[j])}");
                    if (j != term.functioncall.parameters.Count - 1) sb.Append(", ");
                }
                sb.Append($")");
                break;
            case NodeTerm.NodeTermType.Ident:
                sb.Append($"{term.ident.ident.Value}");
                for (int i = 0; i < term.ident.indexes.Count; i++)
                    sb.Append($"[{CutExpr(term.ident.indexes[i])}]");
                break;
            case NodeTerm.NodeTermType.Paren:
                sb.Append($"({CutExpr(term.paren.expr)})");
                break;
            case NodeTerm.NodeTermType.Unary:
                sb.Append($"{GetUnOpStr(term.unary.type)}{CutTerm(term.unary.term)}");
                break;
            case NodeTerm.NodeTermType.Variadic:
                sb.Append($"__VARIADIC_ARGS__({CutExpr(term.variadic.VariadicIndex)})");
                break;
            default:
                Shartilities.UNREACHABLE("CutTerm");
                break;
        }
        return sb;
    }
    static StringBuilder CutExpr(NodeExpr expr)
    {
        StringBuilder sb = new();
        switch (expr.type)
        {
            case NodeExpr.NodeExprType.Term:
                sb.Append($"{CutTerm(expr.term)}");
                break;
            case NodeExpr.NodeExprType.BinExpr:
                sb.Append($"{CutExpr(expr.binexpr.lhs)} {GetBinOpStr(expr.binexpr.type)} {CutExpr(expr.binexpr.rhs)}");
                break;
            case NodeExpr.NodeExprType.None:
                break;
            default:
                Shartilities.UNREACHABLE("CutExpr");
                break;
        }
        return sb;
    }
    static StringBuilder CutElifs(NodeIfElifs elifs, int pad)
    {
        StringBuilder sb = new();
        string pp = "".PadLeft(pad, ' ');
        switch (elifs.type)
        {
            case NodeIfElifs.NodeIfElifsType.Elif:
                sb.AppendLine($"{pp}elif ({CutExpr(elifs.elif.pred.cond)})");
                sb.AppendLine($"{pp}{{");
                sb.Append($"{CutStmts(elifs.elif.pred.scope.stmts, pad + 4)}");
                sb.AppendLine($"{pp}}}");
                if (elifs.elif.elifs.HasValue) sb.Append($"{CutElifs(elifs.elif.elifs.Value, pad)}");
                break;
            case NodeIfElifs.NodeIfElifsType.Else:
                sb.AppendLine($"{pp}else");
                sb.AppendLine($"{pp}{{");
                sb.Append($"{CutStmts(elifs.elsee.scope.stmts, pad + 4)}");
                sb.AppendLine($"{pp}}}");
                break;
            default:
                Shartilities.UNREACHABLE("CutElifs");
                break;
        }
        return sb;
    }
    static StringBuilder CutStmts(List<NodeStmt> stmts, int pad = 0)
    {
        StringBuilder sb = new();
        string pp = "".PadLeft(pad, ' ');
        for (int i = 0; i < stmts.Count; i++)
        {
            NodeStmt stmt = stmts[i];
            switch (stmt.type)
            {
                case NodeStmt.NodeStmtType.Declare:
                    sb.Append(pp);
                    sb.Append($"{stmt.declare.datatype.ToString().ToLower()} ");
                    sb.Append($"{stmt.declare.ident.Value}");
                    switch (stmt.declare.type)
                    {
                        case NodeStmtIdentifierType.SingleVar:
                            if (stmt.declare.singlevar.expr.type != NodeExpr.NodeExprType.None)
                            {
                                sb.Append($" = ");
                                sb.Append($"{CutExpr(stmt.declare.singlevar.expr)}");
                            }
                            sb.AppendLine($";");
                            break;
                        case NodeStmtIdentifierType.Array:
                            foreach (var dim in stmt.declare.array.Dimensions)
                                sb.Append($"[{dim}]");
                            sb.AppendLine($";");
                            break;
                        default:
                            break;
                    }
                    break;
                case NodeStmt.NodeStmtType.Assign:
                    sb.Append(pp);
                    switch (stmt.assign.type)
                    {
                        case NodeStmtIdentifierType.SingleVar:
                            sb.Append($"{stmt.assign.singlevar.ident.Value}");
                            if (stmt.assign.singlevar.expr.type != NodeExpr.NodeExprType.None)
                            {
                                sb.Append($" = ");
                                sb.Append($"{CutExpr(stmt.assign.singlevar.expr)}");
                            }
                            sb.AppendLine($";");
                            break;
                        case NodeStmtIdentifierType.Array:
                            sb.Append($"{stmt.assign.array.ident.Value}");
                            foreach (var expr in stmt.assign.array.indexes)
                                sb.Append($"[{CutExpr(expr)}]");
                            sb.Append($" = ");
                            sb.Append($"{CutExpr(stmt.assign.array.expr)}");
                            sb.AppendLine($";");
                            break;
                        default:
                            break;
                    }
                    break;
                case NodeStmt.NodeStmtType.If:
                    sb.AppendLine($"{pp}if ({CutExpr(stmt.If.pred.cond)})");
                    sb.AppendLine($"{pp}{{");
                    sb.Append($"{CutStmts(stmt.If.pred.scope.stmts, pad + 4)}");
                    sb.AppendLine($"{pp}}}");
                    if (stmt.If.elifs.HasValue) sb.Append($"{CutElifs(stmt.If.elifs.Value, pad)}");
                    break;
                case NodeStmt.NodeStmtType.For:
                    StringBuilder cond = stmt.For.pred.cond.HasValue ? CutExpr(stmt.For.pred.cond.Value.cond) : new();
                    //init
                    //udpate
                    sb.Append($"for (TODO;{cond};TODO)");
                    sb.AppendLine($"{pp}{{");
                    sb.Append($"{CutStmts(stmt.For.pred.scope.stmts, pad + 4)}");
                    sb.AppendLine($"{pp}}}");
                    break;
                case NodeStmt.NodeStmtType.While:
                    sb.AppendLine($"{pp}while ({CutExpr(stmt.While.cond)})");
                    sb.AppendLine($"{pp}{{");
                    sb.Append($"{CutStmts(stmt.While.scope.stmts, pad + 4)}");
                    sb.AppendLine($"{pp}}}");
                    break;
                case NodeStmt.NodeStmtType.Asm:
                    sb.AppendLine($"{pp}asm(\"{stmt.Asm.assembly.Value}\");");
                    break;
                case NodeStmt.NodeStmtType.Scope:
                    sb.AppendLine($"{pp}{{");
                    sb.Append($"{CutStmts(stmt.Scope.stmts, pad + 4)}");
                    sb.AppendLine($"{pp}}}");
                    break;
                case NodeStmt.NodeStmtType.Break:
                    sb.AppendLine($"{pp}break;");
                    break;
                case NodeStmt.NodeStmtType.Continue:
                    sb.AppendLine($"{pp}continue;");
                    break;
                case NodeStmt.NodeStmtType.Function:
                    sb.Append($"{pp}{stmt.CalledFunction.FunctionName.Value}");
                    sb.Append($"(");
                    for (int j = 0; j < stmt.CalledFunction.parameters.Count; j++)
                    {
                        sb.Append($"{CutExpr(stmt.CalledFunction.parameters[j])}");
                        if (j != stmt.CalledFunction.parameters.Count - 1) sb.Append(", ");
                    }
                    sb.AppendLine($");");
                    break;
                case NodeStmt.NodeStmtType.Return:
                    sb.AppendLine($"{pp}return {CutExpr(stmt.Return.expr)};");
                    break;
                case NodeStmt.NodeStmtType.Exit:
                    sb.AppendLine($"{pp}exit({CutExpr(stmt.Exit.expr)});");
                    break;
                default:
                    Shartilities.UNREACHABLE("CutStmts");
                    return new();
            }
        }
        return sb;
    }
    static StringBuilder CutFunctionParameters(List<Var> vars)
    {
        StringBuilder sb = new();

        for (int i = 0; i < vars.Count; i++)
        {
            Var parameter = vars[i];
            if (parameter.ElementSize == 1) sb.Append($"char ");
            else if (parameter.ElementSize == 8) sb.Append($"auto ");
            //else Shartilities.Logln(Shartilities.LogType.ERROR, $"invalid ElementSize {parameter.ElementSize}", 1);

            sb.Append(parameter.Value);
            if (parameter.IsParameter && parameter.IsArray)
                for (int j = 0; j < parameter.Dimensions.Count; j++)
                    sb.Append($"[]");



            if (i != vars.Count - 1) sb.Append($", ");
        }

        return sb;
    }
    static StringBuilder CutFunction(KeyValuePair<string, NodeStmtFunction> Function)
    {
        StringBuilder sb = new();
        string Name = Function.Key;
        List<Var> Parameters = Function.Value.parameters;
        NodeStmtScope FunctionBody = Function.Value.FunctionBody;

        sb.Append($"func {Name}(");
        sb.Append(CutFunctionParameters(Parameters));
        sb.AppendLine($")");
        sb.AppendLine($"{{");
        sb.Append(CutStmts(FunctionBody.stmts, 4));
        sb.AppendLine($"}}");

        return sb;
    }
    public static StringBuilder CutProgram(NodeProg Prog)
    {
        StringBuilder sb = new();

        sb.Append(CutStmts(Prog.GlobalScope.stmts));
        foreach (var func in Prog.UserDefinedFunctions)
            sb.AppendLine($"{CutFunction(func)}");

        return sb;
    }
}
