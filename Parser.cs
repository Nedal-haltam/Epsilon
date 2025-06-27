using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Reflection.Metadata;
using System.Runtime.CompilerServices;


#pragma warning disable IDE0017

namespace Epsilon
{
    class Parser(List<Token> tokens, string InputFilePath)
    {
        private readonly List<Token> m_tokens = tokens;
        private readonly string m_inputFilePath = InputFilePath;
        private int m_curr_index = 0;
        public Dictionary<string, List<uint>> DimensionsOfArrays = [];
        public Dictionary<string, NodeStmtFunction> UserDefinedFunctions = [];
        public List<string> STD_FUNCTIONS = ["strlen", "itoa", "write"];

        public string GetImmedOperation(string imm1, string imm2, NodeBinExpr.NodeBinExprType op)
        {
            Int64 a = Convert.ToInt64(imm1);
            Int64 b = Convert.ToInt32(imm2);

            if (op == NodeBinExpr.NodeBinExprType.Add)
                return (a + b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Sub)
                return (a - b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Sll)
                return (a << (Int32)b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Srl)
                return (a >> (Int32)b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.EqualEqual)
                return (a == b ? 1 : 0).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.NotEqual)
                return (a != b ? 1 : 0).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.LessThan)
                return (a < b ? 1 : 0).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.And)
                return (a & b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Or)
                return (a | b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Xor)
                return (a ^ b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Mul)
                return (a * b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Div)
                return (a / b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Rem)
                return (a % b).ToString();
            Token? peeked = Peek(-1);
            int line = peeked.HasValue ? peeked.Value.Line : 1;
            Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Generator: invalid operation `{op}`\n", 1);
            return "";
        }
        Token? Peek(int offset = 0) => 0 <= m_curr_index + offset && m_curr_index + offset < m_tokens.Count ? m_tokens[m_curr_index + offset] : null;
        Token ? Peek(TokenType type, int offset = 0)
        {
            Token? token = Peek(offset);
            if (token.HasValue && token.Value.Type == type)
            {
                return token;
            }
            return null;
        }
        Token? PeekAndConsume(TokenType type, int offset = 0) => Peek(type, offset).HasValue ? Consume() : null;
        Token Consume() => m_tokens.ElementAt(m_curr_index++);
        Token TryConsumeError(TokenType type)
        {
            if (!Peek(type).HasValue)
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: Error expected `{type}` on line {line}\n", 1);
            }
            return Consume();
        }
        bool IsStmtDeclare()  => (Peek(TokenType.Auto).HasValue || Peek(TokenType.Char).HasValue) && Peek(TokenType.Ident, 1).HasValue;
        bool IsStmtAssign()   => Peek(TokenType.Ident).HasValue && (Peek(TokenType.OpenSquare, 1).HasValue || Peek(TokenType.Equal, 1).HasValue);
        bool IsStmtIF()       => Peek(TokenType.If).HasValue;
        bool IsStmtFor()      => Peek(TokenType.For).HasValue;
        bool IsStmtWhile()    => Peek(TokenType.While).HasValue;
        bool IsStmtBreak()    => Peek(TokenType.Break).HasValue;
        bool IsStmtContinue() => Peek(TokenType.Continue).HasValue;
        bool IsStmtExit()     => Peek(TokenType.Exit).HasValue && Peek(TokenType.OpenParen, 1).HasValue;
        bool IsBinExpr()      => Peek(TokenType.Plus).HasValue       ||
                                 Peek(TokenType.Mul).HasValue        ||
                                 Peek(TokenType.Rem).HasValue        ||
                                 Peek(TokenType.Div).HasValue        ||
                                 Peek(TokenType.Minus).HasValue      ||
                                 Peek(TokenType.And).HasValue        ||
                                 Peek(TokenType.Or).HasValue         ||
                                 Peek(TokenType.Xor).HasValue        ||
                                 Peek(TokenType.Sll).HasValue        ||
                                 Peek(TokenType.Srl).HasValue        ||
                                 Peek(TokenType.EqualEqual).HasValue ||
                                 Peek(TokenType.NotEqual).HasValue   ||
                                 Peek(TokenType.LessThan).HasValue;
        NodeExpr ExpectedExpression(NodeExpr? expr)
        {
            if (!expr.HasValue)
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: expected expression\n", 1);
                return new();
            }
            return expr.Value;
        }
        NodeExpr Parseindex()
        {
            Consume();
            NodeExpr index = ExpectedExpression(ParseExpr());
            TryConsumeError(TokenType.CloseSquare);
            return index;
        }
        NodeTerm? ParseTerm()
        {
            NodeTerm term = new();
            if (Peek(TokenType.Minus).HasValue)
            {
                Consume();
                NodeTerm? termunary = ParseTerm();
                if (!termunary.HasValue)
                    return null;
                term.type = NodeTerm.NodeTermType.Unary;
                term.unary = new()
                {
                    type = NodeTermUnaryExpr.NodeTermUnaryExprType.negative,
                    term = termunary.Value,
                };
                return term;
            }
            if (Peek(TokenType.ExclamationMark).HasValue)
            {
                Consume();
                NodeTerm? termunary = ParseTerm();
                if (!termunary.HasValue)
                    return null;
                term.type = NodeTerm.NodeTermType.Unary;
                term.unary = new()
                {
                    type = NodeTermUnaryExpr.NodeTermUnaryExprType.complement,
                    term = termunary.Value,
                };
                return term;
            }
            else if (Peek(TokenType.tilde).HasValue)
            {
                Consume();
                NodeTerm? termunary = ParseTerm();
                if (!termunary.HasValue)
                    return null;
                term.type = NodeTerm.NodeTermType.Unary;
                term.unary = new()
                {
                    type = NodeTermUnaryExpr.NodeTermUnaryExprType.not,
                    term = termunary.Value,
                };
                return term;
            }
            else if (Peek(TokenType.IntLit).HasValue)
            {
                term.type = NodeTerm.NodeTermType.IntLit;
                term.intlit = new()
                {
                    intlit = Consume()
                };
                return term;
            }
            else if (Peek(TokenType.StringLit).HasValue)
            {
                term.type = NodeTerm.NodeTermType.StringLit;
                term.stringlit = new()
                {
                    stringlit = Consume()
                };
                return term;
            }
            else if (Peek(TokenType.Ident).HasValue && Peek(TokenType.OpenParen, 1).HasValue)
            {
                term.type = NodeTerm.NodeTermType.FunctionCall;
                term.functioncall = new()
                {
                    FunctionName = Consume()
                };

                TryConsumeError(TokenType.OpenParen);
                List<NodeExpr> parameters = [];
                if (!Peek(TokenType.CloseParen).HasValue)
                    do
                    {
                        NodeExpr expr = ExpectedExpression(ParseExpr());
                        parameters.Add(expr);
                    } while (PeekAndConsume(TokenType.Comma).HasValue);
                TryConsumeError(TokenType.CloseParen);

                term.functioncall.parameters = parameters;
                return term;
            }
            else if (Peek(TokenType.Ident).HasValue)
            {
                term.type = NodeTerm.NodeTermType.Ident;
                term.ident = new()
                {
                    ident = Consume(),
                    indexes = []
                };
                while (Peek(TokenType.OpenSquare).HasValue)
                {
                    term.ident.indexes.Add(Parseindex());
                }
                term.ident.ByRef = DimensionsOfArrays.ContainsKey(term.ident.ident.Value) && term.ident.indexes.Count == 0;
                return term;
            }
            else if (Peek(TokenType.Variadic).HasValue)
            {
                Consume();
                TryConsumeError(TokenType.OpenParen);
                NodeExpr VariadicIndex = ExpectedExpression(ParseExpr());
                TryConsumeError(TokenType.CloseParen);
                term.type = NodeTerm.NodeTermType.Variadic;
                term.variadic = new() { VariadicIndex =  VariadicIndex };
                return term;
            }
            else if (Peek(TokenType.OpenParen).HasValue)
            {
                Consume();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                TryConsumeError(TokenType.CloseParen);
                if (IsExprIntLit(expr))
                {
                    term.type = NodeTerm.NodeTermType.IntLit;
                    term.intlit = expr.term.intlit;
                    return term;
                }
                else
                {
                    NodeTermParen paren = new()
                    {
                        expr = expr
                    };
                    term.type = NodeTerm.NodeTermType.Paren;
                    term.paren = paren;
                    return term;
                }
            }
            return null;
        }

        static int? GetPrec(TokenType type)
        {
            return type switch
            {
                TokenType.Mul or TokenType.Rem or TokenType.Div => 7,
                TokenType.Plus or TokenType.Minus => 6,
                TokenType.Sll or TokenType.Srl => 5,
                TokenType.LessThan => 4,
                TokenType.EqualEqual or TokenType.NotEqual => 3,
                TokenType.And => 2,
                TokenType.Xor => 1,
                TokenType.Or => 0,
               _ => null,
            };
        }
        NodeBinExpr.NodeBinExprType GetOpType(TokenType op)
        {
            if (op == TokenType.Plus)
                return NodeBinExpr.NodeBinExprType.Add;
            if (op == TokenType.Mul)
                return NodeBinExpr.NodeBinExprType.Mul;
            if (op == TokenType.Rem)
                return NodeBinExpr.NodeBinExprType.Rem;
            if (op == TokenType.Div)
                return NodeBinExpr.NodeBinExprType.Div;
            if (op == TokenType.Minus)
                return NodeBinExpr.NodeBinExprType.Sub;
            if (op == TokenType.Sll)
                return NodeBinExpr.NodeBinExprType.Sll;
            if (op == TokenType.Srl)
                return NodeBinExpr.NodeBinExprType.Srl;
            if (op == TokenType.EqualEqual)
                return NodeBinExpr.NodeBinExprType.EqualEqual;
            if (op == TokenType.NotEqual)
                return NodeBinExpr.NodeBinExprType.NotEqual;
            if (op == TokenType.LessThan)
                return NodeBinExpr.NodeBinExprType.LessThan;
            if (op == TokenType.And)
                return NodeBinExpr.NodeBinExprType.And;
            if (op == TokenType.Or)
                return NodeBinExpr.NodeBinExprType.Or;
            if (op == TokenType.Xor)
                return NodeBinExpr.NodeBinExprType.Xor;
            Token? peeked = Peek(-1);
            int line = peeked.HasValue ? peeked.Value.Line : 1;
            Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: inavalid operation `{op}`\n", 1);
            return 0;
        }
        static bool IsExprIntLit(NodeExpr expr) => expr.type == NodeExpr.NodeExprType.Term && expr.term.type == NodeTerm.NodeTermType.IntLit;
        NodeExpr? ParseExpr(int min_prec = 0)
        {
            NodeTerm? _Termlhs = ParseTerm();
            if (!_Termlhs.HasValue)
                return null;
            NodeTerm Termlhs = _Termlhs.Value;
            NodeExpr exprlhs = new()
            {
                type = NodeExpr.NodeExprType.Term,
                term = Termlhs
            };

            if (IsBinExpr())
            {
                while (true)
                {
                    Token? curr_tok = Peek();
                    int? prec;
                    if (curr_tok.HasValue)
                    {
                        prec = GetPrec(curr_tok.Value.Type);
                        if (!prec.HasValue || prec < min_prec) break;
                    }
                    else break;
                    Token Operator = Consume();
                    int next_min_prec = prec.Value + 1;
                    NodeExpr expr_rhs = ExpectedExpression(ParseExpr(next_min_prec));
                    NodeBinExpr expr = new();
                    NodeExpr expr_lhs2 = exprlhs;
                    NodeBinExpr.NodeBinExprType optype = GetOpType(Operator.Type);
                    expr.type = optype;
                    expr.lhs = expr_lhs2;
                    expr.rhs = expr_rhs;

                    if (IsExprIntLit(expr.lhs) && IsExprIntLit(expr.rhs))
                    {
                        string constant1 = expr.lhs.term.intlit.intlit.Value;
                        string constant2 = expr.rhs.term.intlit.intlit.Value;
                        string value = GetImmedOperation(constant1, constant2, expr.type);
                        exprlhs = NodeExpr.Number(value, expr.lhs.term.intlit.intlit.Line);
                    }
                    else
                    {
                        exprlhs.type = NodeExpr.NodeExprType.BinExpr;
                        exprlhs.binexpr = expr;
                    }
                }
                return exprlhs;
            }
            else
            {
                exprlhs.type = NodeExpr.NodeExprType.Term;
                exprlhs.term = Termlhs;

                return exprlhs;
            }
        }

        NodeStmtScope ParseScope()
        {
            NodeStmtScope scope = new()
            {
                stmts = []
            };
            if (Peek(TokenType.OpenCurly).HasValue)
            {
                Consume();
                while (!Peek(TokenType.CloseCurly).HasValue)
                {
                    List<NodeStmt> stmt = ParseStmt();
                    scope.stmts.AddRange(stmt);
                }
                TryConsumeError(TokenType.CloseCurly);
                return scope;
            }
            else
            {
                List<NodeStmt> stmt = ParseStmt();
                scope.stmts.AddRange(stmt);
                return scope;
            }
        }
        NodeIfElifs? ParseElifs()
        {
            NodeIfElifs elifs = new();
            if (Peek(TokenType.Elif).HasValue)
            {
                Consume();
                NodeIfPredicate pred = ParseIfPredicate();
                elifs.type = NodeIfElifs.NodeIfElifsType.Elif;
                elifs.elif = new()
                {
                    pred = pred,
                    elifs = ParseElifs()
                };
                return elifs;
            }
            else if (Peek(TokenType.Else).HasValue)
            {
                Consume();
                NodeStmtScope scope = ParseScope();
                elifs.type = NodeIfElifs.NodeIfElifsType.Else;
                elifs.elsee = new()
                {
                    scope = scope
                };
                return elifs;
            }
            return null;
        }

        NodeIfPredicate ParseIfPredicate()
        {
            if (!Peek(TokenType.OpenParen).HasValue)
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: expected `(` after `if`\n", 1);
            }
            Consume();
            NodeIfPredicate pred = new();
            NodeExpr cond = ExpectedExpression(ParseExpr());
            pred.cond = cond;
            TryConsumeError(TokenType.CloseParen);
            NodeStmtScope scope = ParseScope();
            pred.scope = scope;
            return pred;
        }
        NodeForInit? ParseForInit()
        {
            NodeForInit forinit = new();
            if (IsStmtDeclare())
            {
                List<NodeStmt> stmt = ParseDeclare();
                if (stmt.Count > 1)
                {
                    Token? peeked = Peek(-1);
                    int line = peeked.HasValue ? peeked.Value.Line : 1;
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: cannot declare more than one variable in `for-loops`\n", 1);
                }
                if (stmt[0].type != NodeStmt.NodeStmtType.Declare)
                    Shartilities.UNREACHABLE("");
                forinit.type = NodeForInit.NodeForInitType.Declare;
                forinit.declare = stmt[0].declare;
                return forinit;
            }
            else if (IsStmtAssign())
            {
                NodeStmt stmt = ParseAssign();
                TryConsumeError(TokenType.SemiColon);
                if (stmt.type != NodeStmt.NodeStmtType.Assign)
                    Shartilities.UNREACHABLE("");
                forinit.type = NodeForInit.NodeForInitType.Assign;
                forinit.assign = stmt.assign;
                return forinit;
            }
            TryConsumeError(TokenType.SemiColon);
            return null;
        }
        NodeForCond? ParseForCond()
        {
            NodeForCond? forcond = null;
            NodeExpr? cond = ParseExpr();
            if (cond.HasValue)
            {
                forcond = new()
                {
                    cond = cond.Value
                };
            }
            TryConsumeError(TokenType.SemiColon);
            return forcond;
        }
        NodeExpr ParseWhileCond()
        {
            TryConsumeError(TokenType.OpenParen);
            NodeExpr cond = ExpectedExpression(ParseExpr());
            TryConsumeError(TokenType.CloseParen);
            return cond;
        }
        NodeStmtAssign? ParseForUpdateStmt()
        {
            if (!IsStmtAssign())
                return null;
            NodeStmt stmt = ParseAssign();
            if (stmt.type != NodeStmt.NodeStmtType.Assign)
                return null;
            return stmt.assign;
        }
        NodeForUpdate ParseForUpdate()
        {
            NodeForUpdate forupdate = new();
            do
            {
                NodeStmtAssign? update = ParseForUpdateStmt();
                if (!update.HasValue)
                    break;
                forupdate.updates.Add(update.Value);
            } while (PeekAndConsume(TokenType.Comma).HasValue);
            TryConsumeError(TokenType.CloseParen);
            return forupdate;
        }
        NodeForPredicate ParseForPredicate()
        {
            NodeForPredicate pred = new();
            TryConsumeError(TokenType.OpenParen);
            pred.init = ParseForInit();
            pred.cond = ParseForCond();
            pred.udpate = ParseForUpdate();
            NodeStmtScope scope = ParseScope();
            pred.scope = scope;
            return pred;
        }
        Token Parsedimension()
        {
            Consume();
            Token size_token = Consume();
            if (!uint.TryParse(size_token.Value, out uint _))
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: Error Expected a constant size for the array on line: {size_token.Line}\n", 1);
            }
            TryConsumeError(TokenType.CloseSquare);
            return size_token;
        }
        List<NodeStmt> ParseDeclare()
        {
            Token vartype = Consume();
            List<NodeStmt> stmts = [];
            do
            {
                NodeStmt stmt = new();
                stmt.type = NodeStmt.NodeStmtType.Declare;
                stmt.declare = new();

                NodeStmtDataType DataType = new();
                if (vartype.Type == TokenType.Auto)
                    DataType = NodeStmtDataType.Auto;
                else if (vartype.Type == TokenType.Char)
                    DataType = NodeStmtDataType.Char;
                else
                {
                    Token? peeked = Peek(-1);
                    int line = peeked.HasValue ? peeked.Value.Line : 1;
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Error data type `{vartype.Value}` is not supported\n", 1);
                }
                Token Ident = Consume();
                NodeStmtIdentifierType IdentifierType = NodeStmtIdentifierType.SingleVar;

                if (Peek(TokenType.OpenSquare).HasValue)
                {
                    IdentifierType = NodeStmtIdentifierType.Array;
                    stmt.declare.array = new()
                    {
                        ident = Ident,
                        values = [],
                    };
                    if (DimensionsOfArrays.ContainsKey(Ident.Value))
                    {
                        Token? peeked = Peek(-1);
                        int line = peeked.HasValue ? peeked.Value.Line : 1;
                        Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: array `{Ident.Value}` is alread delcared\n", 1);
                    }
                    else
                    {
                        DimensionsOfArrays.Add(Ident.Value, []);
                    }
                    while (Peek(TokenType.OpenSquare).HasValue)
                    {
                        Token dim = Parsedimension();
                        DimensionsOfArrays[Ident.Value].Add(uint.Parse(dim.Value));
                    }
                }
                else
                {
                    NodeExpr DeclareExpr = new();
                    if (PeekAndConsume(TokenType.Equal).HasValue)
                        DeclareExpr = ExpectedExpression(ParseExpr());
                    stmt.declare.singlevar = new()
                    {
                        ident = Ident,
                        expr = DeclareExpr,
                    };
                }
                stmt.declare.type = IdentifierType;
                stmt.declare.datatype = DataType;
                stmts.Add(stmt);
            } while (PeekAndConsume(TokenType.Comma).HasValue);
            TryConsumeError(TokenType.SemiColon);
            return stmts;
        }
        NodeStmt ParseAssign()
        {
            Token Ident = Consume();
            NodeStmt stmt = new();
            stmt.type = NodeStmt.NodeStmtType.Assign;
            NodeStmtIdentifierType IdentifierType = new();
            if (Peek(TokenType.OpenSquare).HasValue)
            {
                IdentifierType = NodeStmtIdentifierType.Array;
                stmt.assign.array = new()
                {
                    ident = Ident,
                    indexes = [],
                };
                while (Peek(TokenType.OpenSquare).HasValue)
                {
                    stmt.assign.array.indexes.Add(Parseindex());
                }
                TryConsumeError(TokenType.Equal);
                stmt.assign.array.expr = ExpectedExpression(ParseExpr());
            }
            else if (PeekAndConsume(TokenType.Equal).HasValue)
            {
                IdentifierType = NodeStmtIdentifierType.SingleVar;
                NodeExpr expr = ExpectedExpression(ParseExpr());
                stmt.assign.singlevar = new()
                {
                    ident = Ident,
                    expr = expr,
                };
            }
            else
            {
                Shartilities.UNREACHABLE("");
            }
            stmt.assign.type = IdentifierType;
            return stmt;
        }
        List<NodeStmt> ParseStmt()
        {
            if (IsStmtDeclare())
            {
                return ParseDeclare();
            }
            else if (IsStmtAssign())
            {
                NodeStmt stmt = ParseAssign();
                TryConsumeError(TokenType.SemiColon);
                return [stmt];
            }
            else if (IsStmtIF())
            {
                Consume();
                NodeStmtIF iff = new();
                NodeIfPredicate pred = ParseIfPredicate();
                iff.pred = pred;
                NodeIfElifs? elifs = ParseElifs();
                iff.elifs = elifs;
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.If,
                    If = iff
                };
                return [stmt];
            }
            else if (IsStmtFor())
            {
                Consume();
                NodeStmtFor forr = new();
                NodeForPredicate pred = ParseForPredicate();
                forr.pred = pred;
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.For,
                    For = forr
                };
                return [stmt];
            }
            else if (IsStmtWhile())
            {
                Consume();
                NodeExpr expr = ParseWhileCond();
                NodeStmtWhile whilee = new()
                {
                    cond = expr
                };
                NodeStmtScope scope = ParseScope();
                whilee.scope = scope;
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.While,
                    While = whilee
                };
                return [stmt];
            }
            else if (Peek(TokenType.OpenCurly).HasValue)
            {
                NodeStmtScope scope = ParseScope();
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.Scope,
                    Scope = scope
                };
                return [stmt];
            }
            else if (IsStmtBreak())
            {
                Token word = Consume();
                TryConsumeError(TokenType.SemiColon);
                NodeStmtBreak breakk = new()
                {
                    breakk = word
                };
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.Break,
                    Break = breakk
                };
                return [stmt];
            }
            else if (IsStmtContinue())
            {
                Token word = Consume();
                TryConsumeError(TokenType.SemiColon);
                NodeStmtContinuee continuee = new()
                {
                    continuee = word
                };
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.Continue,
                    Continue = continuee
                };
                return [stmt];
            }
            else if (Peek(TokenType.Func).HasValue)
            {
                Dictionary<string, List<uint>> saved = new(DimensionsOfArrays);
                DimensionsOfArrays.Clear();
                Consume();
                Token FunctionName = Consume();
                if (STD_FUNCTIONS.Contains(FunctionName.Value) || UserDefinedFunctions.ContainsKey(FunctionName.Value))
                {
                    Token? peeked = Peek(-1);
                    int line = peeked.HasValue ? peeked.Value.Line : 1;
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: function with the name `{FunctionName.Value}` is already defined\n", 1);
                }
                List<Var> parameters = [];
                TryConsumeError(TokenType.OpenParen);
                if (!Peek(TokenType.CloseParen).HasValue)
                {
                    do
                    {
                        if (Peek(TokenType.Variadic).HasValue)
                        {
                            Consume();
                            int NumberofVariadics = 8 - parameters.Count;
                            while (NumberofVariadics-- > 0)
                                DimensionsOfArrays.Add($"variadic({NumberofVariadics})", [0]);
                            parameters.Add(new("", 0, 0, false, true, true));
                            if (Peek(TokenType.Comma).HasValue)
                            {
                                Token? peeked = Peek(-1);
                                int line = peeked.HasValue ? peeked.Value.Line : 1;
                                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: cannod declare afer variadic argument\n", 1);
                            }
                        }
                        else if (IsStmtDeclare())
                        {
                            Token vartype = Consume();
                            Token ident = Consume();
                            Var parameter = new();

                            parameter.Size = 1;
                            if (Peek(TokenType.OpenSquare).HasValue)
                            {
                                if (DimensionsOfArrays.ContainsKey(ident.Value))
                                {
                                    Token? peeked = Peek(-1);
                                    int line = peeked.HasValue ? peeked.Value.Line : 1;
                                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: array `{ident.Value}` is alread delcared\n", 1);
                                }
                                else
                                {
                                    DimensionsOfArrays.Add(ident.Value, []);
                                }
                                while (Peek(TokenType.OpenSquare).HasValue)
                                {
                                    uint DimValue;
                                    if (Peek(TokenType.CloseSquare, 1).HasValue)
                                    {
                                        Consume();
                                        Consume();
                                        DimValue = 0;
                                    }
                                    else
                                    {
                                        Token dim = Parsedimension();
                                        DimValue = uint.Parse(dim.Value);
                                    }
                                    DimensionsOfArrays[ident.Value].Add(DimValue);
                                    parameter.Size *= DimValue;
                                }
                            }
                            uint TypeSize = 0;
                            if (vartype.Type == TokenType.Auto)
                                TypeSize = 8;
                            else if (vartype.Type == TokenType.Char)
                                TypeSize = 1;
                            else
                                Shartilities.UNREACHABLE("");

                            parameter.Value = ident.Value;
                            parameter.TypeSize = TypeSize;
                            parameter.Size *= TypeSize;
                            parameters.Add(parameter);
                        }
                        else
                        {
                            Token? peeked = Peek(-1);
                            int line = peeked.HasValue ? peeked.Value.Line : 1;
                            Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: error in definition of function `{FunctionName.Value}`\n", 1);
                        }
                    } while (PeekAndConsume(TokenType.Comma).HasValue);
                }
                TryConsumeError(TokenType.CloseParen);
                if (!Peek(TokenType.OpenCurly).HasValue)
                {
                    Token? peeked = Peek(-1);
                    int line = peeked.HasValue ? peeked.Value.Line : 1;
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: expected a scope for function `{FunctionName.Value}`\n", 1);
                }

                NodeStmtScope FunctionBody = ParseScope();
                NodeStmtFunction Function = new()
                {
                    FunctionName = FunctionName,
                    parameters = parameters,
                    FunctionBody = FunctionBody,
                    DimensionsOfArrays = new(DimensionsOfArrays),
                };
                UserDefinedFunctions.Add(FunctionName.Value, Function);

                DimensionsOfArrays.Clear();
                DimensionsOfArrays = saved;
                return [];
            }
            else if (Peek(TokenType.Ident).HasValue && Peek(TokenType.OpenParen, 1).HasValue)
            {
                Token? PotentialFunctionName = Peek();
                if (PotentialFunctionName.HasValue && STD_FUNCTIONS.Contains(PotentialFunctionName.Value.Value))
                {
                    Token CalledFunctionName = Consume();
                    NodeStmtFunctionCall CalledFunction = new()
                    {
                        FunctionName = CalledFunctionName,
                        parameters = []
                    };
                    if (CalledFunctionName.Value == "strlen")
                    {
                        TryConsumeError(TokenType.OpenParen);
                        NodeExpr StrlenParameter = ExpectedExpression(ParseExpr());
                        if (!(StrlenParameter.type == NodeExpr.NodeExprType.Term && StrlenParameter.term.type == NodeTerm.NodeTermType.StringLit))
                        {
                            Token? peeked = Peek(-1);
                            int line = peeked.HasValue ? peeked.Value.Line : 1;
                            Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: invalid paramter to function `{CalledFunctionName.Value}` on line: {CalledFunctionName.Line}\n", 1);
                        }

                        TryConsumeError(TokenType.CloseParen);
                        TryConsumeError(TokenType.SemiColon);
                        CalledFunction.parameters = [StrlenParameter];
                        NodeStmt stmt = new()
                        {
                            type = NodeStmt.NodeStmtType.Function,
                            CalledFunction = CalledFunction
                        };
                        return [stmt];
                    }
                    else if (CalledFunctionName.Value == "itoa")
                    {
                        // TODO: change the implementation of `itoa` to operate on the desired buffer no the default one (i.e. `itoaTempBuffer`)
                        Shartilities.TODO("calling itoa");
                        return [];
                    }
                    else if (CalledFunctionName.Value == "write")
                    {
                        TryConsumeError(TokenType.OpenParen);
                        List<NodeExpr> parameters = [];
                        if (!Peek(TokenType.CloseParen).HasValue)
                            do
                            {
                                NodeExpr expr = ExpectedExpression(ParseExpr());
                                parameters.Add(expr);
                            } while (PeekAndConsume(TokenType.Comma).HasValue);
                        TryConsumeError(TokenType.CloseParen);
                        TryConsumeError(TokenType.SemiColon);
                        CalledFunction.parameters = parameters;
                        NodeStmt stmt = new()
                        {
                            type = NodeStmt.NodeStmtType.Function,
                            CalledFunction = CalledFunction
                        };
                        return [stmt];
                    }
                    else
                    {
                        Token? peeked = Peek(-1);
                        int line = peeked.HasValue ? peeked.Value.Line : 1;
                        Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: undefined std function `{CalledFunctionName.Value}`\n", 1);
                        return [];
                    }
                }
                else if (PotentialFunctionName.HasValue)
                {
                    Token CalledFunctionName = Consume();
                    TryConsumeError(TokenType.OpenParen);
                    List<NodeExpr> parameters = [];
                    if (!Peek(TokenType.CloseParen).HasValue)
                        do
                        {
                            NodeExpr expr = ExpectedExpression(ParseExpr());
                            parameters.Add(expr);
                        } while (PeekAndConsume(TokenType.Comma).HasValue);
                    TryConsumeError(TokenType.CloseParen);
                    TryConsumeError(TokenType.SemiColon);
                    NodeStmtFunctionCall CalledFunction = new()
                    {
                        FunctionName = CalledFunctionName,
                        parameters = parameters
                    };
                    NodeStmt stmt = new()
                    {
                        type = NodeStmt.NodeStmtType.Function,
                        CalledFunction = CalledFunction
                    };
                    if (CalledFunctionName.Value == "main")
                    {
                        Token? peeked = Peek(-1);
                        int line = peeked.HasValue ? peeked.Value.Line : 1;
                        Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: cannot call function `main`\n", 1);
                    }
                    return [stmt];
                }
                Shartilities.UNREACHABLE("parsing function call");
                return [];
            }

            else if (Peek(TokenType.Return).HasValue)
            {
                Consume();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                TryConsumeError(TokenType.SemiColon);
                NodeStmtReturn Return = new()
                {
                    expr = expr
                };
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.Return,
                    Return = Return
                };
                return [stmt];
            }
            else if (IsStmtExit())
            {
                Consume();
                Consume();
                NodeStmtExit exit = new();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                exit.expr = expr;
                TryConsumeError(TokenType.CloseParen);
                TryConsumeError(TokenType.SemiColon);
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.Exit,
                    Exit = exit
                };
                return [stmt];
            }
            else
            {
                Token? peeked = Peek();
                if (peeked.HasValue)
                {
                    int line = peeked.HasValue ? peeked.Value.Line : 1;
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: invalid statement `{peeked.Value.Value}`\n", 1);
                }
                else
                {
                    int line = peeked.HasValue ? peeked.Value.Line : 1;
                    Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: there is no statement to parse\n", 1);
                }
                return [];
            }
        }
        public NodeProg ParseProg()
        {
            NodeProg prog = new();
            
            while (Peek().HasValue)
            {
                List<NodeStmt> stmt = ParseStmt();
                prog.scope.stmts.AddRange(stmt);
            }
            return prog;
        }
    }
}
