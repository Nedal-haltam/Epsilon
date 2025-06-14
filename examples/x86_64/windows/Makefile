
build:
	nasm -f win64 main.S -o main.obj
	gcc main.obj -o main.exe -lkernel32

run:
	@powershell -Command "./main.exe; Write-Host -NoNewline 'Exit code: '; Write-Host $$LASTEXITCODE"
