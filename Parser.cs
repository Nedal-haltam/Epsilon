#pragma warning disable CS8629 // Nullable value type may be null.




using System.Linq.Expressions;
using System.Reflection.Metadata.Ecma335;

namespace Epsilon
{
    class Parser
    {
        private List<Token> m_tokens;
        private int m_curr_index = 0;
        public Dictionary<string, List<NodeTermIntLit>> m_Arraydims = [];
        public Parser(List<Token> tokens)
        {
            m_tokens = tokens;
        }

        Token? peek(int offset = 0)
        {
            if (m_curr_index + offset < m_tokens.Count)
            {
                return m_tokens[m_curr_index + offset];
            }
            return null;
        }
        Token? peek(TokenType type, int offset = 0)
        {
            Token? token = peek(offset);
            if (token.HasValue && token.Value.Type == type)
            {
                return token;
            }
            return null;
        }
        Token? peekandconsume(TokenType type, int offset = 0)
        {
            if (peek(type, offset).HasValue)
            {
                return consume();
            }
            return null;
        }
        Token consume()
        {
            return m_tokens.ElementAt(m_curr_index++);
        }


        Token? try_consume_err(TokenType type)
        {
            if (peek(type).HasValue)
            {
                return consume();
            }
            ErrorExpected($"Expected: {type}");
            return null;
        }
        void ErrorExpected(string msg)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Parser: Error Expected {msg} on line: {peek().Value.Line}");
            Console.ResetColor();
            Environment.Exit(1);
        }

