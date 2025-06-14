

main: dummy
	riscv64-linux-gnu-gcc -o main main.S -static
	qemu-riscv64 ./main

examples: dummy
	riscv64-linux-gnu-gcc -o ./examples/GOL ./examples/GOL.S -static
	qemu-riscv64 ./examples/GOL
	riscv64-linux-gnu-gcc -o ./examples/rule110 ./examples/rule110.S -static
	qemu-riscv64 ./examples/rule110
	riscv64-linux-gnu-gcc -o ./examples/HelloWorld ./examples/HelloWorld.S -static
	qemu-riscv64 ./examples/HelloWorld
	riscv64-linux-gnu-gcc -o ./examples/Print10sMultipleAndLengths ./examples/Print10sMultipleAndLengths.S -static
	qemu-riscv64 ./examples/Print10sMultipleAndLengths
	riscv64-linux-gnu-gcc -o ./examples/ManipulateArrays ./examples/ManipulateArrays.S -static
	qemu-riscv64 ./examples/ManipulateArrays


dummy:

clean:
	rm -rf main.o
	rm -rf main