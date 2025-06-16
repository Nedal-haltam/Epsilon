


using System.Runtime.InteropServices;

namespace Epsilon
{
    public struct NodeProg
    {
        public NodeStmtScope scope;
        public NodeProg()
        {
            scope = new();
        }
    }
    public struct NodeStmtScope
    {
        public List<NodeStmt> stmts;
        public NodeStmtScope()
        {
            stmts = [];
        }
    }
    public struct NodeStmt
    {
        public enum NodeStmtType
        {
            declare, assign, If, For, While, Scope, Break, Continue, Function, Return, Exit
        }
        public NodeStmtType type;
        public NodeStmtDeclare declare;
        public NodeStmtAssign assign;
        public NodeStmtIF If;
        public NodeStmtFor For;
        public NodeStmtWhile While;
        public NodeStmtScope Scope;
        public NodeStmtBreak Break;
        public NodeStmtContinuee Continue;
        public NodeStmtFunctionCall CalledFunction;
        public NodeStmtReturn Return;
        public NodeStmtExit Exit;
    }
    public struct NodeStmtDeclare
    {
        public enum NodeStmtDeclareType
        {
            SingleVar, Array
        }
        public NodeStmtDeclareType type;
        public NodeStmtDeclareSingleVar singlevar;
        public NodeStmtDeclareArray array;
    }
    public struct NodeStmtAssign
    {
        public enum NodeStmtAssignType
        {
            SingleVar, Array
        }
        public NodeStmtAssignType type;
        public NodeStmtAssignSingleVar singlevar;
        public NodeStmtAssignArray array;
    }

    public struct NodeStmtDeclareSingleVar
    {
        public Token ident;
        public NodeExpr expr;
    }
    public struct NodeStmtDeclareArray
    {
        public Token ident;
        public List<NodeExpr> values;
        public NodeStmtDeclareArray()
        {
            values = [];
        }
    }
    public struct NodeStmtAssignSingleVar
    {
        public Token ident;
        public NodeExpr expr;
    }
    public struct NodeStmtAssignArray
    {
        public Token ident;
        public List<NodeExpr> indexes;
        public NodeExpr expr;
        public NodeStmtAssignArray()
        {
            indexes = [];
        }
    }




    public class NodeStmtIF
    {
        public NodeIfPredicate pred;
        public NodeIfElifs? elifs;
        public NodeStmtIF()
        {
            pred = new NodeIfPredicate();
            elifs = null;
        }
    }
    public struct NodeIfPredicate
    {
        public NodeExpr cond;
        public NodeStmtScope scope;
    }
    public struct NodeIfElifs
    {
        public enum NodeIfElifsType
        {
            elif, elsee
        }
        public NodeIfElifsType type;
        public NodeElif elif;
        public NodeElse elsee;
        public NodeIfElifs()
        {
            type = NodeIfElifsType.elsee;
            elif = new NodeElif();
            elsee = new NodeElse();
        }
    }
    public class NodeElif
    {
        public NodeIfPredicate pred;
        public NodeIfElifs? elifs;
    }
    public struct NodeElse
    {
        public NodeStmtScope scope;
    }








    public struct NodeStmtFor
    {
        public NodeForPredicate pred;
    }
    public struct NodeForPredicate
    {
        public NodeForInit? init;
        public NodeForCond? cond;
        public NodeForUpdate udpate;
        public NodeStmtScope scope;
    }
    public struct NodeForInit
    {
        public enum NodeForInitType
        {
            declare, assign
        }
        public NodeForInitType type;
        public NodeStmtDeclare declare;
        public NodeStmtAssign assign;
    }
    public struct NodeForCond
    {
        public NodeExpr cond;
    }
    public struct NodeForUpdate
    {
        public List<NodeStmtAssign> udpates;
    }

    public struct NodeStmtWhile
    {
        public NodeExpr cond;
        public NodeStmtScope scope;
    }

    public struct NodeStmtBreak
    {
        public Token breakk;
    }
    public struct NodeStmtContinuee
    {
        public Token continuee;
    }

    public struct NodeStmtFunction
    {
        public Token FunctionName;
        public List<Var> parameters;
        public NodeStmtScope FunctionBody;
        public Dictionary<string, List<NodeTermIntLit>> DimensionsOfArrays;
    }

    public struct NodeStmtReturn
    {
        public NodeExpr expr;
    }

    public struct NodeStmtFunctionCall
    {
        public Token FunctionName;
        public List<NodeExpr> parameters;
    }

    public struct NodeStmtExit
    {
        public NodeExpr expr;
    }





    public struct NodeExpr
    {
        public enum NodeExprType
        {
            term, binExpr, none
        }
        public NodeExprType type;
        public NodeTerm term;
        public NodeBinExpr binexpr;

        public static NodeExpr Number(string num, int line)
        {
            return new NodeExpr()
            {
                type = NodeExprType.term,
                term = new()
                {
                    type = NodeTerm.NodeTermType.intlit,
                    intlit = new()
                    {
                        intlit = new()
                        {
                            Type = TokenType.IntLit,
                            Value = num,
                            Line = -1,
                        }
                    }
                }
            };
        }
    }
    public struct NodeTerm
    {
        public enum NodeTermType
        {
            intlit, stringlit, functioncall, ident, paren
        }
        public NodeTermType type;
        public bool Negative;
        public NodeTermIntLit intlit;
        public NodeTermStringLit stringlit;
        public NodeTermFunctionCall functioncall;
        public NodeTermIdent ident;
        public NodeTermParen paren;
    }
    public struct NodeTermIntLit
    {
        public Token intlit;
    }
    public struct NodeTermStringLit
    {
        public Token stringlit;
    }
    public struct NodeTermFunctionCall
    {
        public Token FunctionName;
        public List<NodeExpr> parameters;
    }
    public class NodeTermIdent
    {
        public Token ident;
        public List<NodeExpr> indexes;
        private bool m_ByValue = true;
        private bool m_ByRef = false;
        public bool ByValue
        {
            get
            {
                return m_ByValue;
            }
            set
            {
                m_ByValue = value;
                m_ByRef = !value;
            }
        }
        public bool ByRef
        {
            get
            {
                return m_ByRef;
            }
            set
            {
                m_ByRef = value;
                m_ByValue = !value;
            }
        }
        public NodeTermIdent()
        {
            indexes = [];
            m_ByValue = true;
            m_ByRef = false;
        }
    }
    public class NodeTermParen
    {
        public NodeExpr expr;
    }


    public class NodeBinExpr 
    {
        public enum NodeBinExprType
        {
            add, sub, mul, rem, div, sll, srl, equalequal, notequal, lessthan, and, or, xor
        }
        public NodeBinExprType type;
        public NodeExpr lhs;
        public NodeExpr rhs;
    }
}