        bool IsStmtDeclare()
        {
            return (peek(TokenType.Int).HasValue) &&
                   peek(TokenType.Ident, 1).HasValue;
        }
        bool IsStmtAssign()
        {
            return peek(TokenType.Ident).HasValue;
        }
        bool IsStmtIF()
        {
            return peek(TokenType.If).HasValue;
        }
        bool IsStmtFor()
        {
            return peek(TokenType.For).HasValue;
        }
        bool IsStmtWhile()
        {
            return peek(TokenType.While).HasValue;
        }
        bool IsStmtBreak()
        {
            return peek(TokenType.Break).HasValue;
        }
        bool IsStmtContinue()
        {
            return peek(TokenType.Continue).HasValue;
        }
        bool IsStmtExit()
        {
            return peek(TokenType.Exit).HasValue &&
                   peek(TokenType.OpenParen, 1).HasValue;
        }
        bool IsBinExpr()
        {
            return peek(TokenType.Plus).HasValue ||
                   peek(TokenType.Minus).HasValue ||
                   peek(TokenType.And).HasValue ||
                   peek(TokenType.Or).HasValue ||
                   peek(TokenType.Xor).HasValue ||
                   peek(TokenType.Sll).HasValue ||
                   peek(TokenType.Srl).HasValue ||
                   peek(TokenType.EqualEqual).HasValue ||
                   peek(TokenType.NotEqual).HasValue ||
                   peek(TokenType.LessThan).HasValue ||
                   peek(TokenType.GreaterThan).HasValue;
        }
        NodeExpr ExpectedExpression(NodeExpr? expr)
        {
            if (!expr.HasValue)
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"expected expression\n");
                Environment.Exit(1);
                return new();
            }
            return expr.Value;
        }
        NodeExpr parseindex()
        {
            consume();
            NodeExpr index = ExpectedExpression(ParseExpr());
            try_consume_err(TokenType.CloseSquare);
            return index;
        }
        NodeTerm? ParseTerm()
        {
            NodeTerm term = new NodeTerm();
            term.Negative = false;
            if (peek(TokenType.Minus).HasValue)
            {
                term.Negative = true;
                consume();
            }
            if (peek(TokenType.IntLit).HasValue)
            {
                term.type = NodeTerm.NodeTermType.intlit;
                term.intlit.intlit = consume();
                return term;
            }
            else if (peek(TokenType.Ident).HasValue)
            {
                term.type = NodeTerm.NodeTermType.ident;
                term.ident = new();
                term.ident.ident = consume();
                term.ident.indexes = [];
                while (peek(TokenType.OpenSquare).HasValue)
                {
                    term.ident.indexes.Add(parseindex());
                }
                return term;
            }
            else if (peek(TokenType.OpenParen).HasValue)
            {
                consume();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                try_consume_err(TokenType.CloseParen);
                NodeTermParen paren = new NodeTermParen();
                paren.expr = expr;
                term.type = NodeTerm.NodeTermType.paren;
                term.paren = paren;
                return term;
            }
            return null;
        }

        int? GetPrec(TokenType type)
        {
            switch (type)
            {
                case TokenType.EqualEqual:
                case TokenType.NotEqual:
                case TokenType.LessThan:
                case TokenType.GreaterThan:
                case TokenType.Xor:
                case TokenType.Or:
                case TokenType.And:
                    return 0;
                case TokenType.Sll:
                case TokenType.Srl:
                    return 1;
                case TokenType.Plus:
                case TokenType.Minus:
                    return 2;
                default:
                    return null;
            }
        }
        NodeBinExpr.NodeBinExprType GetOpType(TokenType op)
        {
            if (op == TokenType.Plus)
                return NodeBinExpr.NodeBinExprType.add;
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
            if (op == TokenType.GreaterThan)
                return NodeBinExpr.NodeBinExprType.greaterthan;
            if (op == TokenType.And)
                return NodeBinExpr.NodeBinExprType.and;
            if (op == TokenType.Or)
                return NodeBinExpr.NodeBinExprType.or;
            if (op == TokenType.Xor)
                return NodeBinExpr.NodeBinExprType.xor;
            Shartilities.Log(Shartilities.LogType.ERROR, $"inavalid operation `{op.ToString()}`");
            Environment.Exit(1);
            return 0;
        }
        bool IsExprIntLit(NodeExpr expr)
        {
            return expr.type == NodeExpr.NodeExprType.term && expr.term.type == NodeTerm.NodeTermType.intlit;
        }
        NodeExpr? ParseExpr(int min_prec = 0)
        {
            NodeTerm? _Termlhs = ParseTerm();
            if (!_Termlhs.HasValue)
                return null;
            NodeTerm Termlhs = _Termlhs.Value;
            NodeExpr exprlhs = new NodeExpr();
            exprlhs.type = NodeExpr.NodeExprType.term;
            exprlhs.term = Termlhs;

            if (IsBinExpr())
            {
                while (true)
                {
                    Token? curr_tok = peek();
                    int? prec;
                    if (curr_tok.HasValue)
                    {
                        prec = GetPrec(curr_tok.Value.Type);
                        if (!prec.HasValue || prec < min_prec) break;
                    }
                    else break;
                    Token Operator = consume();
                    int next_min_prec = prec.Value + 1;
                    NodeExpr expr_rhs = ExpectedExpression(ParseExpr(next_min_prec));
                    NodeBinExpr expr = new NodeBinExpr();
                    NodeExpr expr_lhs2 = new NodeExpr();
                    expr_lhs2 = exprlhs;
                    NodeBinExpr.NodeBinExprType optype = GetOpType(Operator.Type);
                    expr.type = optype;
                    expr.lhs = expr_lhs2;
                    expr.rhs = expr_rhs;

                    if (IsExprIntLit(expr.lhs) && IsExprIntLit(expr.rhs))
                    {
                        string constant1 = expr.lhs.term.intlit.intlit.Value;
                        string constant2 = expr.rhs.term.intlit.intlit.Value;
                        string value = Generator.GetImmedOperation(constant1, constant2, expr.type);
                        NodeTerm term = new();
                        term.type = NodeTerm.NodeTermType.intlit;
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

        NodeScope ParseScope()
        {
            NodeScope scope = new NodeScope();
            scope.stmts = [];
            if (peek(TokenType.OpenCurly).HasValue)
            {
                consume();
                while (!peek(TokenType.CloseCurly).HasValue)
                {
                    List<NodeStmt> stmt = ParseStmt();
                    scope.stmts.AddRange(stmt);
                }
                try_consume_err(TokenType.CloseCurly);
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
            NodeIfElifs elifs = new NodeIfElifs();
            if (peek(TokenType.Elif).HasValue)
            {
                consume();
                NodeIfPredicate pred = ParseIfPredicate();
                elifs.type = NodeIfElifs.NodeIfElifsType.elif;
                elifs.elif = new NodeElif();
                elifs.elif.pred = pred;
                elifs.elif.elifs = ParseElifs();
                return elifs;
            }
            else if (peek(TokenType.Else).HasValue)
            {
                consume();
                NodeScope scope = ParseScope();
                elifs.type = NodeIfElifs.NodeIfElifsType.elsee;
                elifs.elsee = new NodeElse();
                elifs.elsee.scope = scope;
                return elifs;
            }
            return null;
        }

        NodeIfPredicate ParseIfPredicate()
        {
            if (!peek(TokenType.OpenParen).HasValue)
                Shartilities.Log(Shartilities.LogType.ERROR, $"expected `(` after `if`\n");
            consume();
            NodeIfPredicate pred = new NodeIfPredicate();
            NodeExpr cond = ExpectedExpression(ParseExpr());
            pred.cond = cond;
            try_consume_err(TokenType.CloseParen);
            NodeScope scope = ParseScope();
            pred.scope = scope;
            return pred;
        }
        NodeForInit? ParseForInit()
        {
            if (IsStmtDeclare())
            {
                Token vartype = consume();
                NodeStmtDeclareSingleVar declare = new();
                if (vartype.Type != TokenType.Int)
                {
                    ErrorExpected("variable type");
                }
                declare.ident = consume();
                if (peek(TokenType.Equal).HasValue)
                {
                    consume();
                    NodeExpr expr = ExpectedExpression(ParseExpr());
                    declare.expr = expr;
                }
                else
                {
                    NodeExpr expr = new();
                    expr.type = NodeExpr.NodeExprType.term;
                    expr.term.type = NodeTerm.NodeTermType.intlit;
                    expr.term.intlit.intlit.Type = TokenType.Int;
                    expr.term.intlit.intlit.Value = "0";
                    declare.expr = expr;
                }
                try_consume_err(TokenType.SemiColon);
                NodeForInit forinit = new NodeForInit();
                forinit.type = NodeForInit.NodeForInitType.declare;
                forinit.declare.type = NodeStmtDeclare.NodeStmtDeclareType.SingleVar;
                forinit.declare.singlevar = declare;
                return forinit;
            }
            else if (IsStmtAssign())
            {
                NodeStmtAssignSingleVar singlevar = new();
                singlevar.ident = consume();
                consume();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                singlevar.expr = expr;
                try_consume_err(TokenType.SemiColon);
                NodeForInit forinit = new NodeForInit();
                forinit.type = NodeForInit.NodeForInitType.assign;
                forinit.assign.type = NodeStmtAssign.NodeStmtAssignType.SingleVar;
                forinit.assign.singlevar = singlevar;
                return forinit;
            }
            try_consume_err(TokenType.SemiColon);
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
            try_consume_err(TokenType.SemiColon);
            return forcond;
        }
        NodeExpr ParseWhileCond()
        {
            try_consume_err(TokenType.OpenParen);
            NodeExpr cond = ExpectedExpression(ParseExpr());
            try_consume_err(TokenType.CloseParen);
            return cond;
        }
        NodeStmtAssign? ParseStmtUpdate()
        {
            if (!IsStmtAssign())
                return null;
            NodeStmtAssignSingleVar singlevar = new();
            singlevar.ident = consume();
            consume();
            NodeExpr expr = ExpectedExpression(ParseExpr());
            singlevar.expr = expr;
            NodeStmtAssign assign = new();
            assign.type = NodeStmtAssign.NodeStmtAssignType.SingleVar;
            assign.singlevar = singlevar;
            return assign;
        }
        NodeForUpdate ParseForUpdate()
        {
            NodeForUpdate forupdate = new();
            forupdate.udpates = [];
            do
            {
                NodeStmtAssign? update = ParseStmtUpdate();
                if (!update.HasValue)
                    break;
                forupdate.udpates.Add(update.Value);
            } while (peekandconsume(TokenType.Comma).HasValue);
            try_consume_err(TokenType.CloseParen);
            return forupdate;
        }
        NodeForPredicate ParseForPredicate()
        {
            NodeForPredicate pred = new NodeForPredicate();
            try_consume_err(TokenType.OpenParen);
            pred.init = ParseForInit();
            pred.cond = ParseForCond();
            pred.udpate = ParseForUpdate();
            NodeScope scope = ParseScope();
            pred.scope = scope;
            return pred;
        }
        List<NodeStmt> ParseDeclareSingleVar()
        {
            List<NodeStmt> stmts = [];
            do
            {
                if (!peek(TokenType.Ident).HasValue)
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"expected identifier\n");
                    Environment.Exit(1);
                }
                Token ident = consume();
                NodeStmtDeclareSingleVar declare = new();
                declare.ident = ident;
                if (peek(TokenType.Equal).HasValue)
                {
                    consume();
                    NodeExpr expr = ExpectedExpression(ParseExpr());
                    declare.expr = expr;
                }
                else
                {
                    NodeExpr expr = new();
                    expr.type = NodeExpr.NodeExprType.term;
                    expr.term.type = NodeTerm.NodeTermType.intlit;
                    expr.term.intlit.intlit.Type = TokenType.Int;
                    expr.term.intlit.intlit.Value = "0";
                    declare.expr = expr;
                }
                NodeStmt stmt = new();
                stmt.type = NodeStmt.NodeStmtType.declare;
                stmt.declare.type = NodeStmtDeclare.NodeStmtDeclareType.SingleVar;
                stmt.declare.singlevar = declare;
                stmts.Add(stmt);
            } while (peekandconsume(TokenType.Comma).HasValue);
            try_consume_err(TokenType.SemiColon);
            return stmts;
        }
        NodeExpr ExprZero()
        {
            NodeExpr expr = new()
            {
                type = NodeExpr.NodeExprType.term
            };
            expr.term.type = NodeTerm.NodeTermType.intlit;
            expr.term.intlit.intlit.Type = TokenType.Int;
            expr.term.intlit.intlit.Value = "0";
            return expr;
        }
        Token parsedimension()
        {
            consume();
            Token size_token = consume();
            if (!uint.TryParse(size_token.Value, out uint _))
            {
                ErrorExpected("a constant size for the array");
            }
            try_consume_err(TokenType.CloseSquare);
            return size_token;
        }
        List<NodeExpr> ParseArrayInit(int dim)
        {
            List<NodeExpr> values = [];
            try_consume_err(TokenType.OpenCurly);
            for (int i = 0; i < dim; i++)
            {
                NodeExpr expr = ExpectedExpression(ParseExpr());
                values.Add(expr);
                if (peek(TokenType.CloseCurly).HasValue)
                {
                    consume();
                    break;
                }
                try_consume_err(TokenType.Comma);
            }
            return values;
        }
        List<NodeExpr> ParseArrayInit1D(int dim)
        {
            List<NodeExpr> values = [];
            values = ParseArrayInit(dim);
            if (values.Count != dim)
            {
                ErrorExpected("dimensions are not aligned");
            }
            return values;
        }
        List<List<NodeExpr>> ParseArrayInit2D(int dim1, int dim2)
        {
            List<List<NodeExpr>> values = [];
            try_consume_err(TokenType.OpenCurly);
            for (int i = 0; i < dim1; i++)
            {
                values.Add(ParseArrayInit1D(dim2));
                if (peek(TokenType.CloseCurly).HasValue)
                {
                    consume();
                    break;
                }
                try_consume_err(TokenType.Comma);
            }
            if (values.Count != dim1)
            {
                ErrorExpected("dimensions are not aligned");
            }
            return values;
        }
        NodeStmt ParseDeclareArray()
        {
            NodeStmtDeclareArray declare = new();
            declare.ident = consume();
            declare.values = [];
            if (!m_Arraydims.ContainsKey(declare.ident.Value))
                m_Arraydims.Add(declare.ident.Value, []);
            while (peek(TokenType.OpenSquare).HasValue)
            {
                Token dim = parsedimension();
                m_Arraydims[declare.ident.Value].Add(new() { intlit = dim });
            }
            //if (peek(TokenType.Equal).HasValue)
            //{
            //    consume();
            //    // TODO: support array initialization for an N-dimensional arrays
            //    if (declare.dims.Count == 1)
            //    {
            //        int dim1 = Convert.ToInt32(declare.dims[0].intlit.Value);
            //        ParseArrayInit1D(dim1).ForEach(x => declare.values.Add(x));
            //    }
            //    else if (declare.dims.Count == 2)
            //    {
            //        int dim1 = Convert.ToInt32(declare.dims[0].intlit.Value);
            //        int dim2 = Convert.ToInt32(declare.dims[1].intlit.Value);
            //        ParseArrayInit2D(dim1, dim2).ForEach(x => x.ForEach(y => declare.values.Add(y)));
            //    }
            //}

            try_consume_err(TokenType.SemiColon);
            NodeStmt stmt = new();
            stmt.type = NodeStmt.NodeStmtType.declare;
            stmt.declare.type = NodeStmtDeclare.NodeStmtDeclareType.Array;
            stmt.declare.array = declare;
            return stmt;
        }
        NodeStmt ParseAssignSingleVar(Token ident)
        {
            NodeStmtAssignSingleVar singlevar = new();
            singlevar.ident = ident;
            consume();
            NodeExpr expr = ExpectedExpression(ParseExpr());
            singlevar.expr = expr;
            try_consume_err(TokenType.SemiColon);
            NodeStmt stmt = new();
            stmt.type = NodeStmt.NodeStmtType.assign;
            stmt.assign.type = NodeStmtAssign.NodeStmtAssignType.SingleVar;
            stmt.assign.singlevar = singlevar;
            return stmt;
        }
        NodeStmt ParseAssignArray(Token ident)
        {
            NodeStmtAssignArray array = new();
            array.ident = ident;
            while (peek(TokenType.OpenSquare).HasValue)
            {
                array.indexes.Add(parseindex());
            }

            try_consume_err(TokenType.Equal);
            NodeExpr expr = ExpectedExpression(ParseExpr());
            array.expr = expr;
            try_consume_err(TokenType.SemiColon);
            NodeStmt stmt = new();
            stmt.type = NodeStmt.NodeStmtType.assign;
            stmt.assign.type = NodeStmtAssign.NodeStmtAssignType.Array;
            stmt.assign.array = array;
            return stmt;
        }
        List<NodeStmt> ParseStmt()
        {
            if (IsStmtDeclare())
            {
                Token vartype = consume();
                if (vartype.Type != TokenType.Int)
                {
                    ErrorExpected("variable type");
                }
                if (peek(TokenType.OpenSquare).HasValue)
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
                Token ident = consume();
                if (peek(TokenType.OpenSquare).HasValue)
                {
                    return [ParseAssignArray(ident)];
                }
                else if (peek(TokenType.Equal).HasValue)
                {
                    return [ParseAssignSingleVar(ident)];
                }
                else
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"invalid assign statement\n");
                    Environment.Exit(1);
                    return [];
                }
            }
            else if (IsStmtIF())
            {
                consume();
                NodeStmtIF iff = new();
                NodeIfPredicate pred = ParseIfPredicate();
                iff.pred = pred;
                NodeIfElifs? elifs = ParseElifs();
                iff.elifs = elifs;
                NodeStmt stmt = new();
                stmt.type = NodeStmt.NodeStmtType.If;
                stmt.If = iff;
                return [stmt];
            }
            else if (IsStmtFor())
            {
                consume();
                NodeStmtFor forr = new();
                NodeForPredicate pred = ParseForPredicate();
                forr.pred = pred;
                NodeStmt stmt = new();
                stmt.type = NodeStmt.NodeStmtType.For;
                stmt.For = forr;
                return [stmt];
            }
            else if (IsStmtWhile())
            {
                consume();
                NodeExpr expr = ParseWhileCond();
                NodeStmtWhile whilee = new();
                whilee.cond = expr;
                NodeScope scope = ParseScope();
                whilee.scope = scope;
                NodeStmt stmt = new();
                stmt.type = NodeStmt.NodeStmtType.While;
                stmt.While = whilee;
                return [stmt];
            }
            else if (IsStmtBreak())
            {
                Token word = consume();
                try_consume_err(TokenType.SemiColon);
                NodeStmtBreak breakk = new();
                breakk.breakk = word;
                NodeStmt stmt = new();
                stmt.type = NodeStmt.NodeStmtType.Break;
                stmt.Break = breakk;
                return [stmt];
            }
            else if (IsStmtContinue())
            {
                Token word = consume();
                try_consume_err(TokenType.SemiColon);
                NodeStmtContinuee continuee = new();
                continuee.continuee = word;
                NodeStmt stmt = new();
                stmt.type = NodeStmt.NodeStmtType.Continue;
                stmt.Continue = continuee;
                return [stmt];
            }
            else if (IsStmtExit())
            {
                consume();
                consume();
                NodeStmtExit exit = new();
                NodeExpr expr = ExpectedExpression(ParseExpr());
                exit.expr = expr;
                try_consume_err(TokenType.CloseParen);
                try_consume_err(TokenType.SemiColon);
                NodeStmt stmt = new();
                stmt.type = NodeStmt.NodeStmtType.Exit;
                stmt.Exit = exit;
                return [stmt];
            }
            else
            {
                Shartilities.Log(Shartilities.LogType.ERROR, $"invalid statement\n");
                Environment.Exit(1);
                return [];
            }
        }


        public NodeProg ParseProg()
        {
            NodeProg prog = new();
            
            while (peek().HasValue)
            {
                List<NodeStmt> stmt = ParseStmt();
                prog.scope.stmts.AddRange(stmt);
            }
            return prog;
        }
    }
}
#pragma warning restore CS8629 // Nullable value type may be null.