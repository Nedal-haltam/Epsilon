

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
            Tokenizer Tokenizer = new(InputCode, InputFilePath);
            List<Token> TokenizedProgram = Tokenizer.Tokenize();
            Parser Parser = new(TokenizedProgram, InputFilePath);
            NodeProg ParsedProgram = Parser.ParseProg();
            RISCVGenerator Generator = new(ParsedProgram, Parser.UserDefinedFunctions, InputFilePath);
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
        static void Usage()
        {
            Shartilities.Log(Shartilities.LogType.NORMAL, $"Usage: {Environment.ProcessPath} <input file> [-o output file]\n");
        }
        static void Main(string[] args)
        {
            //Compile("../../../main.e");
            if (!Shartilities.ShiftArgs(ref args, out string InputFilePath))
            {
                Shartilities.Log(Shartilities.LogType.ERROR, "no input file provided\n");
                Usage();
                Environment.Exit(1);
            }
            string? OutputFilePath = null;
            while (Shartilities.ShiftArgs(ref args, out string arg))
            {
                if (arg == "-o")
                {
                    if (!Shartilities.ShiftArgs(ref args, out string OutputFilePathuser))
                    {
                        Shartilities.Log(Shartilities.LogType.ERROR, $"Expected output file path\n", 1);
                    }
                    OutputFilePath = OutputFilePathuser;
                }
                else
                {
                    Shartilities.Log(Shartilities.LogType.ERROR, $"Invalid flag `{arg}` was provided\n");
                    Usage();
                    Environment.Exit(1);
                }
            }

            Compile(InputFilePath, OutputFilePath);
        }
    }
}
