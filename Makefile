

EXAMPLES_SRC_PATH := ./examples/src
EXAMPLES_RISCV_ASSEMBLY := ./examples/risc-v
EXAMPLES_RISCV_BIN := ./examples/risc-v/bin

TESTS_SRC_PATH := ./tests/src
TESTS_RISCV_ASSEMBLY := ./tests/risc-v
TESTS_RISCV_BIN := ./tests/risc-v/bin

SAVED_OUTPUT_PATH := ./SavedOutput.txt

EXAMPLES := GOL rule110 Fib ProjectEuler_001 ProjectEuler_002 ProjectEuler_003 ProjectEuler_004 ProjectEuler_005
TESTS := HelloWorld Print10sMultipleAndLengths ManipulateArrays CharacterArrays misc PrintNumbers

.PHONY:	all main compile-examples assemble-examples run-examples examples \
		compile-tests assemble-tests run-tests tests clean-examples clean-tests clean record-log diff-diff

all: tests examples
	@echo "✅ Built successfully."

main:
	dotnet ./bin/Debug/net8.0/Epsilon.dll ./main.e -o ./main.S
	riscv64-linux-gnu-gcc -o ./main ./main.S -static
	qemu-riscv64 ./main
	@echo "✅ Built main successfully."

compile-examples: clean-examples
	@for ex in $(EXAMPLES); do \
		echo "Compiling $$ex.e..."; \
		dotnet ./bin/Debug/net8.0/Epsilon.dll $(EXAMPLES_SRC_PATH)/$$ex.e -o $(EXAMPLES_RISCV_ASSEMBLY)/$$ex.S || exit 1; \
	done

assemble-examples:
	@for ex in $(EXAMPLES); do \
		echo "Assembling $$ex..."; \
		riscv64-linux-gnu-gcc -o $(EXAMPLES_RISCV_BIN)/$$ex $(EXAMPLES_RISCV_ASSEMBLY)/$$ex.S -static || exit 1; \
	done

run-examples:
	@for ex in $(EXAMPLES); do \
		echo "-------------------------------------------------------------------"; \
		echo "Running $$ex..."; \
		if [ "$(LOG)" = "1" ]; then \
			script -q -a -c "qemu-riscv64 $(EXAMPLES_RISCV_BIN)/$$ex" /dev/null | col -b >> $(SAVED_OUTPUT_PATH) 2>&1 || exit 1; \
		else \
			qemu-riscv64 $(EXAMPLES_RISCV_BIN)/$$ex || exit 1; \
		fi; \
	done

examples: compile-examples assemble-examples run-examples


compile-tests: clean-tests
	@for ex in $(TESTS); do \
		echo "Compiling $$ex.e..."; \
		dotnet ./bin/Debug/net8.0/Epsilon.dll $(TESTS_SRC_PATH)/$$ex.e -o $(TESTS_RISCV_ASSEMBLY)/$$ex.S || exit 1; \
	done

assemble-tests:
	@for ex in $(TESTS); do \
		echo "Assembling $$ex..."; \
		riscv64-linux-gnu-gcc -o $(TESTS_RISCV_BIN)/$$ex $(TESTS_RISCV_ASSEMBLY)/$$ex.S -static || exit 1; \
	done

run-tests:
	@for ex in $(TESTS); do \
		echo "-------------------------------------------------------------------"; \
		echo "Running $$ex..."; \
		if [ "$(LOG)" = "1" ]; then \
			script -q -a -c "qemu-riscv64 $(TESTS_RISCV_BIN)/$$ex" /dev/null | col -b >> $(SAVED_OUTPUT_PATH) 2>&1 || exit 1; \
		else \
			qemu-riscv64 $(TESTS_RISCV_BIN)/$$ex || exit 1; \
		fi; \
	done

tests: compile-tests assemble-tests run-tests

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

record-log:
	@rm -rf $(SAVED_OUTPUT_PATH)
	@touch $(SAVED_OUTPUT_PATH)
	$(MAKE) LOG=1 SAVED_OUTPUT_PATH=$(SAVED_OUTPUT_PATH)

diff-diff:
	rm -rf logs
	mkdir logs
	rm -rf ./SavedOutput2.txt
	touch ./SavedOutput2.txt
	make LOG=1 SAVED_OUTPUT_PATH=./SavedOutput2.txt
	col -b < $(SAVED_OUTPUT_PATH) > logs/SavedOutput.txt
	col -b < SavedOutput2.txt > logs/SavedOutput2.txt
	diff -as --suppress-common-lines --color=always logs/SavedOutput.txt logs/SavedOutput2.txt