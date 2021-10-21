==========================================
6、实现baremetal编译
==========================================

最终希望的 baremetal 目录应包括src、obj、output，其中src目录下源码和头文件可以随意放置。如下：

::

	├── Makefile
	├── obj
	│   ├── board
	│   │   └── prog1.o
	│   ├── common
	│   │   └── prog2.o
	│   └── main.o
	├── output
	│   └── target
	├── README.md
	└── src
		├── board
		│   ├── prog1.c
		│   └── prog1.h
		├── common
		│   ├── prog2.c
		│   └── prog2.h
		└── main.c

Makefile需要实现自动找到所有的 .c文件，编译成 .o 文件，并最后链接生成 binary 放入 output。这样可以在任意目录增加 c文件或者头文件，都会被编译进去。

基于上一个例子修改如下：

.. code-block:: makefile

	# ------------------------
	# Generic Makefile
	# ------------------------

	# Project name
	Target = target

	# Compile command and flag
	CC = gcc
	CFLAG = -Wall

	# Linker command and flag
	LINKER = gcc
	LFLAG = 

	# Dir
	SRC_DIR = src
	OBJ_DIR = obj
	BIN_DIR = output

	# Source directorys, find all source directory ,like src/board src/common
	SRC_DIRS	= $(shell find src -maxdepth 3 -type d)

	# OBJ_DIRS, change src to obj, match the source directorys, like obj/board obj/common
	OBJ_DIRS	:= $(foreach dir,$(SRC_DIRS),$(subst src,obj,$(dir)))

	# INCLUDES, add source directorys to include, like -Isrc/board -Isrc/common
	INCLUDES	= $(foreach dir, $(SRC_DIRS),-I$(dir))

	# Source files, c srouce files and asmeble source files. like src/board/test.c src/board/test.S
	C_SRC	+= $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.c))
	S_SRC	:= $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.S))

	# OBJ files, object files. like obj/board/test.o obj/board/test.o
	OBJ_S_FILES	:= $(foreach file,$(S_SRC),$(patsubst %.S,%.o,$(subst src,obj,$(file))))
	OBJ_C_FILES	:= $(foreach file,$(C_SRC),$(patsubst %.c,%.o,$(subst src,obj,$(file))))
	OBJ_FILES	:= $(OBJ_S_FILES) $(OBJ_C_FILES)

	# 1. Create obj directorys and bin directory
	# 2. Comple all OBJ_FILES, from .c .S to .o
	# 3. Link all .o to binary target
	$(BIN_DIR)/$(Target) : $(OBJ_DIRS) $(BIN_DIR) $(OBJ_FILES)
		$(LINKER) -o $@ $(LFLAG) $(OBJ_FILES)
		@echo "Linking complete!"

	# Compile .c to .o
	obj/%.o : src/%.c
		@echo Compiling $< to $@
		$(CC) $(CFLAG) $(INCLUDES) -c $< -o $@


	PHONY: clean 
	clean :
		rm -rf $(BIN_DIR) $(OBJ_DIR)
		@echo "Cleanup complete!"

	$(OBJ_DIRS):
		mkdir -p $@

	$(BIN_DIR):
		mkdir -p $@



.. note::
	大部分都通过注释说明了，其中有几个makefile专有命令说明下 。

::

	$(foreach <var>,<list>,<text>) 

	names := a b c d
	files := $(foreach n,$(names),$(n).o) 

	$(files)的值是“a.o b.o c.o d.o”

::

	$(subst <from>,<to>,<text>) 
	把text中的from 替换为 to

	$(subst ee,EE,feet on the street)， 
	“fEEt on the strEEt”

::

	$(patsubst %.c,%.o,x.c.c bar.c)
	把字串“x.c.c bar.c”符合模式[%.c]的单词替换成[%.o]，返回结果是“x.c.o bar.o”