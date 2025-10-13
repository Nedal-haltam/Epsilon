#pragma warning disable RETURN0001
namespace Epsilon
{
    struct Parser(List<Token> tokens, string InputFilePath)
    {
        NodeProg prog;
        List<Token> m_tokens = [.. tokens];
        string m_inputFilePath = InputFilePath;
        int m_curr_index;
        string? CurrentFunctionName;
        Token? Peek(int offset = 0) => 0 <= m_curr_index + offset && m_curr_index + offset < m_tokens.Count ? m_tokens[m_curr_index + offset] : null;
        Token? Peek(TokenType type, int offset = 0)
        {
            Token? token = Peek(offset);
            if (token.HasValue && token.Value.Type == type)
            {
                return token;
            }
            return null;
        }
        void Expect(TokenType type, int offset = 0)
        {
            if (!Peek(type, offset).HasValue)
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: expected {type}\n", 1);
            }
        }
        Token ExpectAndConsume(TokenType type, int offset = 0)
        {
            Token? t = PeekAndConsume(type, offset);
            if (!t.HasValue)
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: expected {type}\n", 1);
                Shartilities.UNREACHABLE("ExpectAndConsume");
                return new();
            }
            return t.Value;
        }
        Token? PeekAndConsume(TokenType type, int offset = 0) => Peek(type, offset).HasValue ? Consume() : null;
        Token Consume() => m_tokens.ElementAt(m_curr_index++);
        Token GetToken(int offset = 0) => m_tokens[m_curr_index + offset];
        void ConsumeMany(int n) => m_curr_index += n;
        bool IsStmtDeclare()  => (
            Peek(TokenType.Auto).HasValue || 
            Peek(TokenType.Char).HasValue
            ) && 
            Peek(TokenType.Ident, 1).HasValue;
        bool IsStmtAssign()   => Peek(TokenType.Ident).HasValue && (Peek(TokenType.OpenSquare, 1).HasValue || Peek(TokenType.Equal, 1).HasValue);
        bool IsBinExpr()      => Peek(TokenType.Plus).HasValue       ||
                                 Peek(TokenType.Mul).HasValue        ||
                                 Peek(TokenType.Rem).HasValue        ||
                                 Peek(TokenType.Div).HasValue        ||
                                 Peek(TokenType.Minus).HasValue      ||
                                 Peek(TokenType.And).HasValue        ||
                                 Peek(TokenType.Or).HasValue         ||
                                 Peek(TokenType.Xor).HasValue        ||
                                 Peek(TokenType.Sll).HasValue        ||
                                 Peek(TokenType.Sra).HasValue        ||
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
            ExpectAndConsume(TokenType.CloseSquare);
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
            else if (Peek(TokenType.VariadicArgs).HasValue)
            {
                Consume();
                ExpectAndConsume(TokenType.OpenParen);
                NodeExpr VariadicIndex = ExpectedExpression(ParseExpr());
                VariadicIndex = NodeExpr.BinExpr(NodeBinExpr.NodeBinExprType.Add, VariadicIndex, NodeExpr.Number("1", -1));
                ExpectAndConsume(TokenType.CloseParen);
                term.type = NodeTerm.NodeTermType.Variadic;
                term.variadic = new() { VariadicIndex = VariadicIndex };
                return term;
            }
            else if (Peek(TokenType.VariadicCount).HasValue)
            {
                Token t = Consume();
                NodeExpr VariadicIndex = NodeExpr.Number("0", t.Line);
                term.type = NodeTerm.NodeTermType.Variadic;
                term.variadic = new() { VariadicIndex = VariadicIndex };
                return term;
            }
            else if (Peek(TokenType.OpenParen).HasValue)
            {
                Consume();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                ExpectAndConsume(TokenType.CloseParen);
                NodeTermParen paren = new()
                {
                    expr = expr
                };
                term.type = NodeTerm.NodeTermType.Paren;
                term.paren = paren;
                return term;
            }
            return null;
        }
        static int? GetPrec(TokenType type)
        {
            return type switch
            {
                TokenType.Mul or TokenType.Div or TokenType.Rem => 7,
                TokenType.Plus or TokenType.Minus => 6,
                TokenType.Sll or TokenType.Sra => 5,
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
            if (op == TokenType.Sra)
                return NodeBinExpr.NodeBinExprType.Sra;
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

                    exprlhs.type = NodeExpr.NodeExprType.BinExpr;
                    exprlhs.binexpr = expr;
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
            NodeStmtScope scope = new();
            if (PeekAndConsume(TokenType.SemiColon).HasValue)
                return scope;

            if (PeekAndConsume(TokenType.OpenCurly).HasValue)
                while (!PeekAndConsume(TokenType.CloseCurly).HasValue)
                    scope.stmts.AddRange(ParseStmt());
            else
                scope.stmts.AddRange(ParseStmt());

            return scope;
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
            ExpectAndConsume(TokenType.CloseParen);
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
            ExpectAndConsume(TokenType.SemiColon);
            return forcond;
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
            ExpectAndConsume(TokenType.CloseParen);
            return forupdate;
        }
        NodeForPredicate ParseForPredicate()
        {
            NodeForPredicate pred = new();
            if (PeekAndConsume(TokenType.OpenParen).HasValue)
            {
                pred.init   = ParseForInit();
                pred.cond   = ParseForCond();
                pred.udpate = ParseForUpdate();
                pred.scope  = ParseScope();
            }
            else
            {
                Token ident = ExpectAndConsume(TokenType.Ident);
                ExpectAndConsume(TokenType.In);
                NodeExpr start = ExpectedExpression(ParseExpr());
                ExpectAndConsume(TokenType.Range);
                NodeExpr end = ExpectedExpression(ParseExpr());
                NodeStmtScope scope = ParseScope();

                pred.init = new(
                    NodeForInit.NodeForInitType.Declare, 
                    new NodeStmtDeclare(NodeStmtIdentifierType.SingleVar, NodeStmtDataType.Auto, ident, new NodeStmtDeclareSingleVar(start)));

                pred.cond = new(NodeExpr.BinExpr(NodeBinExpr.NodeBinExprType.LessThan, NodeExpr.Identifier(new(ident, [])), end));
                pred.udpate = new([
                    new(NodeStmtIdentifierType.SingleVar, 
                    new NodeStmtAssignSingleVar(
                        ident, 
                        NodeExpr.BinExpr(NodeBinExpr.NodeBinExprType.Add, NodeExpr.Identifier(new(ident, [])), NodeExpr.Number("1", ident.Line))
                        ))]);
                pred.scope = scope;
            }
            return pred;
        }
        NodeExpr ParseWhileCond()
        {
            ExpectAndConsume(TokenType.OpenParen);
            NodeExpr cond = ExpectedExpression(ParseExpr());
            ExpectAndConsume(TokenType.CloseParen);
            return cond;
        }
        Token Parsedimension()
        {
            Consume();
            NodeExpr dim = ExpectedExpression(ParseExpr());
            dim = Optimizer.FoldExpr(dim);
            
            if (!Optimizer.IsExprIntLit(dim))
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: Parser: Error Expected a constant size for the array\n", 1);
            }
            ExpectAndConsume(TokenType.CloseSquare);
            return dim.term.intlit.intlit;
        }
        List<NodeStmt> ParseDeclare()
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
        NodeStmt ParseAssign()
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
        List<Var> ParseFunctionParameters()
        {
            ExpectAndConsume(TokenType.OpenParen);
            List<Var> parameters = [];
            do
            {
                if (Peek(TokenType.Variadic).HasValue)
                {
                    Consume();
                    //int NumberofVariadics = 8 - parameters.Count;
                    parameters.Add(new($"...", 0, 0, [0], false, true, true));
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
        void ParseFunctionPrologue(Token FunctionName)
        {
            CurrentFunctionName = FunctionName.Value;
            if (ConstDefs.STD_FUNCTIONS_MAP.ContainsKey(FunctionName.Value) || prog.UserDefinedFunctions.ContainsKey(FunctionName.Value))
            {
                Token? peeked = Peek(-1);
                int line = peeked.HasValue ? peeked.Value.Line : 1;
                Shartilities.Log(Shartilities.LogType.ERROR, $"{m_inputFilePath}:{line}:{1}: function with the name `{FunctionName.Value}` is already defined\n", 1);
            }
        }
        void ParseFunctionEpilogue()
        {
            CurrentFunctionName = null;
        }
        NodeStmtScope ParseFunctionBody()
        {
            Expect(TokenType.OpenCurly);
            return ParseScope();
        }
        void ParseFunction()
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
            prog.UserDefinedFunctions.Add(FunctionName.Value, Function);
        }
        List<NodeExpr> ParseFunctionCallParameters()
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
        List<NodeStmt> ParseFunctionCall(Token CalledFunctionName)
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
        List<NodeStmt> ParseStmt()
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
            else if (PeekAndConsume(TokenType.Asm).HasValue)
            {
                ExpectAndConsume(TokenType.OpenParen);
                Token assembly = Consume();
                ExpectAndConsume(TokenType.CloseParen);
                ExpectAndConsume(TokenType.SemiColon);
                NodeStmt stmt = new()
                {
                    type = NodeStmt.NodeStmtType.Asm,
                    Asm = new NodeStmtAsm(assembly),
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
        public NodeProg ParseProg()
        {
            m_curr_index = 0;
            CurrentFunctionName = null;
            prog = new();

            while (Peek().HasValue)
            {
                List<NodeStmt> stmts = ParseStmt();
            }
            return prog;
        }
    }
}
