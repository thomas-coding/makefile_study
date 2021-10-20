# ------------------------
# Generic Makefile
# ------------------------

# Project name
Target = target

# Compile command and flag
CC = gcc
CFLAG = 

# Linker command and flag
LINKER = gcc
LFLAG = 

# Dir
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin


# Source files
SOURCES  := $(wildcard $(SRC_DIR)/*.c)

# OBJECT files
OBJECTS := $(SOURCES:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

# Header files
INCLUDES := $(wildcard $(SRC_DIR)/*.h)

$(BIN_DIR)/$(Target) : $(OBJ_DIR) $(BIN_DIR) $(OBJECTS)
	$(LINKER) -o $@ $(LFLAG) $(OBJECTS)
	@echo "Linking complete!"

$(OBJECTS) : $(OBJ_DIR)/%.o : $(SRC_DIR)/%.c
	$(CC) $(CFLAG) -c $< -o $@
	@echo "Compilation complete!"

PHONY: clean 
clean :
	rm -rf $(BIN_DIR) $(OBJ_DIR)
	@echo "Cleanup complete!"

$(OBJ_DIR):
	mkdir -p $@

$(BIN_DIR):
	mkdir -p $@