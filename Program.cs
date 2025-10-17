using System.Diagnostics;
using System.Text;
using static Epsilon.NodeBinExpr;
using static Epsilon.NodeTermUnaryExpr;

namespace Epsilon
{
    internal sealed class Program
    {
        static StringBuilder Compile(string InputFilePath, bool Optimize)
        {
            string InputCode = Shartilities.ReadFile(InputFilePath);

            List<Token> TokenizedProgram = new Tokenizer(InputCode, InputFilePath, []).TokenizeProg();
            NodeProg ParsedProgram = new Parser(TokenizedProgram, InputFilePath).ParseProg();

            //StringBuilder Before = Arborist.CutProgram(ParsedProgram);
            //Shartilities.WriteFile("./Before.e", Before.ToString(), false);

            if (Optimize) Optimizer.OptimizeProgram(ref ParsedProgram);

            //StringBuilder After = Arborist.CutProgram(ParsedProgram);
            //Shartilities.WriteFile("./After.e", After.ToString(), false);

            StringBuilder GeneratedProgram = Generator.GenProgram(ParsedProgram, InputFilePath);

            return GeneratedProgram;
        }
        static void AssembleAndLinkForQemu(string SourceFilePath, string OutputFilePath)
        {
            Shartilities.Command cmd = new(["riscv64-linux-gnu-gcc","-o", OutputFilePath,SourceFilePath,"-static"]);
            Process? p = null;
            if (!cmd.RunSyncRealTime(ref p, out string stdout, out string stderr)) Environment.Exit(p!.ExitCode);
        }
        static void RunOnQemu(string FilePath)
        {
            Shartilities.Command cmd = new Shartilities.Command(["qemu-riscv64", FilePath]);
            Process? p = null;
            cmd.RunSyncRealTime(ref p, out string stdout, out string stderr);
            Environment.Exit(p!.ExitCode);
        }
        static LibUtils.Program AssembleAndLinkForCAS(string SourceFilePath, string OutputFilePath, bool Generate)
        {
            LibUtils.Program p = Assembler.Assembler.AssembleProgram(SourceFilePath, false);
            if (Generate)
            {
                string IM_INIT_filepath = $"{OutputFilePath}_IM_INIT.INIT";
                string DM_INIT_filepath = $"{OutputFilePath}_DM_INIT.INIT";
                string MC_filepath = $"{OutputFilePath}_MC.txt";
                string DM_filepath = $"{OutputFilePath}_DM.txt";
                string IM_MIF_filepath = $"{OutputFilePath}_IM_MIF.mif";
                string DM_MIF_filepath = $"{OutputFilePath}_DM_MIF.mif";

                StringBuilder IM_INIT = LibUtils.GetIM_INIT(p.MachineCodes, p.Instructions);
                Shartilities.WriteFile(IM_INIT_filepath, IM_INIT.ToString(), false, 1);

                StringBuilder DM_INIT = LibUtils.GetDM_INIT(p.DataMemoryValues);
                Shartilities.WriteFile(DM_INIT_filepath, DM_INIT.ToString(), false, 1);

                List<string> IM = LibUtils.GetIM(p.MachineCodes);
                File.WriteAllLines(MC_filepath, IM);

                List<string> DM = LibUtils.ParseDataMemoryValues(p.DataMemoryValues);
                File.WriteAllLines(DM_filepath, DM);

                Shartilities.WriteFile(IM_MIF_filepath, LibUtils.GetIMMIF(p.MachineCodes).ToString(), false, 1);

                Shartilities.WriteFile(DM_MIF_filepath, LibUtils.GetDMMIF(p.DataMemoryValues).ToString(), false, 1);
            }
            return p;
        }
        static LibUtils.Program CompileAssembleLink(string SourceFilePath, string OutputFilePath, bool Optimize, bool DoQemu, bool DoCAS, bool CasGenerate, bool Dump)
        {
            LibUtils.Program p = new();
            if (!SourceFilePath.EndsWith(".S"))
            {
                string TempAssembly = OutputFilePath + ".S";
                {
                    StringBuilder Assembly = Compile(SourceFilePath, Optimize);
                    Shartilities.WriteFile(TempAssembly, Assembly.ToString(), false);
                }
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
            Console.WriteLine($"  -dump         don't erase any generated files during compilation in general");
            Console.WriteLine($"  -O            enable optimization");
            Console.WriteLine();
            Console.WriteLine($"Notes:");
            Console.WriteLine($"  - Default behavior (no -S/-run/-sim) compiles, assembles, links, and generates the executable, and files needed by the CAS.");
        }
        static void Main(string[] args)
        {
            // TODO:
            //    - deal with multiple files
            //        - if you start with .e file you interpret the rest as epsilon files and you start from the compile step
            //        - if you start with .S file you interpret the rest as assembly files and you start from the assemble step
            //Compile("../../../main.e");

            string? OutputFilePath = null;
            List<string> InputFilePaths = [];
            bool Optimize = false;
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
                else if (arg == "-O")
                {
                    Optimize = true;
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
                else if (arg == "-h" || arg == "--h" || arg == "-help" || arg == "--help")
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
                if (log) Console.WriteLine("running");
                OutputFilePath ??= "./a";
                CompileAssembleLink(SourceFilePath, OutputFilePath, Optimize, true, false, false, Dump);
                RunOnQemu(OutputFilePath);
            }
            else if (Sim)
            {
                if (log) Console.WriteLine("simulating");
                OutputFilePath ??= "./a";
                LibUtils.Program p = CompileAssembleLink(SourceFilePath, OutputFilePath, Optimize, false, true, false, Dump);
                List<string> MC = LibUtils.GetIM(p.MachineCodes);
                List<string> DM = LibUtils.ParseDataMemoryValues(p.DataMemoryValues);
                LibCPU.SingleCycle.Run(MC, DM, 16384, 16384, null);
            }
            else if (CompileOnly)
            {
                if (log) Console.WriteLine("compile only");
                OutputFilePath ??= "./a.S";
                StringBuilder Assembly = Compile(SourceFilePath, Optimize);
                Shartilities.WriteFile(OutputFilePath, Assembly.ToString(), false);
            }
            else
            {
                if (log) Console.WriteLine("compiling and assembling");
                OutputFilePath ??= "./a";
                CompileAssembleLink(SourceFilePath, OutputFilePath, Optimize, true, true, true, Dump);
            }
        }
    }
}
