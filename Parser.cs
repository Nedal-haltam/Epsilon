using System.Reflection.Metadata;
using System.Runtime.CompilerServices;

namespace Epsilon
{
    class Parser(List<Token> tokens)
    {
        private readonly List<Token> m_tokens = tokens;
        private int m_curr_index = 0;
        public Dictionary<string, List<NodeTermIntLit>> DimensionsOfArrays = [];
        public Dictionary<string, NodeStmtFunction> UserDefinedFunctions = [];
        public List<string> STD_FUNCTIONS = 
        [
            "printf",
            "strlen",
            "itoa"
        ];

        Token? Peek(int offset = 0)
        {
            if (0 <= m_curr_index + offset && m_curr_index + offset < m_tokens.Count)
            {
                return m_tokens[m_curr_index + offset];
            }
            return null;
        }
        Token? Peek(TokenType type, int offset = 0)
        {
            Token? token = Peek(offset);
            if (token.HasValue && token.Value.Type == type)
            {
                return token;
            }
            return null;
        }
        Token? PeekAndConsume(TokenType type, int offset = 0)
        {
            if (Peek(type, offset).HasValue)
            {
                return Consume();
            }
            return null;
        }
        Token Consume()
        {
            return m_tokens.ElementAt(m_curr_index++);
        }


