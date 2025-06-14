

main:
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\main.e -o .\examples\risc-v\main.S

examples: dummy
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\HelloWorld.e -o .\examples\risc-v\examples\HelloWorld.S
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\Print10sMultipleAndLengths.e -o .\examples\risc-v\examples\Print10sMultipleAndLengths.S
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\GOL.e -o .\examples\risc-v\examples\GOL.S
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\rule110.e -o .\examples\risc-v\examples\rule110.S
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\ManipulateArrays.e -o .\examples\risc-v\examples\ManipulateArrays.S
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\examples\Fib.e -o .\examples\risc-v\examples\Fib.S

dummy:
