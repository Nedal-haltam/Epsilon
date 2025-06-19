using System;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.RegularExpressions;

namespace Epsilon
{
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

        Auto,
        Char,

        Ident,

        If,
        Elif,
        Else,
        For,
        While,

        IntLit,
        StringLit,

        Func,

        Continue,
        Break,

        Exit,
        Return,
    }
    class Tokenizer(string thecode)
    {
        readonly Dictionary<string, TokenType> KeyWords = new()
        {
            { "auto", TokenType.Auto},
            { "char", TokenType.Char},
            { "if", TokenType.If},
            { "elif", TokenType.Elif},
            { "else", TokenType.Else},
            { "for", TokenType.For},
            { "while", TokenType.While},
            { "break", TokenType.Break},
            { "continue", TokenType.Continue},
            { "func", TokenType.Func},
            { "return", TokenType.Return},
            { "exit", TokenType.Exit},
        };
        private readonly string m_thecode = thecode;
        private int m_curr_index = 0;
        private List<Token> m_tokens = [];
        char? Peek(int offset = 0)
        {
            if (0 <= m_curr_index + offset && m_curr_index + offset < m_thecode.Length)
            {
                return m_thecode[m_curr_index + offset];
            }
            return null;
        }
        char? Peek(char type, int offset = 0)
        {
            char? token = Peek(offset);
            if (token.HasValue && token.Value == type)
            {
                return token;
            }
            return null;
        }
        bool Peek(string type, int offset = 0)
        {
            for (int i = 0; i < type.Length; i++)
            {
                if (!Peek(type[i], offset + i).HasValue)
                    return false;
            }
            return true;
        }
        char Consume()
        {
            return m_thecode.ElementAt(m_curr_index++);
        }
        string ConsumeMany(int ConsumeLength)
        {
            string consumed = m_thecode.Substring(m_curr_index, ConsumeLength);
            m_curr_index += ConsumeLength;
            return consumed;
        }
        bool IsComment()
        {
            return Peek("//") || Peek("/*");
        }
        void ConsumeComment(ref int line)
        {
            if (Peek("//"))
            {
                Consume();
                Consume();
                while (Peek().HasValue && !Peek('\n').HasValue)
                {
                    Consume();
                }
            }
            else if (Peek("/*"))
            {
                Consume();
                Consume();
                while (Peek().HasValue)
                {
                    if (Peek("*/"))
                    {
                        Consume();
                        Consume();
                        break;
                    }
                    if (Peek('\n').HasValue)
                    {
                        line++;
                    }
                    Consume();
                }
            }
            else
            {
                Shartilities.UNREACHABLE("ConsumeComment");
            }
        }
        bool IsPartOfName()
        {
            char? peeked = Peek();
            if (peeked.HasValue)
            {
                return char.IsAsciiLetterOrDigit(peeked.Value) || Peek('_').HasValue;
            }
            return false;
        }
        int SkipUntilNot(char c)
        {
            int count = 0;
            while (Peek(c).HasValue)
            {
                Consume();
                count++;
            }
            return count;
        }
        StringBuilder ConsumeUntil(char c)
        {
            StringBuilder sb = new();
            while (!Peek(c).HasValue)
            {
                sb.Append(Consume());
            }
            return sb;
        }
        public struct Macro
        {
            public List<Token> tokens;
            public string src;
        }
        private readonly Dictionary<string, Macro> macro = [];
        public List<Token> Tokenize()
        {
            m_tokens = [];
            StringBuilder buffer = new(); // this buffer is for multiple letter tokens
            int line = 1;
            while (true)
            {
                char? peeked = Peek();
                if (!peeked.HasValue)
                    break;
                char curr_token = peeked.Value;

                if (char.IsAsciiLetter(curr_token) || curr_token == '_')
                {
                    buffer.Append(Consume());
                    // if it is a letter we will consume until it is not IsAsciiLetterOrDigit
                    while (Peek().HasValue && IsPartOfName())
                    {
                        buffer.Append(Consume());
                    }
                    string word = buffer.ToString();
                    if (macro.TryGetValue(word, out Macro value))
                    {
                        m_tokens.AddRange(value.tokens);
                    }
                    else if (KeyWords.TryGetValue(word, out TokenType tt))
                    {
                        m_tokens.Add(new() { Value = word, Type = tt, Line = line });
                    }
                    else
                    {
                        m_tokens.Add(new() { Value = word, Type = TokenType.Ident, Line = line });
                    }
                    buffer.Clear();
                }
                else if (char.IsDigit(curr_token))
                {
                    buffer.Append(Consume());

                    while (true)
                    {
                        char? NextDigit = Peek();
                        if (NextDigit.HasValue && char.IsDigit(NextDigit.Value))
                            buffer.Append(Consume());
                        else
                            break;
                    }
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.IntLit, Line = line });
                    buffer.Clear();
                }
                else if (Peek("#define "))
                {
                    ConsumeMany(8);
                    SkipUntilNot(' ');
                    while (Peek().HasValue && IsPartOfName())
                    {
                        buffer.Append(Consume());
                    }
                    string macroname = buffer.ToString();
                    buffer.Clear();
                    SkipUntilNot(' ');

                    buffer.Append(ConsumeUntil('\n'));
                    Consume();
                    string MacroSrc = buffer.ToString();
                    Tokenizer temp = new(MacroSrc);
                    List<Token> macrovalue = temp.Tokenize();
                    macro.Add(macroname, new() { src = MacroSrc, tokens = macrovalue });
                }
                else if (IsComment())
                {
                    ConsumeComment(ref line);
                }
                else if (Peek("<<"))
                {
                    buffer.Append(Consume());
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Sll, Line = line });
                }
                else if (Peek(">>"))
                {
                    buffer.Append(Consume());
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Srl, Line = line });
                }
                else if (Peek("=="))
                {
                    buffer.Append(Consume());
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.EqualEqual, Line = line });
                }
                else if (Peek("!="))
                {
                    buffer.Append(Consume());
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.NotEqual, Line = line });
                }
                else if (Peek('\"').HasValue)
                {
                    Consume();
                    buffer.Append(ConsumeUntil('\"'));
                    Consume();
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.StringLit, Line = line });
                }
                else if (Peek('\'').HasValue)
                {
                    Consume();
                    buffer.Append(ConsumeUntil('\''));
                    if (buffer.Length == 0)
                    {
                        Shartilities.Log(Shartilities.LogType.ERROR, $"empty character is assigned on line {line}\n");
                        Environment.Exit(1);
                    }
                    if (buffer.Length != 1)
                    {
                        Shartilities.Log(Shartilities.LogType.ERROR, $"Error expected a single character between single quotes but got `{buffer}` on line {line}\n");
                        Environment.Exit(1);
                    }
                    Consume();
                    m_tokens.Add(new() { Value = Convert.ToUInt32(buffer.ToString()[0]).ToString(), Type = TokenType.IntLit, Line = line });
                }
                else if (Peek('(').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.OpenParen, Line = line});
                }
                else if (Peek(')').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.CloseParen, Line = line});
                }
                else if (Peek('[').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.OpenSquare, Line = line});
                }
                else if (Peek(']').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.CloseSquare, Line = line});
                }
                else if (Peek('{').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.OpenCurly, Line = line});
                }
                else if (Peek('}').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.CloseCurly, Line = line});
                }
                else if (Peek(',').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Comma, Line = line});
                }
                else if (Peek('+').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Plus, Line = line});
                }
                else if (Peek('*').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Mul, Line = line});
                }
                else if (Peek('%').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Rem, Line = line});
                }
                else if (Peek('/').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Div, Line = line});
                }
                else if (Peek('-').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Minus, Line = line});
                }
                else if (Peek('&').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.And, Line = line});
                }
                else if (Peek('|').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Or, Line = line});
                }
                else if (Peek('^').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Xor, Line = line});
                }
                else if (Peek('<').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.LessThan, Line = line});
                }
                else if (Peek('=').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.Equal , Line = line});
                }
                else if (Peek(';').HasValue)
                {
                    buffer.Append(Consume());
                    m_tokens.Add(new() { Value = buffer.ToString(), Type = TokenType.SemiColon, Line = line});
                }
                else if (curr_token == '\n')
                {
                    Consume();
                    line++;
                }
                else if (char.IsWhiteSpace(curr_token))
                {
                    Consume();
                }
                else
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Invalid token: {curr_token}\n");
                    Environment.Exit(1);
                }
                buffer.Clear();
            }
            m_curr_index = 0;
            return m_tokens;
        }
    }
}
