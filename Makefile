

EXAMPLES_SRC_PATH := ./examples/src
EXAMPLES_BUILD_FOLDER := ./examples/risc-v


TESTS_SRC_PATH := ./tests/src
TESTS_BUILD_FOLDER := ./tests/risc-v

QEMU_SAVED_OUTPUT_PATH := ./QemuRecordedOutput.txt
SIMU_SAVED_OUTPUT_PATH := ./SimuRecordedOutput.txt

EXAMPLES := GOL rule110 Fib ProjectEuler_001 ProjectEuler_002 ProjectEuler_003 mandelbrot fizzbuzz donut
TESTS := HelloWorld Print10sMultipleAndLengths ManipulateArrays CharacterArrays misc PrintNumbers Globals ForLoops ReturnFromFuncs InlineAsm print variadics ClArgs

.PHONY: all clean clean-examples clean-tests run-all sim-all main record-log diff-diff

all: clean run-all sim-all
	@echo "✅ All tasks completed successfully."

main:
	dotnet ./bin/Debug/net8.0/Epsilon.dll -run ./main/main.e -o ./main/build/main -dump
	@echo "✅ Built main successfully."


record-log:
	@rm -rf $(QEMU_SAVED_OUTPUT_PATH)
	@touch $(QEMU_SAVED_OUTPUT_PATH)
	@rm -rf $(SIMU_SAVED_OUTPUT_PATH)
	@touch $(SIMU_SAVED_OUTPUT_PATH)
	$(MAKE) LOG=1

diff-diff:
	@rm -rf temp-logs
	@mkdir -p temp-logs
	@rm -rf ./QemuRecordedOutput2.txt
	@touch ./QemuRecordedOutput2.txt
	@rm -rf ./SimuRecordedOutput2.txt
	@touch ./SimuRecordedOutput2.txt
	@$(MAKE) LOG=1 QEMU_SAVED_OUTPUT_PATH=./QemuRecordedOutput2.txt SIMU_SAVED_OUTPUT_PATH=./SimuRecordedOutput2.txt
	@sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" ./QemuRecordedOutput2.txt | col -b > ./temp-logs/QemuRecordedOutput2.txt
	@sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" ./SimuRecordedOutput2.txt | col -b > ./temp-logs/SimuRecordedOutput2.txt
	@sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" $(QEMU_SAVED_OUTPUT_PATH) | col -b > ./temp-logs/QemuRecordedOutput.txt
	@sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" $(SIMU_SAVED_OUTPUT_PATH) | col -b > ./temp-logs/SimuRecordedOutput.txt
	@diff -as --suppress-common-lines --color=always ./temp-logs/QemuRecordedOutput.txt ./temp-logs/QemuRecordedOutput2.txt
	@diff -as --suppress-common-lines --color=always ./temp-logs/SimuRecordedOutput.txt ./temp-logs/SimuRecordedOutput2.txt
# 	@diff -as --suppress-common-lines --color=always ./temp-logs/QemuRecordedOutput.txt ./temp-logs/SimuRecordedOutput.txt
	@rm -rf ./QemuRecordedOutput2.txt
	@rm -rf ./SimuRecordedOutput2.txt
	@rm -rf temp-logs

clean-examples:
	@rm -rf $(EXAMPLES_BUILD_FOLDER)
	@mkdir -p $(EXAMPLES_BUILD_FOLDER)
	@echo "🧹 Cleaned up examples"

clean-tests:
	@rm -rf $(TESTS_BUILD_FOLDER)
	@mkdir -p $(TESTS_BUILD_FOLDER)
	@echo "🧹 Cleaned up tests"

clean: clean-examples clean-tests
	@echo "🧹 Cleaned up all"


