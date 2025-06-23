

EXAMPLES_SRC_PATH := ./examples/src
EXAMPLES_RISCV_ASSEMBLY := ./examples/risc-v
EXAMPLES_RISCV_BIN := ./examples/risc-v/bin

TESTS_SRC_PATH := ./tests/src
TESTS_RISCV_ASSEMBLY := ./tests/risc-v
TESTS_RISCV_BIN := ./tests/risc-v/bin

SAVED_OUTPUT_PATH := ./SavedOutput.txt

.PHONY:	all build-main run-main main \
		examples build-examples run-examples \
		tests build-tests run-tests \
		reset clean clean-examples clean-tests

all: reset tests examples
	@echo "✅ Built successfully."


build-main:
	dotnet ./bin/Debug/net8.0/Epsilon.dll ./main.e -o ./main.S

run-main: reset
	riscv64-linux-gnu-gcc -o ./main ./main.S -static
	@if [ "$(LOG_TO_FILE)" = "1" ]; then \
		script -q -a -c "qemu-riscv64 ./main" $(SAVED_OUTPUT_PATH);  \
	else \
		qemu-riscv64 ./main; \
	fi;

main: build-main run-main
	@echo "✅ Built main successfully."

EXAMPLES := GOL rule110 Fib ProjectEuler_001 ProjectEuler_002 ProjectEuler_003 ProjectEuler_004 ProjectEuler_005

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
		if [ "$(LOG_TO_FILE)" = "1" ]; then \
			script -q -a -c "qemu-riscv64 $(EXAMPLES_RISCV_BIN)/$$ex" $(SAVED_OUTPUT_PATH) || exit 1; \
		else \
			qemu-riscv64 $(EXAMPLES_RISCV_BIN)/$$ex || exit 1; \
		fi; \
	done

examples: build-examples run-examples


TESTS := HelloWorld Print10sMultipleAndLengths ManipulateArrays CharacterArrays misc

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
		if [ "$(LOG_TO_FILE)" = "1" ]; then \
			script -q -a -c "qemu-riscv64 $(TESTS_RISCV_BIN)/$$ex" $(SAVED_OUTPUT_PATH) || exit 1; \
		else \
			qemu-riscv64 $(TESTS_RISCV_BIN)/$$ex || exit 1; \
		fi; \
	done

tests: build-tests run-tests

clean-examples:
	@echo "🧹 Cleaning up examples"
	rm -rf $(EXAMPLES_RISCV_ASSEMBLY)
	mkdir $(EXAMPLES_RISCV_ASSEMBLY)
	mkdir $(EXAMPLES_RISCV_BIN)

clean-tests:
	@echo "🧹 Cleaning up tests"
	rm -rf $(TESTS_RISCV_ASSEMBLY)
	mkdir $(TESTS_RISCV_ASSEMBLY)
	mkdir $(TESTS_RISCV_BIN)

clean: clean-examples clean-tests
	@echo "🧹 Cleaning up all"

reset:
	rm -rf $(SAVED_OUTPUT_PATH)
	touch $(SAVED_OUTPUT_PATH)

diff-diff:
	rm -rf logs
	mkdir logs
	rm -rf ./SavedOutput2.txt
	touch ./SavedOutput2.txt
	make LOG_TO_FILE=1 SAVED_OUTPUT_PATH=./SavedOutput2.txt
	col -b < SavedOutput.txt > logs/SavedOutput.txt
	col -b < SavedOutput2.txt > logs/SavedOutput2.txt
	diff -a --suppress-common-lines --color=always logs/SavedOutput.txt logs/SavedOutput2.txt