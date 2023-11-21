include libs.mk

LIB_DIR := -I/opt/homebrew/include

# Define source and destination directories
BUILD_DIR := build
SRC_DIR := src
# Define asset folder
ASSETS_DIR := assets
ASSETS_BUILD_DIR := $(BUILD_DIR)/assets

# Compiler and flags
CXX := g++
CXXFLAGS := $(LIB_DIR) -std=c++17 # macOS: other macOS-option is /usr/local/include

# Define the rsync command
RSYNC := rsync -ru

# List of files to copy (you can specify file patterns or individual files)
FILES_TO_COPY := $(wildcard $(ASSETS_DIR)/*)

# Target to copy new or modified files
copy_assets:
	mkdir -p $(ASSETS_BUILD_DIR)
	$(RSYNC) $(FILES_TO_COPY) $(ASSETS_BUILD_DIR)

# Define the default target (all) and its dependencies
all: build

# Pattern rule to build C++ source files
build/%: src/%.cpp
	$(CXX) $(CXXFLAGS) $^ $(LIB_FLAGS) $(foreach dep,$(deps), $(dep)) -o $@

# Pattern rule to compile object files
build/%.o: src/%.cpp src/%.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean target
clean:
	rm -f $(BUILD_DIR)/*

# Run target
run:
	@if [ -z "$(file)" ]; then \
		echo "Usage: make run file=<source_file> deps=<comma-separated-dependencies>"; \
	else \
		make copy_assets; \
		src=$(SRC_DIR)/$(basename $(notdir $(file))); \
		target=$(BUILD_DIR)/$(basename $(notdir $(file))); \
		dep_list="$(deps)"; \
		args=$(filter-out $<,$(filter-out $@,$(MAKECMDGOALS))); \
		IFS=',' read -ra dep_array <<< "$$dep_list"; \
		dep_objects=""; \
		for dep in $${dep_array[@]}; do \
			if [ ! -f $(BUILD_DIR)/$$dep.o ]; then \
				make build/$$dep; \
			fi; \
			dep_objects+=" $(BUILD_DIR)/$$dep.o"; \
		done; \
		make $$target deps="$$dep_objects"; \
		$$target $$args; \
	fi

# Ignore "clean" and "run" when running other make targets
%: build/%.cpp
	@:
