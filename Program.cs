

using System.Collections.Generic;
using System.Data;
using System.Net.NetworkInformation;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using static System.Formats.Asn1.AsnWriter;




namespace Epsilon
{
    internal class Program
    {
        static void Compile(string InputFilePath, string? OutputFilePath = null)
        {
            string InputCode = File.ReadAllText(InputFilePath);
            Tokenizer Tokenizer = new(InputCode);
            List<Token> TokenizedProgram = Tokenizer.Tokenize();
            Parser Parser = new(TokenizedProgram);
            NodeProg ParsedProgram = Parser.ParseProg();
            MIPSGenerator Generator = new(ParsedProgram, Parser.m_Arraydims);
            StringBuilder GeneratedProgram = Generator.GenProg();
            if (OutputFilePath == null)
            {
                File.WriteAllText("./a.S", GeneratedProgram.ToString());
            }
            else
            {
                File.WriteAllText(OutputFilePath, GeneratedProgram.ToString());
            }
        }
        static void Main(string[] args)
        {
            if (!Shartilities.ShiftArgs(ref args, out string InputFilePath))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, "no input file provided\n");
                Shartilities.Log(Shartilities.LogType.NORMAL, $"Usage: {Environment.ProcessPath} <input file> [output file]");
                Environment.Exit(1);
            }
            if (!Shartilities.ShiftArgs(ref args, out string? OutputFilePath))
                OutputFilePath = null;

            Compile(InputFilePath, OutputFilePath);
        }
    }
}
