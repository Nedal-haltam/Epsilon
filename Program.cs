using System.Diagnostics;
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

            StringBuilder GeneratedProgram = Generator.GenProgram(ParsedProgram, Parser.UserDefinedFunctions, InputFilePath, Parser.STD_FUNCTIONS);
            return GeneratedProgram;
        }
        static StringBuilder Compile(string SourceFilePath) => Compile(Shartilities.ReadFile(SourceFilePath), SourceFilePath);
        static void AssembleAndLinkForQemu(string SourceFilePath, string OutputFilePath)
        {
            Shartilities.Command cmd = new(["riscv64-linux-gnu-gcc", "-o", OutputFilePath, SourceFilePath, "-static"]);
            Process? p = new();
            if (!cmd.RunSync(ref p))
            {
                Console.Write($"standard output:\n");
                Console.Write(p!.StandardOutput.ReadToEnd());
                Console.Write($"standard error:\n");
                Console.Write(p!.StandardError.ReadToEnd());
                Environment.Exit(p!.ExitCode);
            }
            Console.Write(p!.StandardOutput.ReadToEnd());
        }
        static void RunOnQemu(string FilePath)
        {
            Process? p = new();
            new Shartilities.Command(["qemu-riscv64", FilePath]).RunSync(ref p);
            Console.Write(p!.StandardOutput.ReadToEnd());
            Environment.Exit(p!.ExitCode);
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
        static LibUtils.Program CompileAssembleLink(string SourceFilePath, string OutputFilePath, bool DoQemu, bool DoCAS, bool CasGenerate, bool Dump)
        {
            LibUtils.Program p = new();
            if (!SourceFilePath.EndsWith(".S"))
            {
                string TempAssembly = OutputFilePath + ".S";
                string InputCode = Shartilities.ReadFile(SourceFilePath);
                StringBuilder Assembly = Compile(InputCode, SourceFilePath);
                File.WriteAllText(TempAssembly, Assembly.ToString());
                if (DoQemu)
                    AssembleAndLinkForQemu(TempAssembly, OutputFilePath);
                if (DoCAS)
                    p = AssembleAndLinkForCAS(TempAssembly, OutputFilePath, CasGenerate || Dump);
                if (!Dump && File.Exists(TempAssembly))
                    File.Delete(TempAssembly);
            }
            else
            {
                string TempAssembly = SourceFilePath;
                if (DoQemu)
                    AssembleAndLinkForQemu(TempAssembly, OutputFilePath);
                if (DoCAS)
                    p = AssembleAndLinkForCAS(TempAssembly, OutputFilePath, CasGenerate || Dump);
            }
            return p;
        }
        static void Usage()
        {
            Console.WriteLine($"Usage:");
            Console.WriteLine($"  {Environment.ProcessPath} [options] <input_file>");
            Console.WriteLine();
            Console.WriteLine($"Options:");
            Console.WriteLine($"  -o <file>     Specify output file path (default: ./a or ./a.S for -S)");
            Console.WriteLine($"  -S            Compile only; generate assembly and exit");
            Console.WriteLine($"  -run          Compile, assemble, link, and run using QEMU");
            Console.WriteLine($"  -sim          Compile, assemble, and simulate using the custom simulator (CAS)");
            Console.WriteLine($"  -h            Display this usage information");
            Console.WriteLine();
            Console.WriteLine($"Notes:");
            Console.WriteLine($"  - Default behavior (no -S/-run/-sim) compiles, assembles, links, and generates the executable, and files needed by the CAS.");
        }
        static void Main(string[] args)
        {
            //Compile("../../../main.e");
            //      - deal with multiple files
            //          - if you start with .e file you interpret the rest as epsilon files and you start from the compile step
            //          - if you start with .S file you interpret the rest as assembly files and you start from the assemble step

            string? OutputFilePath = null;
            List<string> InputFilePaths = [];
            bool CompileOnly = false;
            bool Run = false; // Run using qemu
            bool Sim = false; // simulate using my cycle accurate simulator
            bool Dump = false;
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
                else if (arg == "-dump")
                {
                    Dump = true;
                }
                else if (arg == "-h")
                {
                    Usage();
                    Environment.Exit(0);
                }
                else
                {
                    InputFilePaths.Add(arg);
                }
            }

            if (InputFilePaths.Count == 0)
                Shartilities.Logln(Shartilities.LogType.ERROR, $"no input files was provided", 1);
            string SourceFilePath = InputFilePaths[0];

            bool log = false;
            if (Run)
            {
                if (log)
                    Console.WriteLine("running");
                OutputFilePath ??= "./a";
                CompileAssembleLink(SourceFilePath, OutputFilePath, true, false, false, Dump);
                RunOnQemu(OutputFilePath);
            }
            else if (Sim)
            {
                if (log)
                    Console.WriteLine("simulating");
                OutputFilePath ??= "./a";
                LibUtils.Program p = CompileAssembleLink(SourceFilePath, OutputFilePath, false, true, false, Dump);
                List<string> MC = LibUtils.GetIM(p.MachineCodes);
                List<string> DM = LibUtils.ParseDataMemoryValues(p.DataMemoryValues);
                LibCPU.SingleCycle.Run(MC, DM, 4096, 4096, null);
            }
            else if (CompileOnly)
            {
                if (log)
                    Console.WriteLine("compile only");
                OutputFilePath ??= "./a.S";
                string InputCode = Shartilities.ReadFile(SourceFilePath);
                StringBuilder Assembly = Compile(InputCode, SourceFilePath);
                File.WriteAllText(OutputFilePath, Assembly.ToString());
            }
            else
            {
                if (log)
                    Console.WriteLine("compiling and assembling");
                OutputFilePath ??= "./a";
                CompileAssembleLink(SourceFilePath, OutputFilePath, true, true, true, Dump);
            }
        }
    }
}
