using static Epsilon.NodeBinExpr;

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
            Declare, Assign, If, For, While, Scope, Break, Continue, Function, Return, Exit
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
    public enum NodeStmtIdentifierType
    {
        SingleVar, Array
    }
    public enum NodeStmtDataType
    {
        Auto, Char
    }
    public struct NodeStmtDeclare
    {
        public NodeStmtIdentifierType type;
        public NodeStmtDataType datatype;
        public NodeStmtDeclareSingleVar singlevar;
        public NodeStmtDeclareArray array;
    }
    public struct NodeStmtAssign
    {
        public NodeStmtIdentifierType type;
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
            Elif, Else
        }
        public NodeIfElifsType type;
        public NodeElif elif;
        public NodeElse elsee;
        public NodeIfElifs()
        {
            type = NodeIfElifsType.Else;
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
            Declare, Assign
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
        public NodeForUpdate()
        {
            updates = [];
        }
        public List<NodeStmtAssign> updates;
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
        public NodeExpr()
        {
            type = NodeExprType.None;
            binexpr = new();
        }
        public enum NodeExprType
        {
            Term, BinExpr, None
        }
        public NodeExprType type;
        public NodeTerm term;
        public NodeBinExpr binexpr;
        public static NodeExpr BinExpr(NodeBinExprType type, NodeExpr lhs, NodeExpr rhs)
        {
            return new()
            {
                type = NodeExprType.BinExpr,
                binexpr = new()
                {
                    type = type,
                    lhs = lhs,
                    rhs = rhs,
                },
            };
        }
        public static NodeExpr Number(string num, int line)
        {
            return new NodeExpr()
            {
                type = NodeExprType.Term,
                term = new()
                {
                    type = NodeTerm.NodeTermType.IntLit,
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
            IntLit, StringLit, FunctionCall, Ident, Paren
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
            Add, Sub, Mul, Rem, Div, Sll, Srl, EqualEqual, NotEqual, LessThan, And, Or, Xor
        }
        public NodeBinExprType type;
        public NodeExpr lhs;
        public NodeExpr rhs;
    }
}