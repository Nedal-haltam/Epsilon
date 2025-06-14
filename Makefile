

EXAMPLES_SRC_PATH=./examples/src
EXAMPLES_RISCV_OUTPUT_PATH=./examples/risc-v

TESTS_SRC_PATH=./tests/src
TESTS_RISCV_OUTPUT_PATH=./tests/risc-v

build-main:
	dotnet ./bin/Debug/net8.0/Epsilon.dll ./main.e -o ./main.S

run-main:
	riscv64-linux-gnu-gcc -o ./main ./main.S -static
	qemu-riscv64 ./main

main: build-main run-main

EXAMPLES := HelloWorld GOL rule110 Fib

build-examples: clean-examples
	@for ex in $(EXAMPLES); do \
		echo "Compiling $$ex.e..."; \
		dotnet ./bin/Debug/net8.0/Epsilon.dll $(EXAMPLES_SRC_PATH)/$$ex.e -o $(EXAMPLES_RISCV_OUTPUT_PATH)/$$ex.S || exit 1; \
	done

run-examples:
	@for ex in $(EXAMPLES); do \
		echo "Building and running $$ex..."; \
		riscv64-linux-gnu-gcc -o $(EXAMPLES_RISCV_OUTPUT_PATH)/$$ex $(EXAMPLES_RISCV_OUTPUT_PATH)/$$ex.S -static || exit 1; \
		qemu-riscv64 $(EXAMPLES_RISCV_OUTPUT_PATH)/$$ex || exit 1; \
	done

examples: build-examples run-examples


TESTS := Print10sMultipleAndLengths ManipulateArrays

build-tests: clean-tests
	@for ex in $(TESTS); do \
		echo "Compiling $$ex.e..."; \
		dotnet ./bin/Debug/net8.0/Epsilon.dll $(TESTS_SRC_PATH)/$$ex.e -o $(TESTS_RISCV_OUTPUT_PATH)/$$ex.S || exit 1; \
	done

run-tests:
	@for ex in $(TESTS); do \
		echo "Building and running $$ex..."; \
		riscv64-linux-gnu-gcc -o $(TESTS_RISCV_OUTPUT_PATH)/$$ex $(TESTS_RISCV_OUTPUT_PATH)/$$ex.S -static || exit 1; \
		qemu-riscv64 $(TESTS_RISCV_OUTPUT_PATH)/$$ex || exit 1; \
	done

tests: build-tests run-tests

clean-examples:
	rm -rf $(EXAMPLES_RISCV_OUTPUT_PATH)
	mkdir $(EXAMPLES_RISCV_OUTPUT_PATH)

clean-tests:
	rm -rf $(TESTS_RISCV_OUTPUT_PATH)
	mkdir $(TESTS_RISCV_OUTPUT_PATH)

clean: clean-examples clean-tests
