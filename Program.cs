using CliWrap.Buffered;
using System.Text;

namespace Epsilon
{
    internal class Program
    {
        static StringBuilder Compile(string InputCode, string InputFilePath)
        {
            List<Token> TokenizedProgram = new Tokenizer(InputCode, InputFilePath).TokenizeProg();
            Parser Parser = new(TokenizedProgram, InputFilePath);
            NodeProg ParsedProgram = Parser.ParseProg();
            StringBuilder GeneratedProgram = RISCVGenerator.GenProgram(ParsedProgram, Parser.UserDefinedFunctions, InputFilePath, Parser.STD_FUNCTIONS);
            return GeneratedProgram;
        }
        static StringBuilder Compile(string SourceFilePath)
        {
            if (!File.Exists(SourceFilePath))
                Shartilities.Log(Shartilities.LogType.ERROR, $"file {SourceFilePath} doesn't exists\n", 1);
            string InputCode = File.ReadAllText(SourceFilePath);
            return Compile(InputCode, SourceFilePath);
        }
        static void Main(string[] args)
        {
            //Compile("../../../main.e");
            //		- needs to integrate/include from risc-v-utils
            //			- risc-v-assembler
            //			- risc-v-CAS
            // TODO: add usage
            // TODO: add -h arguemnt to display usage
            string? OutputFilePath = null;
            List<string> InputFilePaths = [];
            bool CompileOnly = false;
            bool Run = false; // Run using qemu
            bool Sim = false; // simulate using our cycle accurate simulator
            while (Shartilities.ShiftArgs(ref args, out string arg))
            {
                if (arg == "-o")
                {
                    if (!Shartilities.ShiftArgs(ref args, out string OutputFilePathuser))
                        Shartilities.Log(Shartilities.LogType.ERROR, $"Expected output file path after -o\n", 1);
                    OutputFilePath = OutputFilePathuser;
                }
                else if (arg == "-run")
                {
                    Run = true;
                }
                else if (arg == "-sim")
                {
                    Sim = true;
                }
                else if (arg == "-S")
                {
                    CompileOnly = true;
                }
                else
                {
                    InputFilePaths.Add(arg);
                }
            }
            if (InputFilePaths.Count == 0)
                Shartilities.Logln(Shartilities.LogType.ERROR, $"no input files was provided", 1);
            string SourceFilePath = InputFilePaths[0];

            if (Run)
            {
                Shartilities.TODO("run using qemu");
            }
            else if (Sim)
            {
                Shartilities.TODO("simulate using CAS");
            }
            else if (CompileOnly)
            {
                OutputFilePath ??= "./a.S";
                if (!File.Exists(SourceFilePath))
                    Shartilities.Log(Shartilities.LogType.ERROR, $"file {SourceFilePath} doesn't exists\n", 1);
                string InputCode = File.ReadAllText(SourceFilePath);
                StringBuilder Assembly = Compile(InputCode, SourceFilePath);
                File.WriteAllText(OutputFilePath, Assembly.ToString());
            }
            else
            {
                string TempAssembly = "./temp.S";
                OutputFilePath ??= "./a";
                if (!File.Exists(SourceFilePath))
                    Shartilities.Log(Shartilities.LogType.ERROR, $"file {SourceFilePath} doesn't exists\n", 1);
                string InputCode = File.ReadAllText(SourceFilePath);
                StringBuilder Assembly = Compile(InputCode, SourceFilePath);
                File.WriteAllText(TempAssembly, Assembly.ToString());

                //riscv64-linux-gnu-gcc -o ./main ./main.S -static
                var AssemblingAndLink = CliWrap.Cli
                  .Wrap("riscv64-linux-gnu-gcc")
                  .WithArguments($" -o {OutputFilePath} {TempAssembly} -static")
                  .ExecuteBufferedAsync();

                if (File.Exists(TempAssembly)) 
                    File.Delete(TempAssembly);
                
                File.WriteAllText(OutputFilePath, Assembly.ToString());
            }
        }
    }
}
