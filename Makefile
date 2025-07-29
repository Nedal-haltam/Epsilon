

EXAMPLES_SRC_PATH := ./examples/src
EXAMPLES_BUILD_FOLDER := ./examples/risc-v


TESTS_SRC_PATH := ./tests/src
TESTS_BUILD_FOLDER := ./tests/risc-v

QEMU_SAVED_OUTPUT_PATH := ./QemuRecordedOutput.txt
SIMU_SAVED_OUTPUT_PATH := ./SimuRecordedOutput.txt

EXAMPLES := GOL rule110 Fib ProjectEuler_001 ProjectEuler_002 ProjectEuler_003 # ProjectEuler_004 ProjectEuler_005
TESTS := HelloWorld Print10sMultipleAndLengths ManipulateArrays CharacterArrays misc PrintNumbers Globals ForLoops ReturnFromFuncs InlineAsm

.PHONY:	all run sim main run-examples run-tests sim-examples sim-tests record-log diff-diff clean-examples clean-tests clean

all: run sim
	@echo "✅ All tasks completed successfully."

run: run-tests run-examples
	@echo "✅ Ran successfully."

sim: sim-tests sim-examples
	@echo "✅ Simulated successfully."

main:
	dotnet ./bin/Debug/net8.0/Epsilon.dll -run ./main/main.e -o ./main/main
	@echo "✅ Built main successfully."

run-examples: clean-examples
	@for ex in $(EXAMPLES); do \
		echo "-------------------------------------------------------------------"; \
		echo "Running $$ex..."; \
		if [ "$(LOG)" = "1" ]; then \
			dotnet ./bin/Debug/net8.0/Epsilon.dll -run $(EXAMPLES_SRC_PATH)/$$ex.e -o $(EXAMPLES_BUILD_FOLDER)/$$ex -dump | col -b | sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" >> $(QEMU_SAVED_OUTPUT_PATH) 2>&1 || exit 1; \
		else \
			dotnet ./bin/Debug/net8.0/Epsilon.dll -run $(EXAMPLES_SRC_PATH)/$$ex.e -o $(EXAMPLES_BUILD_FOLDER)/$$ex -dump || exit 1; \
		fi; \
	done

run-tests: clean-tests
	@for ex in $(TESTS); do \
		echo "-------------------------------------------------------------------"; \
		echo "Running $$ex..."; \
		if [ "$(LOG)" = "1" ]; then \
			dotnet ./bin/Debug/net8.0/Epsilon.dll -run $(TESTS_SRC_PATH)/$$ex.e -o $(TESTS_BUILD_FOLDER)/$$ex -dump | col -b | sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" >> $(QEMU_SAVED_OUTPUT_PATH) 2>&1 || exit 1; \
		else \
			dotnet ./bin/Debug/net8.0/Epsilon.dll -run $(TESTS_SRC_PATH)/$$ex.e -o $(TESTS_BUILD_FOLDER)/$$ex -dump || exit 1; \
		fi; \
	done

sim-examples: clean-examples
	@for ex in $(EXAMPLES); do \
		echo "-------------------------------------------------------------------"; \
		echo "Simulating $$ex..."; \
		if [ "$(LOG)" = "1" ]; then \
			dotnet ./bin/Debug/net8.0/Epsilon.dll -sim $(EXAMPLES_SRC_PATH)/$$ex.e -o $(EXAMPLES_BUILD_FOLDER)/$$ex -dump | col -b | sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" >> $(SIMU_SAVED_OUTPUT_PATH) 2>&1 || exit 1; \
		else \
			dotnet ./bin/Debug/net8.0/Epsilon.dll -sim $(EXAMPLES_SRC_PATH)/$$ex.e -o $(EXAMPLES_BUILD_FOLDER)/$$ex -dump || exit 1; \
		fi; \
	done

sim-tests: clean-tests
	@for ex in $(TESTS); do \
		echo "-------------------------------------------------------------------"; \
		echo "Simulating $$ex..."; \
		if [ "$(LOG)" = "1" ]; then \
			dotnet ./bin/Debug/net8.0/Epsilon.dll -sim $(TESTS_SRC_PATH)/$$ex.e -o $(TESTS_BUILD_FOLDER)/$$ex -dump | col -b | sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" >> $(SIMU_SAVED_OUTPUT_PATH) 2>&1 || exit 1; \
		else \
			dotnet ./bin/Debug/net8.0/Epsilon.dll -sim $(TESTS_SRC_PATH)/$$ex.e -o $(TESTS_BUILD_FOLDER)/$$ex -dump || exit 1; \
		fi; \
	done

record-log:
	@rm -rf $(QEMU_SAVED_OUTPUT_PATH)
	@touch $(QEMU_SAVED_OUTPUT_PATH)
	@rm -rf $(SIMU_SAVED_OUTPUT_PATH)
	@touch $(SIMU_SAVED_OUTPUT_PATH)
	$(MAKE) LOG=1

diff-diff:
	@rm -rf temp-logs
	@mkdir temp-logs
	@rm -rf ./QemuRecordedOutput2.txt
	@touch ./QemuRecordedOutput2.txt
	@rm -rf ./SimuRecordedOutput2.txt
	@touch ./SimuRecordedOutput2.txt
	@make LOG=1 QEMU_SAVED_OUTPUT_PATH=./QemuRecordedOutput2.txt SIMU_SAVED_OUTPUT_PATH=./SimuRecordedOutput2.txt
	@sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" ./QemuRecordedOutput2.txt | col -b > ./temp-logs/QemuRecordedOutput2.txt
	@sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" ./SimuRecordedOutput2.txt | col -b > ./temp-logs/SimuRecordedOutput2.txt
	@sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" $(QEMU_SAVED_OUTPUT_PATH) | col -b > temp-logs/QemuRecordedOutput.txt
	@sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" $(SIMU_SAVED_OUTPUT_PATH) | col -b > temp-logs/SimuRecordedOutput.txt
	@diff -as --suppress-common-lines --color=always ./temp-logs/QemuRecordedOutput.txt ./temp-logs/QemuRecordedOutput2.txt
	@diff -as --suppress-common-lines --color=always ./temp-logs/SimuRecordedOutput.txt ./temp-logs/SimuRecordedOutput2.txt
	@rm -rf ./QemuRecordedOutput2.txt
	@rm -rf ./SimuRecordedOutput2.txt
	@rm -rf temp-logs

clean-examples:
	@echo "🧹 Cleaning up examples"
	@rm -rf $(EXAMPLES_BUILD_FOLDER)
	@mkdir $(EXAMPLES_BUILD_FOLDER)

clean-tests:
	@echo "🧹 Cleaning up tests"
	@rm -rf $(TESTS_BUILD_FOLDER)
	@mkdir $(TESTS_BUILD_FOLDER)

clean: clean-examples clean-tests
	@echo "🧹 Cleaning up all"