        Token TryConsumeError(TokenType type)
        {
            if (!Peek(type).HasValue)
            {
                Token? peeked = Peek(-1);
                string line = peeked.HasValue ? $" on line: {peeked.Value.Line}" : "";
                Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: Error expected `{type}`{line}\n");
                Environment.Exit(1);
            }
            return Consume();
        }
        bool IsStmtDeclare()
        {
            return (Peek(TokenType.Int).HasValue) &&
                   Peek(TokenType.Ident, 1).HasValue;
        }
        bool IsStmtAssign()
        {
            return Peek(TokenType.Ident).HasValue && (Peek(TokenType.OpenSquare, 1).HasValue || Peek(TokenType.Equal, 1).HasValue);
        }
        bool IsStmtIF()
        {
            return Peek(TokenType.If).HasValue;
        }
        bool IsStmtFor()
        {
            return Peek(TokenType.For).HasValue;
        }
        bool IsStmtWhile()
        {
            return Peek(TokenType.While).HasValue;
        }
        bool IsStmtBreak()
        {
            return Peek(TokenType.Break).HasValue;
        }
        bool IsStmtContinue()
        {
            return Peek(TokenType.Continue).HasValue;
        }
        bool IsStmtExit()
        {
            return Peek(TokenType.Exit).HasValue &&
                   Peek(TokenType.OpenParen, 1).HasValue;
        }
        bool IsBinExpr()
        {
            return Peek(TokenType.Plus).HasValue ||
                   Peek(TokenType.mul).HasValue ||
                   Peek(TokenType.Minus).HasValue ||
                   Peek(TokenType.And).HasValue ||
                   Peek(TokenType.Or).HasValue ||
                   Peek(TokenType.Xor).HasValue ||
                   Peek(TokenType.Sll).HasValue ||
                   Peek(TokenType.Srl).HasValue ||
                   Peek(TokenType.EqualEqual).HasValue ||
                   Peek(TokenType.NotEqual).HasValue ||
                   Peek(TokenType.LessThan).HasValue;
        }
        static NodeExpr ExpectedExpression(NodeExpr? expr)
        {
            if (!expr.HasValue)
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: expected expression\n");
                Environment.Exit(1);
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
            NodeTerm term = new()
            {
                Negative = false
            };
            if (Peek(TokenType.Minus).HasValue)
            {
                term.Negative = true;
                Consume();
            }
            if (Peek(TokenType.IntLit).HasValue)
            {
                term.type = NodeTerm.NodeTermType.intlit;
                term.intlit = new()
                {
                    intlit = Consume()
                };
                return term;
            }
            else if (Peek(TokenType.stringlit).HasValue)
            {
                term.type = NodeTerm.NodeTermType.stringlit;
                term.stringlit = new()
                {
                    stringlit = Consume()
                };
                return term;
            }
            else if (Peek(TokenType.Ident).HasValue && Peek(TokenType.OpenParen, 1).HasValue)
            {
                term.type = NodeTerm.NodeTermType.functioncall;
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
                term.type = NodeTerm.NodeTermType.ident;
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
            else if (Peek(TokenType.OpenParen).HasValue)
            {
                Consume();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                TryConsumeError(TokenType.CloseParen);
                if (IsExprIntLit(expr))
                {
                    term.type = NodeTerm.NodeTermType.intlit;
                    term.intlit = expr.term.intlit;
                    return term;
                }
                else
                {
                    NodeTermParen paren = new()
                    {
                        expr = expr
                    };
                    term.type = NodeTerm.NodeTermType.paren;
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
                TokenType.mul => 7,
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
        static NodeBinExpr.NodeBinExprType GetOpType(TokenType op)
        {
            if (op == TokenType.Plus)
                return NodeBinExpr.NodeBinExprType.add;
            if (op == TokenType.mul)
                return NodeBinExpr.NodeBinExprType.mul;
            if (op == TokenType.Minus)
                return NodeBinExpr.NodeBinExprType.sub;
            if (op == TokenType.Sll)
                return NodeBinExpr.NodeBinExprType.sll;
            if (op == TokenType.Srl)
                return NodeBinExpr.NodeBinExprType.srl;
            if (op == TokenType.EqualEqual)
                return NodeBinExpr.NodeBinExprType.equalequal;
            if (op == TokenType.NotEqual)
                return NodeBinExpr.NodeBinExprType.notequal;
            if (op == TokenType.LessThan)
                return NodeBinExpr.NodeBinExprType.lessthan;
            if (op == TokenType.And)
                return NodeBinExpr.NodeBinExprType.and;
            if (op == TokenType.Or)
                return NodeBinExpr.NodeBinExprType.or;
            if (op == TokenType.Xor)
                return NodeBinExpr.NodeBinExprType.xor;
            Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: inavalid operation `{op}`\n");
            Environment.Exit(1);
            return 0;
        }
        static bool IsExprIntLit(NodeExpr expr)
        {
            return expr.type == NodeExpr.NodeExprType.term && expr.term.type == NodeTerm.NodeTermType.intlit;
        }
        NodeExpr? ParseExpr(int min_prec = 0)
        {
            NodeTerm? _Termlhs = ParseTerm();
            if (!_Termlhs.HasValue)
                return null;
            NodeTerm Termlhs = _Termlhs.Value;
            NodeExpr exprlhs = new()
            {
                type = NodeExpr.NodeExprType.term,
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
                        string value = Generator.GetImmedOperation(constant1, constant2, expr.type);
                        NodeTerm term = new()
                        {
                            type = NodeTerm.NodeTermType.intlit
                        };
                        term.intlit.intlit.Value = value;
                        term.intlit.intlit.Type = TokenType.IntLit;
                        term.intlit.intlit.Line = expr.lhs.term.intlit.intlit.Line;
                        exprlhs.type = NodeExpr.NodeExprType.term;
                        exprlhs.term = term;
                    }
                    else
                    {
                        exprlhs.type = NodeExpr.NodeExprType.binExpr;
                        exprlhs.binexpr = expr;
                    }
                }
                return exprlhs;
            }
            else
            {
                exprlhs.type = NodeExpr.NodeExprType.term;
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
                elifs.type = NodeIfElifs.NodeIfElifsType.elif;
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
                elifs.type = NodeIfElifs.NodeIfElifsType.elsee;
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
                Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: expected `(` after `if`\n");
                Environment.Exit(1);
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
            if (IsStmtDeclare())
            {
                Token vartype = Consume();
                NodeStmtDeclareSingleVar declare = new();
                if (vartype.Type != TokenType.Int)
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: Error Expected variable type on line: {vartype.Line}\n");
                    Environment.Exit(1);
                }
                declare.ident = Consume();
                if (Peek(TokenType.Equal).HasValue)
                {
                    Consume();
                    NodeExpr expr = ExpectedExpression(ParseExpr());
                    declare.expr = expr;
                }
                else
                {
                    NodeExpr expr = new()
                    {
                        type = NodeExpr.NodeExprType.term
                    };
                    expr.term.type = NodeTerm.NodeTermType.intlit;
                    expr.term.intlit.intlit.Type = TokenType.IntLit;
                    expr.term.intlit.intlit.Value = "0";
                    declare.expr = expr;
                }
                TryConsumeError(TokenType.SemiColon);
                NodeForInit forinit = new()
                {
                    type = NodeForInit.NodeForInitType.declare
                };
                forinit.declare.type = NodeStmtDeclare.NodeStmtDeclareType.SingleVar;
                forinit.declare.singlevar = declare;
                return forinit;
            }
            else if (IsStmtAssign())
            {
                NodeStmtAssignSingleVar singlevar = new()
                {
                    ident = Consume()
                };
                Consume();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                singlevar.expr = expr;
                TryConsumeError(TokenType.SemiColon);
                NodeForInit forinit = new()
                {
                    type = NodeForInit.NodeForInitType.assign
                };
                forinit.assign.type = NodeStmtAssign.NodeStmtAssignType.SingleVar;
                forinit.assign.singlevar = singlevar;
                return forinit;
            }
            TryConsumeError(TokenType.SemiColon);
            return null;
        }
        NodeForCond? ParseForCond()
        {
            NodeForCond? forcond;
            NodeExpr? cond = ParseExpr();
            if (!cond.HasValue)
            {
                forcond = null;
            }
            else
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
        NodeStmtAssign? ParseStmtUpdate()
        {
            if (!IsStmtAssign())
                return null;
            NodeStmtAssignSingleVar singlevar = new()
            {
                ident = Consume()
            };
            Consume();
            NodeExpr expr = ExpectedExpression(ParseExpr());
            singlevar.expr = expr;
            NodeStmtAssign assign = new()
            {
                type = NodeStmtAssign.NodeStmtAssignType.SingleVar,
                singlevar = singlevar
            };
            return assign;
        }
        NodeForUpdate ParseForUpdate()
        {
            NodeForUpdate forupdate = new()
            {
                udpates = []
            };
            do
            {
                NodeStmtAssign? update = ParseStmtUpdate();
                if (!update.HasValue)
                    break;
                forupdate.udpates.Add(update.Value);
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
        List<NodeStmt> ParseDeclareSingleVar()
        {
            List<NodeStmt> stmts = [];
            do
            {
                if (!Peek(TokenType.Ident).HasValue)
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: expected identifier\n");
                    Environment.Exit(1);
                }
                Token ident = Consume();
                NodeStmtDeclareSingleVar declare = new()
                {
                    ident = ident
                };
                if (Peek(TokenType.Equal).HasValue)
                {
                    Consume();
                    NodeExpr expr = ExpectedExpression(ParseExpr());
                    declare.expr = expr;
                }
                else
                {
                    NodeExpr expr = new()
                    {
                        type = NodeExpr.NodeExprType.term
                    };
                    expr.term.type = NodeTerm.NodeTermType.intlit;
                    expr.term.intlit.intlit.Type = TokenType.Int;
                    expr.term.intlit.intlit.Value = "0";
                    declare.expr = expr;
                }
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.declare
                };
                stmt.declare.type = NodeStmtDeclare.NodeStmtDeclareType.SingleVar;
                stmt.declare.singlevar = declare;
                stmts.Add(stmt);
            } while (PeekAndConsume(TokenType.Comma).HasValue);
            TryConsumeError(TokenType.SemiColon);
            return stmts;
        }
        Token Parsedimension()
        {
            Consume();
            Token size_token = Consume();
            if (!uint.TryParse(size_token.Value, out uint _))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: Error Expected a constant size for the array on line: {size_token.Line}\n");
                Environment.Exit(1);
            }
            TryConsumeError(TokenType.CloseSquare);
            return size_token;
        }
        List<NodeExpr> ParseArrayInit(int dim)
        {
            List<NodeExpr> values = [];
            TryConsumeError(TokenType.OpenCurly);
            for (int i = 0; i < dim; i++)
            {
                NodeExpr expr = ExpectedExpression(ParseExpr());
                values.Add(expr);
                if (Peek(TokenType.CloseCurly).HasValue)
                {
                    Consume();
                    break;
                }
                TryConsumeError(TokenType.Comma);
            }
            return values;
        }
        NodeStmt ParseDeclareArray()
        {
            NodeStmtDeclareArray declare = new()
            {
                ident = Consume(),
                values = []
            };
            if (DimensionsOfArrays.ContainsKey(declare.ident.Value))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: array `{declare.ident.Value}` is alread delcared\n");
                Environment.Exit(1);
            }
            else
            {
                DimensionsOfArrays.Add(declare.ident.Value, []);
            }
            while (Peek(TokenType.OpenSquare).HasValue)
            {
                Token dim = Parsedimension();
                DimensionsOfArrays[declare.ident.Value].Add(new() { intlit = dim });
            }
            TryConsumeError(TokenType.SemiColon);
            NodeStmt stmt = new()
            {
                type = NodeStmt.NodeStmtType.declare
            };
            stmt.declare.type = NodeStmtDeclare.NodeStmtDeclareType.Array;
            stmt.declare.array = declare;
            return stmt;
        }
        NodeStmt ParseAssignSingleVar(Token ident)
        {
            NodeStmtAssignSingleVar singlevar = new()
            {
                ident = ident
            };
            Consume();
            NodeExpr expr = ExpectedExpression(ParseExpr());
            singlevar.expr = expr;
            TryConsumeError(TokenType.SemiColon);
            NodeStmt stmt = new()
            {
                type = NodeStmt.NodeStmtType.assign
            };
            stmt.assign.type = NodeStmtAssign.NodeStmtAssignType.SingleVar;
            stmt.assign.singlevar = singlevar;
            return stmt;
        }
        NodeStmt ParseAssignArray(Token ident)
        {
            NodeStmtAssignArray array = new()
            {
                ident = ident
            };
            while (Peek(TokenType.OpenSquare).HasValue)
            {
                array.indexes.Add(Parseindex());
            }

            TryConsumeError(TokenType.Equal);
            NodeExpr expr = ExpectedExpression(ParseExpr());
            array.expr = expr;
            TryConsumeError(TokenType.SemiColon);
            NodeStmt stmt = new()
            {
                type = NodeStmt.NodeStmtType.assign
            };
            stmt.assign.type = NodeStmtAssign.NodeStmtAssignType.Array;
            stmt.assign.array = array;
            return stmt;
        }
        List<NodeStmt> ParseStmt()
        {
            if (IsStmtDeclare())
            {
                Consume();
                if (Peek(TokenType.OpenSquare, 1).HasValue)
                {
                    return [ParseDeclareArray()];
                }
                else
                {
                    return ParseDeclareSingleVar();
                }
            }
            else if (IsStmtAssign())
            {
                Token ident = Consume();
                if (Peek(TokenType.OpenSquare).HasValue)
                {
                    return [ParseAssignArray(ident)];
                }
                else if (Peek(TokenType.Equal).HasValue)
                {
                    return [ParseAssignSingleVar(ident)];
                }
                else
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: invalid assign statement on line: {ident.Line}\n");
                    Environment.Exit(1);
                    return [];
                }
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
            else if (Peek(TokenType.func).HasValue)/////////////////////////
            {
                Dictionary<string, List<NodeTermIntLit>> saved = new(DimensionsOfArrays);
                DimensionsOfArrays.Clear();
                Consume();
                Token FunctionName = Consume();
                List<Var> parameters = [];
                TryConsumeError(TokenType.OpenParen);
                if (!Peek(TokenType.CloseParen).HasValue)
                {
                    do
                    {
                        if (!(Peek(TokenType.Int).HasValue && Peek(TokenType.Ident, 1).HasValue))
                        {
                            Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: error in definition of function `{FunctionName.Value}`\n");
                            Environment.Exit(1);
                        }
                        Consume();
                        Token ident = Consume();
                        Var parameter = new();
                        parameter.Size = 1;
                        if (Peek(TokenType.OpenSquare).HasValue)
                        {
                            if (DimensionsOfArrays.ContainsKey(ident.Value))
                            {
                                Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: array `{ident.Value}` is alread delcared\n");
                                Environment.Exit(1);
                            }
                            else
                            {
                                DimensionsOfArrays.Add(ident.Value, []);
                            }
                            while (Peek(TokenType.OpenSquare).HasValue)
                            {
                                Token dim = Parsedimension();
                                DimensionsOfArrays[ident.Value].Add(new() { intlit = dim });
                                parameter.Size *= (int)uint.Parse(dim.Value);
                            }
                        }
                        // TODO later: support defaule values for parameters in a functions
                        parameter.Value = ident.Value;

                        parameters.Add(parameter);
                    } while (PeekAndConsume(TokenType.Comma).HasValue);
                }
                TryConsumeError(TokenType.CloseParen);
                if (!Peek(TokenType.OpenCurly).HasValue)
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: expected a scope for function `{FunctionName.Value}`\n");
                    Environment.Exit(1);
                }

                NodeStmtScope FunctionBody = ParseScope();
                NodeStmtFunction Function = new()
                {
                    FunctionName = FunctionName,
                    parameters = parameters,
                    FunctionBody = FunctionBody,
                    DimensionsOfArrays = new(DimensionsOfArrays),
                };
                if (STD_FUNCTIONS.Contains(FunctionName.Value))
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"cannot define function `{FunctionName.Value}`\n");
                    Environment.Exit(1);
                }
                UserDefinedFunctions.Add(FunctionName.Value, Function);

