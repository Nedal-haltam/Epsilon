

EXAMPLES_SRC_PATH=./examples/src
EXAMPLES_RISCV_ASSEMBLY=./examples/risc-v
EXAMPLES_RISCV_BIN=./examples/risc-v/bin

TESTS_SRC_PATH=./tests/src
TESTS_RISCV_ASSEMBLY=./tests/risc-v
TESTS_RISCV_BIN=./tests/risc-v/bin

all: main tests examples
	echo "finihshed all"


build-main:
	dotnet ./bin/Debug/net8.0/Epsilon.dll ./main.e -o ./main.S

run-main:
	riscv64-linux-gnu-gcc -o ./main ./main.S -static
	qemu-riscv64 ./main

main: build-main run-main
	echo "finihshed main"

EXAMPLES := HelloWorld GOL rule110 Fib ProjectEuler_001 ProjectEuler_002 ProjectEuler_003

build-examples: clean-examples
	@for ex in $(EXAMPLES); do \
		echo "Compiling $$ex.e..."; \
		dotnet ./bin/Debug/net8.0/Epsilon.dll $(EXAMPLES_SRC_PATH)/$$ex.e -o $(EXAMPLES_RISCV_ASSEMBLY)/$$ex.S || exit 1; \
	done

run-examples:
	@for ex in $(EXAMPLES); do \
		echo "-------------------------------------------------------------------"; \
		echo "Building and running $$ex..."; \
		riscv64-linux-gnu-gcc -o $(EXAMPLES_RISCV_BIN)/$$ex $(EXAMPLES_RISCV_ASSEMBLY)/$$ex.S -static || exit 1; \
		qemu-riscv64 $(EXAMPLES_RISCV_BIN)/$$ex || exit 1; \
	done

examples: build-examples run-examples


TESTS := Print10sMultipleAndLengths ManipulateArrays

build-tests: clean-tests
	@for ex in $(TESTS); do \
		echo "Compiling $$ex.e..."; \
		dotnet ./bin/Debug/net8.0/Epsilon.dll $(TESTS_SRC_PATH)/$$ex.e -o $(TESTS_RISCV_ASSEMBLY)/$$ex.S || exit 1; \
	done

run-tests:
	@for ex in $(TESTS); do \
		echo "-------------------------------------------------------------------"; \
		echo "Building and running $$ex..."; \
		riscv64-linux-gnu-gcc -o $(TESTS_RISCV_BIN)/$$ex $(TESTS_RISCV_ASSEMBLY)/$$ex.S -static || exit 1; \
		qemu-riscv64 $(TESTS_RISCV_BIN)/$$ex || exit 1; \
	done

tests: build-tests run-tests

clean-examples:
	rm -rf $(EXAMPLES_RISCV_ASSEMBLY)
	mkdir $(EXAMPLES_RISCV_ASSEMBLY)
	mkdir $(EXAMPLES_RISCV_BIN)

clean-tests:
	rm -rf $(TESTS_RISCV_ASSEMBLY)
	mkdir $(TESTS_RISCV_ASSEMBLY)
	mkdir $(TESTS_RISCV_BIN)

clean: clean-examples clean-tests
