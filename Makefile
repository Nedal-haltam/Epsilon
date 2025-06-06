

all: build run

build:
	dotnet build

run:
	dotnet .\bin\Debug\net8.0\Epsilon.dll .\main.e