                DimensionsOfArrays.Clear();
                DimensionsOfArrays = saved;
                return [];
            }
            else if (Peek(TokenType.Ident).HasValue && Peek(TokenType.OpenParen, 1).HasValue)/////////////////////////
            {
                Token? PotentialFunctionName = Peek();
                if (PotentialFunctionName.HasValue && UserDefinedFunctions.ContainsKey(PotentialFunctionName.Value.Value))
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
                        Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: cannot call function `main`\n");
                        Environment.Exit(1);
                    }
                    return [stmt];
                }
                else if (PotentialFunctionName.HasValue && STD_FUNCTIONS.Contains(PotentialFunctionName.Value.Value))
                {
                    Token CalledFunctionName = Consume();
                    NodeStmtFunctionCall CalledFunction = new()
                    {
                        FunctionName = CalledFunctionName,
                        parameters = []
                    };
                    if (CalledFunctionName.Value == "printf")
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
                    else if (CalledFunctionName.Value == "strlen")
                    {
                        TryConsumeError(TokenType.OpenParen);
                        NodeExpr StrlenParameter = ExpectedExpression(ParseExpr());
                        if (!(StrlenParameter.type == NodeExpr.NodeExprType.term && StrlenParameter.term.type == NodeTerm.NodeTermType.stringlit))
                        {
                            Shartilities.Log(Shartilities.LogType.ERROR, $"invalid paramter to function `{CalledFunctionName.Value}` on line: {CalledFunctionName.Line}\n");
                            Environment.Exit(1);
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
                    else
                    {
                        Shartilities.Log(Shartilities.LogType.ERROR, $"undefined std function `{CalledFunctionName.Value}`\n");
                        Environment.Exit(1);
                        return [];
                    }
                }
                else
                {
                    if (PotentialFunctionName.HasValue)
                    {
                        Shartilities.Log(Shartilities.LogType.ERROR, $"function `{PotentialFunctionName.Value.Value}` is undefined\n");
                        Environment.Exit(1);
                    }
                    return [];
                }
            }

            else if (Peek(TokenType.returnn).HasValue)
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
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: invalid statement `{peeked.Value.Value}`\n");
                }
                else
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Parser: there is no statement to parse\n");
                }
                Environment.Exit(1);
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
