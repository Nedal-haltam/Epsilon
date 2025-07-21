using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Reflection.Metadata;
using System.Runtime.CompilerServices;
using System.Security.Cryptography;
namespace Epsilon
{
    public static class Parser
    {
        static NodeProg prog = new();
#pragma warning disable CS8618 // Non-nullable field must contain a non-null value when exiting constructor. Consider adding the 'required' modifier or declaring as nullable.
        static List<Token> m_tokens;
        static string m_inputFilePath;
#pragma warning restore CS8618 // Non-nullable field must contain a non-null value when exiting constructor. Consider adding the 'required' modifier or declaring as nullable.
        static int m_curr_index = 0;
        static string? CurrentFunctionName = null;
        static public Dictionary<string, NodeStmtFunction> UserDefinedFunctions = [];
        static public List<string> STD_FUNCTIONS = ["strlen", "stoa", "unstoa", "write"];

        public static string GetImmedOperation(string imm1, string imm2, NodeBinExpr.NodeBinExprType op)
        {
            Int64 a = Convert.ToInt64(imm1);
            Int64 b = Convert.ToInt64(imm2);

            if (op == NodeBinExpr.NodeBinExprType.Add)
                return (a + b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Sub)
                return (a - b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Sll)
                return (a << (Int32)b).ToString();
            else if (op == NodeBinExpr.NodeBinExprType.Srl)
                return (a >>> (Int32)b).ToString();
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
        static Token? Peek(int offset = 0) => 0 <= m_curr_index + offset && m_curr_index + offset < m_tokens.Count ? m_tokens[m_curr_index + offset] : null;
        static Token? Peek(TokenType type, int offset = 0)
        {
            Token? token = Peek(offset);
            if (token.HasValue && token.Value.Type == type)
            {
                return token;
            }
            return null;
        }
        static void Expect(TokenType type, int offset = 0)
        {
            if (!Peek(type, offset).HasValue)
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: expected {type}\n", 1);
            }
        }
        static void ExpectAndConsume(TokenType type, int offset = 0)
        {
            if (!PeekAndConsume(type, offset).HasValue)
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: expected {type}\n", 1);
            }
        }
        static Token? PeekAndConsume(TokenType type, int offset = 0) => Peek(type, offset).HasValue ? Consume() : null;
        static Token Consume() => m_tokens.ElementAt(m_curr_index++);
        static Token GetToken(int offset = 0) => m_tokens[m_curr_index + offset];
        static void ConsumeMany(int n) => m_curr_index += n;
        static bool IsStmtDeclare()  => (
            Peek(TokenType.Auto).HasValue || 
            Peek(TokenType.Char).HasValue
            ) && 
            Peek(TokenType.Ident, 1).HasValue;
        static bool IsStmtAssign()   => Peek(TokenType.Ident).HasValue && (Peek(TokenType.OpenSquare, 1).HasValue || Peek(TokenType.Equal, 1).HasValue);
        static bool IsBinExpr()      => Peek(TokenType.Plus).HasValue       ||
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
        static NodeExpr ExpectedExpression(NodeExpr? expr)
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
        static NodeExpr Parseindex()
        {
            Consume();
            NodeExpr index = ExpectedExpression(ParseExpr());
            ExpectAndConsume(TokenType.CloseSquare);
            return index;
        }
        static NodeTerm? ParseTerm()
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
            else if (Peek(TokenType.And).HasValue)
            {
                Consume();
                NodeTerm? termunary = ParseTerm();
                if (!termunary.HasValue)
                    return null;
                if (termunary.Value.type != NodeTerm.NodeTermType.Ident)
                    Shartilities.Log(Shartilities.LogType.ERROR, $"address of operator is only on identifiers with no offsets\n", 1);
                term.type = NodeTerm.NodeTermType.Unary;
                term.unary = new()
                {
                    type = NodeTermUnaryExpr.NodeTermUnaryExprType.addressof,
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
                List<NodeExpr> parameters = ParseFunctionCallParameters();
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
                return term;
            }
            else if (Peek(TokenType.Variadic).HasValue)
            {
                Consume();
                ExpectAndConsume(TokenType.OpenParen);
                NodeExpr VariadicIndex = ExpectedExpression(ParseExpr());
                ExpectAndConsume(TokenType.CloseParen);
                term.type = NodeTerm.NodeTermType.Variadic;
                term.variadic = new() { VariadicIndex = VariadicIndex };
                return term;
            }
            else if (Peek(TokenType.OpenParen).HasValue)
            {
                Consume();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                ExpectAndConsume(TokenType.CloseParen);
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
            int? prec = type switch
            {
                TokenType.Mul or TokenType.Rem or TokenType.Div => 3,
                TokenType.Plus or TokenType.Minus => 4,
                TokenType.Sll or TokenType.Srl => 5,
                TokenType.LessThan => 6,
                TokenType.EqualEqual or TokenType.NotEqual => 7,
                TokenType.And => 8,
                TokenType.Xor => 9,
                TokenType.Or => 10,
               _ => null,
            };
            if (!prec.HasValue) return null;
            return 10 - prec.Value;
        }
        static NodeBinExpr.NodeBinExprType GetOpType(TokenType op)
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
        static NodeExpr? ParseExpr(int min_prec = 0)
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
        static NodeStmtScope ParseScope()
        {
            NodeStmtScope scope = new();
            if (PeekAndConsume(TokenType.OpenCurly).HasValue)
                while (!PeekAndConsume(TokenType.CloseCurly).HasValue)
                    scope.stmts.AddRange(ParseStmt());
            else
                scope.stmts.AddRange(ParseStmt());
            return scope;
        }
        static NodeIfElifs? ParseElifs()
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
        static NodeIfPredicate ParseIfPredicate()
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
            ExpectAndConsume(TokenType.CloseParen);
            NodeStmtScope scope = ParseScope();
            pred.scope = scope;
            return pred;
        }
        static NodeForInit? ParseForInit()
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
                ExpectAndConsume(TokenType.SemiColon);
                if (stmt.type != NodeStmt.NodeStmtType.Assign)
                    Shartilities.UNREACHABLE("");
                forinit.type = NodeForInit.NodeForInitType.Assign;
                forinit.assign = stmt.assign;
                return forinit;
            }
            ExpectAndConsume(TokenType.SemiColon);
            return null;
        }
        static NodeForCond? ParseForCond()
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
            ExpectAndConsume(TokenType.SemiColon);
            return forcond;
        }
        static NodeStmtAssign? ParseForUpdateStmt()
        {
            if (!IsStmtAssign())
                return null;
            NodeStmt stmt = ParseAssign();
            if (stmt.type != NodeStmt.NodeStmtType.Assign)
                return null;
            return stmt.assign;
        }
        static NodeForUpdate ParseForUpdate()
        {
            NodeForUpdate forupdate = new();
            do
            {
                NodeStmtAssign? update = ParseForUpdateStmt();
                if (!update.HasValue)
                    break;
                forupdate.updates.Add(update.Value);
            } while (PeekAndConsume(TokenType.Comma).HasValue);
            ExpectAndConsume(TokenType.CloseParen);
            return forupdate;
        }
        static NodeForPredicate ParseForPredicate()
        {
            NodeForPredicate pred = new();
            ExpectAndConsume(TokenType.OpenParen);
            pred.init = ParseForInit();
            pred.cond = ParseForCond();
            pred.udpate = ParseForUpdate();
            NodeStmtScope scope = ParseScope();
            pred.scope = scope;
            return pred;
        }
        static NodeExpr ParseWhileCond()
        {
            ExpectAndConsume(TokenType.OpenParen);
            NodeExpr cond = ExpectedExpression(ParseExpr());
            ExpectAndConsume(TokenType.CloseParen);
            return cond;
        }
        static Token Parsedimension()
        {
            Consume();
            Token size_token = Consume();
            if (!uint.TryParse(size_token.Value, out uint _))
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: Error Expected a constant size for the array\n", 1);
            }
            ExpectAndConsume(TokenType.CloseSquare);
            return size_token;
        }
        static List<NodeStmt> ParseDeclare()
        {
            Token vartype = Consume();
            List<NodeStmt> stmts = [];
            do
            {
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.Declare,
                    declare = new(),
                };
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
                    stmt.declare.array = new();
                    while (Peek(TokenType.OpenSquare).HasValue)
                    {
                        Token dim = Parsedimension();
                        stmt.declare.array.Dimensions.Add(uint.Parse(dim.Value));
                    }
                }
                else
                {
                    NodeExpr DeclareExpr = new();
                    if (PeekAndConsume(TokenType.Equal).HasValue)
                        DeclareExpr = ExpectedExpression(ParseExpr());
                    stmt.declare.singlevar = new()
                    {
                        expr = DeclareExpr,
                    };
                }
                stmt.declare.ident = Ident;
                stmt.declare.type = IdentifierType;
                stmt.declare.datatype = DataType;
                stmts.Add(stmt);
            } while (PeekAndConsume(TokenType.Comma).HasValue);
            ExpectAndConsume(TokenType.SemiColon);
            if (CurrentFunctionName == null) // it is in Global scope
            {
                prog.GlobalScope.stmts.AddRange(stmts);
                return [];
            }
            return stmts;
        }
        static NodeStmt ParseAssign()
        {
            Token Ident = Consume();
            NodeStmt stmt = new()
            {
                type = NodeStmt.NodeStmtType.Assign,
            };
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
                ExpectAndConsume(TokenType.Equal);
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
        static List<Var> ParseFunctionParameters()
        {
            ExpectAndConsume(TokenType.OpenParen);
            List<Var> parameters = [];
            do
            {
                if (Peek(TokenType.Variadic).HasValue)
                {
                    Consume();
                    //int NumberofVariadics = 8 - parameters.Count;
                    parameters.Add(new($"NO_NEED_TO_FILL", 0, 0, [0], false, true, true));
                    if (Peek(TokenType.Comma).HasValue)
                    {
                        Token? peeked = Peek(-1);
                        int line = peeked.HasValue ? peeked.Value.Line : 1;
                        Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: cannot declare afer variadic argument\n", 1);
                    }
                }
                else if (IsStmtDeclare())
                {
                    Token vartype = Consume();
                    Token ident = Consume();
                    uint TotalSize = 1;
                    List<uint> dims = [];
                    bool IsArray = false;
                    if (parameters.FindIndex(x => x.Value == ident.Value) != -1 || prog.GlobalScope.stmts.FindIndex(x => x.declare.ident.Value == ident.Value) != -1)
                        Shartilities.Logln(Shartilities.LogType.ERROR, $"variable `{ident.Value}` is already declared", 1);
                    if (Peek(TokenType.OpenSquare).HasValue)
                    {
                        IsArray = true;
                        while (Peek(TokenType.OpenSquare).HasValue)
                        {
                            uint DimValue = 0;
                            if (Peek(TokenType.CloseSquare, 1).HasValue)
                                ConsumeMany(2);
                            else
                            {
                                DimValue = uint.Parse(Parsedimension().Value);
                                TotalSize *= DimValue;
                            }
                            dims.Add(DimValue);
                        }
                    }
                    uint ElementSize = 0;
                    if (vartype.Type == TokenType.Auto)
                        ElementSize = 8;
                    else if (vartype.Type == TokenType.Char)
                        ElementSize = 1;
                    else
                        Shartilities.Logln(Shartilities.LogType.ERROR, $"invalid variable type `{vartype.Type}`", 1);

                    TotalSize *= ElementSize;
                    parameters.Add(new(ident.Value, TotalSize, ElementSize, dims, IsArray, true, false));
                }
                else break;
            } while (PeekAndConsume(TokenType.Comma).HasValue);
            ExpectAndConsume(TokenType.CloseParen);
            return parameters;
        }
        static void ParseFunctionPrologue(Token FunctionName)
        {
            CurrentFunctionName = FunctionName.Value;
            if (STD_FUNCTIONS.Contains(FunctionName.Value) || UserDefinedFunctions.ContainsKey(FunctionName.Value))
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: function with the name `{FunctionName.Value}` is already defined\n", 1);
            }
        }
        static void ParseFunctionEpilogue()
        {
            CurrentFunctionName = null;
        }
        static NodeStmtScope ParseFunctionBody()
        {
            Expect(TokenType.OpenCurly);
            return ParseScope();
        }
        static void ParseFunction()
        {
            Token FunctionName = Consume();
            ParseFunctionPrologue(FunctionName);
            List<Var> parameters = ParseFunctionParameters();
            NodeStmtScope FunctionBody = ParseFunctionBody();
            ParseFunctionEpilogue();

            NodeStmtFunction Function = new()
            {
                FunctionName = FunctionName,
                parameters = parameters,
                FunctionBody = FunctionBody,
            };
            UserDefinedFunctions.Add(FunctionName.Value, Function);
        }
        static List<NodeExpr> ParseFunctionCallParameters()
        {
            List<NodeExpr> parameters = [];
            ExpectAndConsume(TokenType.OpenParen);
            if (!Peek(TokenType.CloseParen).HasValue)
                do
                {
                    NodeExpr expr = ExpectedExpression(ParseExpr());
                    parameters.Add(expr);
                } while (PeekAndConsume(TokenType.Comma).HasValue);
            ExpectAndConsume(TokenType.CloseParen);
            return parameters;
        }
        static List<NodeStmt> ParseFunctionCall(Token CalledFunctionName)
        {
            if (STD_FUNCTIONS.Contains(CalledFunctionName.Value))
            {
                NodeStmtFunctionCall CalledFunction = new()
                {
                    FunctionName = CalledFunctionName,
                    parameters = []
                };
                if (CalledFunctionName.Value == "strlen")
                {
                    Shartilities.TODO("calling strlen when it is not a term");
                    return [];
                }
                else if (CalledFunctionName.Value == "stoa")
                {
                    // TODO: change the implementation of `stoa` to operate on the desired buffer no the default one (i.e. `stoaTempBuffer`)
                    Shartilities.TODO("calling stoa");
                    return [];
                }
                else if (CalledFunctionName.Value == "unstoa")
                {
                    // TODO: change the implementation of `unstoa` to operate on the desired buffer no the default one (i.e. `unstoaTempBuffer`)
                    Shartilities.TODO("calling unstoa");
                    return [];
                }
                else if (CalledFunctionName.Value == "write")
                {
                    List<NodeExpr> parameters = ParseFunctionCallParameters();
                    ExpectAndConsume(TokenType.SemiColon);
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
            else
            {
                List<NodeExpr> parameters = ParseFunctionCallParameters();
                ExpectAndConsume(TokenType.SemiColon);
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
                return [stmt];
            }
        }
        static List<NodeStmt> ParseStmt()
        {
            if (IsStmtDeclare())
            {
                return ParseDeclare();
            }
            else if (IsStmtAssign())
            {
                NodeStmt stmt = ParseAssign();
                ExpectAndConsume(TokenType.SemiColon);
                return [stmt];
            }
            else if (PeekAndConsume(TokenType.If).HasValue)
            {
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
            else if (PeekAndConsume(TokenType.For).HasValue)
            {
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
            else if (PeekAndConsume(TokenType.While).HasValue)
            {
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
            else if (PeekAndConsume(TokenType.Break).HasValue)
            {
                ExpectAndConsume(TokenType.SemiColon);
                NodeStmtBreak breakk = new()
                {
                    breakk = GetToken(-1),
                };
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.Break,
                    Break = breakk
                };
                return [stmt];
            }
            else if (PeekAndConsume(TokenType.Continue).HasValue)
            {
                ExpectAndConsume(TokenType.SemiColon);
                NodeStmtContinuee continuee = new()
                {
                    continuee = GetToken(-1),
                };
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.Continue,
                    Continue = continuee
                };
                return [stmt];
            }
            else if (PeekAndConsume(TokenType.Func).HasValue)
            {
                ParseFunction();
                return [];
            }
            else if (Peek(TokenType.Ident).HasValue && Peek(TokenType.OpenParen, 1).HasValue)
            {
                Token FunctionName = Consume();
                return ParseFunctionCall(FunctionName);
            }

            else if (PeekAndConsume(TokenType.Return).HasValue)
            {
                NodeExpr expr = ExpectedExpression(ParseExpr());
                ExpectAndConsume(TokenType.SemiColon);
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
            else if (PeekAndConsume(TokenType.Exit).HasValue && PeekAndConsume(TokenType.OpenParen).HasValue)
            {
                NodeStmtExit exit = new();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                exit.expr = expr;
                ExpectAndConsume(TokenType.CloseParen);
                ExpectAndConsume(TokenType.SemiColon);
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
        public static NodeProg ParseProg(List<Token> tokens, string InputFilePath)
        {
            m_tokens = tokens;
            m_inputFilePath = InputFilePath;
            prog = new();
            while (Peek().HasValue)
            {
                List<NodeStmt> stmts = ParseStmt();
                prog.scope.stmts.AddRange(stmts);
            }
            return prog;
        }
    }
}
