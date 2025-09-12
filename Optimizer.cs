using System.Collections.Generic;
using static System.Formats.Asn1.AsnWriter;
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
        static bool IdentIsUsedInStmt(Token ident, List<NodeStmt> stmts)
        {
            Shartilities.TODO("IdentIsUsed");
            Shartilities.UNUSED(ident);
            for (int i = 0; i < stmts.Count; i++)
            {
                // TODO: switch upon all stmt types
            }
            return false;
        }
        public static NodeProg OptimizeProgram(NodeProg prog)
        {
            NodeProg prevprog = prog;
            NodeProg newprog = new();

            // TODO: nested scopes
            // TODO: other functions, not only `main()`
            int Runs = 1;
            for (int i = 0; i < Runs; i++)
            {
                for (int j = 0; j < prevprog.scope.stmts.Count; j++)
                {
                    NodeStmt stmt = prevprog.scope.stmts[j];
                    switch(stmt.type)
                    {
                        case NodeStmt.NodeStmtType.Declare:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "Declare");
                            break;
                        case NodeStmt.NodeStmtType.Assign:
                            Shartilities.Logln(Shartilities.LogType.ERROR, "Assign");
                            Token? ident = GetIdentFromStmt(stmt);
                            if (!ident.HasValue)
                                Shartilities.UNREACHABLE("");
                            else if (IdentIsUsedInStmt(ident.Value, prevprog.scope.stmts[(j + 1)..]))
                                newprog.scope.stmts.Add(stmt);
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
                }
                prevprog = newprog;
                newprog = new();
            }

            return prevprog;
        }
    }
}