run-all:
	@echo "🚀 Running all examples and tests..."
	@{ \
		for ex in $(EXAMPLES); do \
			if [ "$(LOG)" = "1" ]; then \
				rm -rf $(EXAMPLES_BUILD_FOLDER)/run_$$ex.txt; \
				dotnet ./bin/Debug/net8.0/Epsilon.dll \
					-o $(EXAMPLES_BUILD_FOLDER)/$$ex -dump \
					-run $(EXAMPLES_SRC_PATH)/$$ex.e \
					| col -b | sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" \
					>> $(EXAMPLES_BUILD_FOLDER)/run_$$ex.txt 2>&1 || exit 1; \
			else \
				dotnet ./bin/Debug/net8.0/Epsilon.dll \
					-o $(EXAMPLES_BUILD_FOLDER)/$$ex -dump \
					-run $(EXAMPLES_SRC_PATH)/$$ex.e || exit 1; \
			fi & \
		done; \
		for ex in $(TESTS); do \
			if [ "$(LOG)" = "1" ]; then \
				rm -rf $(TESTS_BUILD_FOLDER)/run_$$ex.txt; \
				dotnet ./bin/Debug/net8.0/Epsilon.dll \
					-o $(TESTS_BUILD_FOLDER)/$$ex -dump \
					-run $(TESTS_SRC_PATH)/$$ex.e \
					| col -b | sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" \
					>> $(TESTS_BUILD_FOLDER)/run_$$ex.txt 2>&1 || exit 1; \
			else \
				dotnet ./bin/Debug/net8.0/Epsilon.dll \
					-o $(TESTS_BUILD_FOLDER)/$$ex -dump \
					-run $(TESTS_SRC_PATH)/$$ex.e || exit 1; \
			fi & \
		done; \
		wait; \
	}
	@rm -f $(QEMU_SAVED_OUTPUT_PATH)
	@for ex in $(TESTS); do \
		if [ -f $(TESTS_BUILD_FOLDER)/run_$$ex.txt ]; then \
			cat $(TESTS_BUILD_FOLDER)/run_$$ex.txt >> $(QEMU_SAVED_OUTPUT_PATH); \
		fi; \
	done
	@for ex in $(EXAMPLES); do \
		if [ -f $(EXAMPLES_BUILD_FOLDER)/run_$$ex.txt ]; then \
			cat $(EXAMPLES_BUILD_FOLDER)/run_$$ex.txt >> $(QEMU_SAVED_OUTPUT_PATH); \
		fi; \
	done

sim-all:
	@echo "🚀 Simulating all examples and tests..."
	@{ \
		for ex in $(EXAMPLES); do \
			if [ "$$ex" = "donut" ]; then \
				continue; \
			fi; \
			if [ "$(LOG)" = "1" ]; then \
				rm -rf $(EXAMPLES_BUILD_FOLDER)/sim_$$ex.txt; \
				dotnet ./bin/Debug/net8.0/Epsilon.dll \
					-o $(EXAMPLES_BUILD_FOLDER)/$$ex -dump \
					-sim $(EXAMPLES_SRC_PATH)/$$ex.e \
					| col -b | sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" \
					>> $(EXAMPLES_BUILD_FOLDER)/sim_$$ex.txt 2>&1 || exit 1; \
			else \
				dotnet ./bin/Debug/net8.0/Epsilon.dll \
					-o $(EXAMPLES_BUILD_FOLDER)/$$ex -dump \
					-sim $(EXAMPLES_SRC_PATH)/$$ex.e || exit 1; \
			fi & \
		done; \
		for ex in $(TESTS); do \
			if [ "$(LOG)" = "1" ]; then \
				rm -rf $(TESTS_BUILD_FOLDER)/sim_$$ex.txt; \
				dotnet ./bin/Debug/net8.0/Epsilon.dll \
					-o $(TESTS_BUILD_FOLDER)/$$ex -dump \
					-sim $(TESTS_SRC_PATH)/$$ex.e \
					| col -b | sed -r "s/\x1B\[[0-9;?]*[a-zA-Z]//g" \
					>> $(TESTS_BUILD_FOLDER)/sim_$$ex.txt 2>&1 || exit 1; \
			else \
				dotnet ./bin/Debug/net8.0/Epsilon.dll \
					-o $(TESTS_BUILD_FOLDER)/$$ex -dump \
					-sim $(TESTS_SRC_PATH)/$$ex.e || exit 1; \
			fi & \
		done; \
		wait; \
	}
	@rm -f $(SIMU_SAVED_OUTPUT_PATH)
	@for ex in $(TESTS); do \
		if [ -f $(TESTS_BUILD_FOLDER)/sim_$$ex.txt ]; then \
			cat $(TESTS_BUILD_FOLDER)/sim_$$ex.txt >> $(SIMU_SAVED_OUTPUT_PATH); \
		fi; \
	done
	@for ex in $(EXAMPLES); do \
		if [ -f $(EXAMPLES_BUILD_FOLDER)/sim_$$ex.txt ]; then \
			cat $(EXAMPLES_BUILD_FOLDER)/sim_$$ex.txt >> $(SIMU_SAVED_OUTPUT_PATH); \
		fi; \
	done
