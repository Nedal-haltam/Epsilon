using CliWrap;
using CliWrap.Buffered;
using CliWrap.EventStream;
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
            var RunResult = RunCommandSync(["qemu-riscv64", FilePath]).Result;
            Environment.Exit(RunResult.ExitCode);
        }
        static async Task<BufferedCommandResult> RunCommandSync(string[] args)
        {
            Shartilities.Assert(args.Length > 0, $"no enough arguments to execute command");
            var Command = Cli
                .Wrap(args[0])
                .WithArguments(args[1..])
                .WithValidation(CommandResultValidation.None);

            var CommandTask = Command.ExecuteBufferedAsync();

            await foreach (var CommandEvent in Command.ListenAsync())
            {
                switch (CommandEvent)
                {
                    case StandardOutputCommandEvent stdOut:
                        Console.WriteLine(stdOut.Text);
                        break;
                    case StandardErrorCommandEvent stdErr:
                        Console.Error.WriteLine(stdErr.Text);
                        break;
                }
            }
            var result = CommandTask.GetAwaiter().GetResult();
            return result;
        }
        static LibUtils.Program AssembleAndLinkForCAS(string SourceFilePath, string OutputFilePath, bool Generate)
        {
            LibUtils.Program p = Assembler.Assembler.AssembleProgram(SourceFilePath, false);
            List<string> IM = LibUtils.GetIM(p.MachineCodes);
            List<string> DM = LibUtils.ParseDataMemoryValues(p.DataMemoryValues);
            if (Generate)
            {
                File.WriteAllLines(OutputFilePath + "_IM", IM);
                File.WriteAllLines(OutputFilePath + "_DM", DM);
            }
            return p;
        }
        static LibUtils.Program CompileAssembleLink(string SourceFilePath, string OutputFilePath, bool DoQemu, bool DoCAS, bool CasGenerate)
        {
            string TempAssembly = SourceFilePath;
            string InputCode = Shartilities.ReadFile(SourceFilePath);
            bool IsAssemblyFile = SourceFilePath.EndsWith(".S");
            if (!IsAssemblyFile)
            {
                TempAssembly = "./temp.S";
                StringBuilder Assembly = Compile(InputCode, SourceFilePath);
                File.WriteAllText(TempAssembly, Assembly.ToString());
            }
            LibUtils.Program p = new();
            if (DoQemu)
                AssembleAndLinkForQemu(TempAssembly, OutputFilePath);
            if (DoCAS)
                p = AssembleAndLinkForCAS(TempAssembly, OutputFilePath, CasGenerate);

            if (!IsAssemblyFile && File.Exists(TempAssembly))
                File.Delete(TempAssembly);
            return p;
        }
        static void Main(string[] args)
        {
            //Compile("../../../main.e");
            //      - deal with multiple files
            //          - if you start with .e file you interpret the rest as epsilon files and you start from the compile step
            //          - if you start with .S file you interpret the rest as assembly files and you start from the assemble step
            // TODO: add usage
            // TODO: add -h arguemnt to display usage
			// TODO: change epsilon syntax like for example
			// for (auto i = 0; i < 10; i = i + 1) -->> for i in 0..10
			// and other new different syntax for other things/statements
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
                OutputFilePath ??= "./a";
                CompileAssembleLink(SourceFilePath, OutputFilePath, true, false, false);
                RunOnQemu(OutputFilePath);
            }
            else if (Sim)
            {
                OutputFilePath ??= "./a";
                LibUtils.Program p = CompileAssembleLink(SourceFilePath, OutputFilePath, false, true, false);
                List<string> MC = LibUtils.GetIM(p.MachineCodes);
                List<string> DM = LibUtils.ParseDataMemoryValues(p.DataMemoryValues);
                LibCPU.SingleCycle.Run(MC, DM, 4096, 4096, null);
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
                OutputFilePath ??= "./a";
                CompileAssembleLink(SourceFilePath, OutputFilePath, true, true, true);
            }
        }
    }
}
