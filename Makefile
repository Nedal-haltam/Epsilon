

main:
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\main.e -o ..\assembly\risc-v\main.S

examples: dummy
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\HelloWorld.e -o ..\assembly\risc-v\examples\HelloWorld.S
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\Print10sMultipleAndLengths.e -o ..\assembly\risc-v\examples\Print10sMultipleAndLengths.S
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\GOL.e -o ..\assembly\risc-v\examples\GOL.S
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\rule110.e -o ..\assembly\risc-v\examples\rule110.S

dummy:
