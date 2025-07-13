

using System.Text;
namespace Epsilon
{
    internal class Program
    {
        static void Compile(string InputFilePath, string? OutputFilePath = null)
        {
            if (!File.Exists(InputFilePath))
                Shartilities.Log(Shartilities.LogType.ERROR, $"file `{InputFilePath}` doesn't exists\n", 1);
            string InputCode = File.ReadAllText(InputFilePath);
            Tokenizer Tokenizer = new(InputCode, InputFilePath);
            List<Token> TokenizedProgram = Tokenizer.Tokenize();
            Parser Parser = new(TokenizedProgram, InputFilePath);
            NodeProg ParsedProgram = Parser.ParseProg();
            RISCVGenerator Generator = new(ParsedProgram, Parser.UserDefinedFunctions, InputFilePath, Parser.STD_FUNCTIONS);
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
            Console.WriteLine($"Usage: {Environment.ProcessPath} <input file> [-o output file]");
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
