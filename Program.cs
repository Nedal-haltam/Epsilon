using System.Text;
namespace Epsilon
{
    internal class Program
    {
        static StringBuilder Compile(string InputFilePath)
        {
            if (!File.Exists(InputFilePath))
                Shartilities.Log(Shartilities.LogType.ERROR, $"file `{InputFilePath}` doesn't exists\n", 1);
            string InputCode = File.ReadAllText(InputFilePath);
            Tokenizer Tokenizer = new(InputCode, InputFilePath);
            List<Token> TokenizedProgram = Tokenizer.TokenizeProg();
            Parser Parser = new(TokenizedProgram, InputFilePath);
            NodeProg ParsedProgram = Parser.ParseProg();
            RISCVGenerator Generator = new(ParsedProgram, Parser.UserDefinedFunctions, InputFilePath, Parser.STD_FUNCTIONS);
            StringBuilder GeneratedProgram = Generator.GenProgram();
            return GeneratedProgram;
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
            //	- refactor array address generation
		    //	- if the input is `.e`: you do compile -> assemble -> link for qemu and output (MC/DM) for CAS
		    //		- but if the -S flag is specified (it should be `.e` file) you just compile (i.e. generate assembly `.S` file)
		    //	- add the -run flag/feature in Epsilon so you can 
		    //	compile (epsilon) -> assemble (risc-v-assembler) -> run (risc-v-CAS) all at once
		    //		- NOTE: running it internally in the code is easier (i.e. calling assembler/CAS APIs), 
		    //		you have to run it using both qemu (external command) and risc-v-assembler/CAS (internal code) to ensure consistent results
		    //		- needs to integrate/include
		    //			- risc-v-assembler
		    //			- risc-v-CAS
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
            StringBuilder Assembly = Compile(InputFilePath);
            if (OutputFilePath == null)
                File.WriteAllText("./a.S", Assembly.ToString());
            else
                File.WriteAllText(OutputFilePath, Assembly.ToString());
        }
    }
}
