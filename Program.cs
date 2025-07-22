using CliWrap.Buffered;
using System.Reflection;
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
        static StringBuilder Compile(string SourceFilePath) => Compile(Shartilities.ReadFile(SourceFilePath), SourceFilePath);
        static void AssembleAndLinkForQemu(string SourceFilePath, string OutputFilePath)
        {
            var AssemblingAndLinkResult = CliWrap.Cli
              .Wrap("riscv64-linux-gnu-gcc")
              .WithArguments($" -o {OutputFilePath} {SourceFilePath} -static")
              .WithValidation(CliWrap.CommandResultValidation.None)
              .ExecuteBufferedAsync()
              .GetAwaiter()
              .GetResult();
            if (!AssemblingAndLinkResult.IsSuccess)
            {
                Console.Write($"standard output:\n");
                Console.Write(AssemblingAndLinkResult.StandardOutput);
                Console.Write($"standard error:\n");
                Console.Write(AssemblingAndLinkResult.StandardError);
                Environment.Exit(AssemblingAndLinkResult.ExitCode);
            }
            Shartilities.UNUSED(AssemblingAndLinkResult);
        }
        static void RunOnQemu(string FilePath)
        {
            var RunResult = CliWrap.Cli
              .Wrap("qemu-riscv64")
              .WithArguments($"{FilePath}")
              .WithValidation(CliWrap.CommandResultValidation.None)
              .ExecuteBufferedAsync()
              .GetAwaiter()
              .GetResult();

            Console.Write(RunResult.StandardOutput);
            Environment.Exit(RunResult.ExitCode);
        }
        static void AssembleAndLinkForCAS(string SourceFilePath, string OutputFilePath)
        {
            LibUtils.Program p = Assembler.Assembler.AssembleProgram(SourceFilePath, false);
            List<string> IM = LibUtils.GetIM(p.MachineCodes);
            List<string> DM = LibUtils.ParseDataMemoryValues(p.DataMemoryValues);
            File.WriteAllLines(OutputFilePath + "_IM", IM);
            File.WriteAllLines(OutputFilePath + "_DM", DM);
        }
        static void Main(string[] args)
        {
            //Compile("../../../main.e");
            //      - deal with multiple files
            //          - if you start with .e file you interpret the rest as epsilon files and you start from the compile step
            //          - if you start with .S file you interpret the rest as assembly files and you start from the assemble step
            // TODO: add usage
            // TODO: add -h arguemnt to display usage
            string? OutputFilePath = null;
            List<string> InputFilePaths = [];
            bool CompileOnly = false;
            bool Run = false; // Run using qemu
            bool Sim = false; // simulate using my cycle accurate simulator
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
                string TempAssembly = SourceFilePath;
                OutputFilePath ??= "./a";
                string InputCode = Shartilities.ReadFile(SourceFilePath);
                bool IsAssemblyFile = SourceFilePath.EndsWith(".S");
                if (!IsAssemblyFile)
                {
                    TempAssembly = "./temp.S";
                    StringBuilder Assembly = Compile(InputCode, SourceFilePath);
                    File.WriteAllText(TempAssembly, Assembly.ToString());
                }

                AssembleAndLinkForQemu(TempAssembly, OutputFilePath);

                if (!IsAssemblyFile && File.Exists(TempAssembly))
                    File.Delete(TempAssembly);

                RunOnQemu(OutputFilePath);
            }
            else if (Sim)
            {
                Shartilities.TODO("simulate using CAS");
            }
            else if (CompileOnly)
            {
                OutputFilePath ??= "./a.S";
                string InputCode = Shartilities.ReadFile(SourceFilePath);
                StringBuilder Assembly = Compile(InputCode, SourceFilePath);
                File.WriteAllText(OutputFilePath, Assembly.ToString());
            }
            else
            {
                string TempAssembly = SourceFilePath;
                OutputFilePath ??= "./a";
                string InputCode = Shartilities.ReadFile(SourceFilePath);
                bool IsAssemblyFile = SourceFilePath.EndsWith(".S");
                if (!IsAssemblyFile)
                {
                    TempAssembly = "./temp.S";
                    StringBuilder Assembly = Compile(InputCode, SourceFilePath);
                    File.WriteAllText(TempAssembly, Assembly.ToString());
                }

                AssembleAndLinkForQemu(TempAssembly, OutputFilePath);
                AssembleAndLinkForCAS(TempAssembly, OutputFilePath);

                if (!IsAssemblyFile && File.Exists(TempAssembly))
                    File.Delete(TempAssembly);
            }
        }
    }
}
