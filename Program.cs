using System.Diagnostics;
using System.Text;
using static Epsilon.NodeBinExpr;
using static Epsilon.NodeTermUnaryExpr;

namespace Epsilon
{
    static class Arborist
    {
        static string GetBinOpStr(NodeBinExprType type)
        {
            switch (type)
            {
                case NodeBinExprType.Add:        return "+";
                case NodeBinExprType.Sub:        return "-";
                case NodeBinExprType.Mul:        return "*";
                case NodeBinExprType.Rem:        return "%";
                case NodeBinExprType.Div:        return "/";
                case NodeBinExprType.Sll:        return "<<";
                case NodeBinExprType.Srl:        return ">>";
                case NodeBinExprType.EqualEqual: return "==";
                case NodeBinExprType.NotEqual:   return "!=";
                case NodeBinExprType.LessThan:   return "<";
                case NodeBinExprType.And:        return "&";
                case NodeBinExprType.Or:         return "|";
                case NodeBinExprType.Xor:        return "^";
                default:
                    Shartilities.UNREACHABLE("GetBinOpStr");
                    break;
            }
            return "";
        }
        static string GetUnOpStr(NodeTermUnaryExprType type)
        {
            switch (type)
            {
                case NodeTermUnaryExprType.negative:   return "-";
                case NodeTermUnaryExprType.complement: return "!";
                case NodeTermUnaryExprType.not:        return "~";
                case NodeTermUnaryExprType.addressof:  return "&";
                default:
                    Shartilities.UNREACHABLE("GetUnOpStr");
                    break;
            }
            return "";
        }
        static StringBuilder CutTerm(NodeTerm term)
        {
            StringBuilder sb = new();
            switch (term.type)
            {
                case NodeTerm.NodeTermType.IntLit:
                    sb.Append($"{term.intlit.intlit.Value}");
                    break;
                case NodeTerm.NodeTermType.StringLit:
                    sb.Append($"\"{term.stringlit.stringlit.Value}\"");
                    break;
                case NodeTerm.NodeTermType.FunctionCall:
                    sb.Append($"{term.functioncall.FunctionName.Value}");
                    sb.Append($"(");
                    for (int j = 0; j < term.functioncall.parameters.Count; j++)
                    {
                        sb.Append($"{CutExpr(term.functioncall.parameters[j])}");
                        if (j != term.functioncall.parameters.Count - 1) sb.Append(", ");
                    }
                    sb.Append($")");
                    break;
                case NodeTerm.NodeTermType.Ident:
                    sb.Append($"{term.ident.ident.Value}");
                    for (int i = 0; i < term.ident.indexes.Count; i++)
                        sb.Append($"[{CutExpr(term.ident.indexes[i])}]");
                    break;
                case NodeTerm.NodeTermType.Paren:
                    sb.Append($"({CutExpr(term.paren.expr)})");
                    break;
                case NodeTerm.NodeTermType.Unary:
                    sb.Append($"{GetUnOpStr(term.unary.type)}{CutTerm(term.unary.term)}");
                    break;
                case NodeTerm.NodeTermType.Variadic:
                    sb.Append($"__VARIADIC_ARGS__({CutExpr(term.variadic.VariadicIndex)})");
                    break;
                default:
                    Shartilities.UNREACHABLE("CutTerm");
                    break;
            }
            return sb;
        }
        static StringBuilder CutExpr(NodeExpr expr)
        {
            StringBuilder sb = new();
            switch (expr.type)
            {
                case NodeExpr.NodeExprType.Term:
                    sb.Append($"{CutTerm(expr.term)}");
                    break;
                case NodeExpr.NodeExprType.BinExpr:
                    sb.Append($"{CutExpr(expr.binexpr.lhs)} {GetBinOpStr(expr.binexpr.type)} {CutExpr(expr.binexpr.rhs)}");
                    break;
                case NodeExpr.NodeExprType.None:
                    break;
                default:
                    Shartilities.UNREACHABLE("CutExpr");
                    break;
            }
            return sb;
        }
        static StringBuilder CutElifs(NodeIfElifs elifs, int pad)
        {
            StringBuilder sb = new();
            string pp = "".PadLeft(pad, ' ');
            switch (elifs.type)
            {
                case NodeIfElifs.NodeIfElifsType.Elif:
                    sb.AppendLine($"{pp}elif ({CutExpr(elifs.elif.pred.cond)})");
                    sb.AppendLine($"{pp}{{");
                    sb.Append($"{CutStmts(elifs.elif.pred.scope.stmts, pad + 4)}");
                    sb.AppendLine($"{pp}}}");
                    if (elifs.elif.elifs.HasValue) sb.Append($"{CutElifs(elifs.elif.elifs.Value, pad)}");
                    break;
                case NodeIfElifs.NodeIfElifsType.Else:
                    sb.AppendLine($"{pp}else");
                    sb.AppendLine($"{pp}{{");
                    sb.Append($"{CutStmts(elifs.elsee.scope.stmts, pad + 4)}");
                    sb.AppendLine($"{pp}}}");
                    break;
                default:
                    Shartilities.UNREACHABLE("CutElifs");
                    break;
            }
            return sb;
        }
        static StringBuilder CutStmts(List<NodeStmt> stmts, int pad = 0)
        {
            StringBuilder sb = new();
            string pp = "".PadLeft(pad, ' ');
            for (int i = 0; i < stmts.Count; i++)
            {
                NodeStmt stmt = stmts[i];
                switch (stmt.type)
                {
                    case NodeStmt.NodeStmtType.Declare:
                        sb.Append(pp);
                        if (stmt.declare.datatype == NodeStmtDataType.Auto)
                            sb.Append($"auto ");
                        else if (stmt.declare.datatype == NodeStmtDataType.Char)
                            sb.Append($"char ");
                        sb.Append($"{stmt.declare.ident.Value}");
                        if (stmt.declare.type == NodeStmtIdentifierType.SingleVar)
                        {
                            if (stmt.declare.singlevar.expr.type != NodeExpr.NodeExprType.None)
                            {
                                sb.Append($" = ");
                                sb.Append($"{CutExpr(stmt.declare.singlevar.expr)}");
                            }
                            sb.AppendLine($";");
                        }
                        else if (stmt.declare.type == NodeStmtIdentifierType.Array)
                        {
                            foreach (var dim in stmt.declare.array.Dimensions)
                                sb.Append($"[{dim}]");
                            sb.AppendLine($";");
                        }
                        break;
                    case NodeStmt.NodeStmtType.Assign:
                        sb.Append(pp);
                        if (stmt.assign.type == NodeStmtIdentifierType.SingleVar)
                        {
                            sb.Append($"{stmt.assign.singlevar.ident.Value}");
                            if (stmt.assign.singlevar.expr.type != NodeExpr.NodeExprType.None)
                            {
                                sb.Append($" = ");
                                sb.Append($"{CutExpr(stmt.assign.singlevar.expr)}");
                            }
                            sb.AppendLine($";");
                        }
                        else if (stmt.assign.type == NodeStmtIdentifierType.Array)
                        {
                            sb.Append($"{stmt.assign.array.ident.Value}");
                            foreach (var expr in stmt.assign.array.indexes)
                                sb.Append($"[{CutExpr(expr)}]");
                            sb.Append($" = ");
                            sb.Append($"{CutExpr(stmt.assign.array.expr)}");
                            sb.AppendLine($";");
                        }
                        break;
                    case NodeStmt.NodeStmtType.If:
                        sb.AppendLine($"{pp}if ({CutExpr(stmt.If.pred.cond)})");
                        sb.AppendLine($"{pp}{{");
                        sb.Append($"{CutStmts(stmt.If.pred.scope.stmts, pad + 4)}");
                        sb.AppendLine($"{pp}}}");
                        if (stmt.If.elifs.HasValue) sb.Append($"{CutElifs(stmt.If.elifs.Value, pad)}");
                        break;
                    case NodeStmt.NodeStmtType.For:
                        StringBuilder cond = stmt.For.pred.cond.HasValue ? CutExpr(stmt.For.pred.cond.Value.cond) : new();
                        //init
                        //udpate
                        sb.Append($"for (TODO;{cond};TODO)");
                        sb.AppendLine($"{pp}{{");
                        sb.Append($"{CutStmts(stmt.For.pred.scope.stmts, pad + 4)}");
                        sb.AppendLine($"{pp}}}");
                        break;
                    case NodeStmt.NodeStmtType.While:
                        sb.AppendLine($"{pp}while ({CutExpr(stmt.While.cond)})");
                        sb.AppendLine($"{pp}{{");
                        sb.Append($"{CutStmts(stmt.While.scope.stmts, pad + 4)}");
                        sb.AppendLine($"{pp}}}");
                        break;
                    case NodeStmt.NodeStmtType.Asm:
                        sb.AppendLine($"{pp}asm(\"{stmt.Asm.assembly.Value}\");");
                        break;
                    case NodeStmt.NodeStmtType.Scope:
                        sb.AppendLine($"{pp}{{");
                        sb.Append($"{CutStmts(stmt.Scope.stmts, pad + 4)}");
                        sb.AppendLine($"{pp}}}");
                        break;
                    case NodeStmt.NodeStmtType.Break:
                        sb.AppendLine($"{pp}break;");
                        break;
                    case NodeStmt.NodeStmtType.Continue:
                        sb.AppendLine($"{pp}continue;");
                        break;
                    case NodeStmt.NodeStmtType.Function:
                        sb.Append($"{pp}{stmt.CalledFunction.FunctionName.Value}");
                        sb.Append($"(");
                        for (int j = 0; j < stmt.CalledFunction.parameters.Count; j++)
                        {
                            sb.Append($"{CutExpr(stmt.CalledFunction.parameters[j])}");
                            if (j != stmt.CalledFunction.parameters.Count - 1) sb.Append(", ");
                        }
                        sb.AppendLine($");");
                        break;
                    case NodeStmt.NodeStmtType.Return:
                        sb.AppendLine($"{pp}return {CutExpr(stmt.Return.expr)};");
                        break;
                    case NodeStmt.NodeStmtType.Exit:
                        sb.AppendLine($"{pp}exit({CutExpr(stmt.Exit.expr)});");
                        break;
                    default:
                        Shartilities.UNREACHABLE("CutStmts");
                        return new();
                }
            }
            return sb;
        }
        static StringBuilder CutFunctionParameters(List<Var> vars)
        {
            StringBuilder sb = new();

            for (int i = 0; i < vars.Count; i++)
            {
                Var parameter = vars[i];
                if (parameter.ElementSize == 1) sb.Append($"char ");
                else if (parameter.ElementSize == 8) sb.Append($"auto ");
                //else Shartilities.Logln(Shartilities.LogType.ERROR, $"invalid ElementSize {parameter.ElementSize}", 1);

                sb.Append(parameter.Value);
                if (parameter.IsParameter && parameter.IsArray)
                    for (int j = 0; j < parameter.Dimensions.Count; j++)
                        sb.Append($"[]");



                if (i != vars.Count - 1) sb.Append($", ");
            }

            return sb;
        }
        static StringBuilder CutFunction(KeyValuePair<string, NodeStmtFunction> Function)
        {
            StringBuilder sb = new();
            string Name = Function.Key;
            List<Var> Parameters = Function.Value.parameters;
            NodeStmtScope FunctionBody = Function.Value.FunctionBody;

            sb.Append($"func {Name}(");
            sb.Append(CutFunctionParameters(Parameters));
            sb.AppendLine($")");
            sb.AppendLine($"{{");
            sb.Append(CutStmts(FunctionBody.stmts, 4));
            sb.AppendLine($"}}");

            return sb;
        }
        public static StringBuilder CutProgram(NodeProg Prog)
        {
            StringBuilder sb = new();

            sb.Append(CutStmts(Prog.GlobalScope.stmts));
            foreach (var func in Prog.UserDefinedFunctions)
                sb.AppendLine($"{CutFunction(func)}");

            return sb;
        }
    }
    internal sealed class Program
    {
        static StringBuilder Compile(string InputFilePath, bool Optimize)
        {
            string InputCode = Shartilities.ReadFile(InputFilePath);

            List<Token> TokenizedProgram = new Tokenizer(InputCode, InputFilePath).TokenizeProg();
            NodeProg ParsedProgram = new Parser(TokenizedProgram, InputFilePath).ParseProg();


            if (Optimize) Optimizer.OptimizeProgram(ref ParsedProgram);


            StringBuilder GeneratedProgram = Generator.GenProgram(ParsedProgram, InputFilePath);

            return GeneratedProgram;
        }
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

                //Shartilities.WriteFile(IM_MIF_filepath, LibUtils.GetIMMIF(p.MachineCodes, 32, 2048, 2).ToString(), false, 1);

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
                LibCPU.SingleCycle.Run(MC, DM, 4096, 4096, null);
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
