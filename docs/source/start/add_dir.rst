5、目录分离
==========================================

大部分的工程需要分离src、obj、bin，如下：

::

	./
	./Makefile
	./src/*.c;*.h
	./obj/*.o
	./bin/<executable>

基于上一个例子修改如下：

.. code-block:: makefile

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

	$(BIN_DIR)/$(Target) : $(OBJECTS)
		$(LINKER) -o $@ $(LFLAG) $(OBJECTS)
		@echo "Linking complete!"

	$(OBJECTS) : $(OBJ_DIR)/%.o : $(SRC_DIR)/%.c
		$(CC) $(CFLAG) -c $< -o $@
		@echo "Compilation complete!"

	PHONY: clean 
	clean :
		rm -rf $(BIN_DIR)/$(Target) $(OBJECTS)
		@echo "Cleanup complete!"




.. note::
	基本上只是单纯的定义目录，然后目标文件放到对应目录 。

