

main:
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\main.e -o ..\assembly\risc-v\main.S

examples: dummy
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\basic.e -o ..\assembly\risc-v\examples\basic.S
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\misc.e -o ..\assembly\risc-v\examples\misc.S
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\gol.e -o ..\assembly\risc-v\examples\gol.S

dummy:
