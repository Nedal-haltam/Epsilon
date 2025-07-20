using System.Collections.Generic;
using static Epsilon.NodeBinExpr;

namespace Epsilon
{
    public struct NodeProg
    {
        public NodeStmtScope scope;
        public NodeStmtScope GlobalScope;
        public NodeProg()
        {
            scope = new();
            GlobalScope = new();
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
        public Token ident;
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
        public NodeExpr expr;
    }
    public struct NodeStmtDeclareArray
    {
        public List<NodeExpr> values;
        public List<uint> Dimensions;
        public NodeStmtDeclareArray()
        {
            values = [];
            Dimensions = [];
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
                            Line = line,
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
            IntLit, StringLit, FunctionCall, Ident, Paren, Unary, Variadic
        }
        public NodeTermType type;
        public NodeTermIntLit intlit;
        public NodeTermStringLit stringlit;
        public NodeTermFunctionCall functioncall;
        public NodeTermIdent ident;
        public NodeTermParen paren;
        public NodeTermUnaryExpr unary;
        public NodeTermVariadic variadic;
    }
    public class NodeTermVariadic
    {
        public NodeExpr VariadicIndex;
    }
    public class NodeTermUnaryExpr
    {
        public enum NodeTermUnaryExprType
        {
            negative, complement, not, addressof
        }
        public NodeTermUnaryExprType type;
        public NodeTerm term;
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
        public NodeTermIdent()
        {
            indexes = [];
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

    public struct Var(string value, uint size, uint ElementSize, List<uint> Dimensions, bool IsArray, bool IsParameter, bool IsVariadic, bool IsGlobal = false)
    {
        public uint ElementSize = ElementSize;
        public uint TypeSize
        {
            readonly get
            {
                return (IsArray && IsParameter) || IsVariadic ? 8 : ElementSize;
            }
            set
            {
                ElementSize = value;
            } 
        }
        public readonly uint Count => Size / ElementSize;
        public string Value { get; set; } = value;
        public uint Size { get; set; } = size;
        public bool IsParameter = IsParameter;
        public bool IsArray = IsArray;
        public bool IsVariadic = IsVariadic;
        public bool IsGlobal = IsGlobal;
        public List<uint> Dimensions = [.. Dimensions];
    }
    public struct Variables
    {
        List<Var> m_vars;
        public List<Var> m_globals;
        public readonly int VariablesCount() => m_vars.Count;
        public Variables()
        {
            m_vars = [];
            m_globals = [];
        }
        public void Reset()
        {
            m_vars.Clear();
            m_vars = [];
        }
        public readonly void AddVariable(Var var)
        {
            m_vars.Add(var);
        }
        public readonly void RemoveRange(int startindex, int count)
        {
            m_vars.RemoveRange(startindex, count);
        }
        public readonly bool IsVariableDeclared(string name)
        {
            return m_vars.Any(x => x.Value == name) || m_globals.Any(x => x.Value == name);
        }
        public readonly Var GetVariable(string name, string filepath, int line)
        {
            int index = m_vars.FindIndex(x => x.Value == name);
            if (index != -1)
                return m_vars[index];
            index = m_globals.FindIndex(x => x.Value == name);
            if (index != -1)
                return m_globals[index];
            Shartilities.Log(Shartilities.LogType.ERROR, $"{filepath}:{line}:1:  variable `{name}` is undeclared\n", 1);
            return new();
        }
        public readonly Var GetVariadic()
        {
            int index = m_vars.FindIndex(x => x.IsVariadic);
            if (index == -1)
                Shartilities.Log(Shartilities.LogType.ERROR, $"no variadic are declared\n", 1);
            return m_vars[index];
        }
        public readonly uint GetVariableRelativeLocation(string name, uint m_StackSize)
        {
            uint size = 0;
            int index = m_vars.FindIndex(x => x.Value == name);
            Var var = m_vars[index];
            for (int i = 0; i < index; i++)
            {
                if (m_vars[i].IsArray && m_vars[i].IsParameter)
                    size += 8;
                else
                    size += m_vars[i].Size;
            }
            return m_StackSize - size - var.TypeSize;
        }
        public readonly uint GetVariableRelativeLocation(Var var, uint m_StackSize) => GetVariableRelativeLocation(var.Value, m_StackSize);
        public readonly uint GetAllocatedStackSize()
        {
            uint stacksize = 0;
            for (int i = 0; i < m_vars.Count; i++)
            {
                if (m_vars[i].IsParameter && m_vars[i].IsArray)
                    stacksize += 8;
                else
                    stacksize += m_vars[i].Size;
            }
            return stacksize;
        }
        public readonly Var this[int index]
        {
            get
            {
                Shartilities.Assert(0 <= index && index < m_vars.Count, $"index out of bound in variable indexing\n");
                return m_vars[index];
            }
            set
            {
                Shartilities.Assert(0 <= index && index < m_vars.Count, $"index out of bound in variable indexing\n");
                m_vars[index] = value;
            }
        }
    }
    public struct Token
    {
        public TokenType Type;
        public string Value;
        public int Line;
    }
    public enum TokenType
    {
        OpenParen,
        CloseParen,
        OpenSquare,
        CloseSquare,
        OpenCurly,
        CloseCurly,

        Comma,
        Equal,
        SemiColon,

        ExclamationMark,
        tilde,

        Plus,
        Minus,
        Mul,
        Rem,
        Div,

        And,
        Or,
        Xor,
        Sll,
        Srl,

        EqualEqual,
        NotEqual,
        LessThan,

        Ident,

        IntLit,
        StringLit,

        Auto,
        Char,

        If,
        Elif,
        Else,
        For,
        While,

        Func,
        Variadic,

        Continue,
        Break,

        Exit,
        Return,
    }
    public struct Macro
    {
        public List<Token> tokens;
        public string src;
    }
}