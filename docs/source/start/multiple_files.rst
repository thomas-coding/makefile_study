3、多个文件
==========================================

增加一个C文件 prog1.c，直接使用gcc方式编译：
::

   gcc prog1.c main.c
   gcc -o target prog1.o main.o

考虑写的更通用些，查找目录下所有C文件，编译成 .o， 再链接到一起

基于上一个例子修改如下：

.. code-block:: makefile
   :emphasize-lines: 17,18

	# ------------------------
	# Generic Makefile
	# ------------------------

	# Project name
	Target = target

	# Compile command and flag
	CC = gcc -c
	CFLAG = 

	# Linker command and flag
	LINKER = gcc -o
	LFLAG = 

	# Sources file
	SOURCES  := $(wildcard *.c)
	OBJECTS := $(SOURCES:.c=.o)

	$(Target) : $(OBJECTS)
		$(LINKER) $(Target) $(LFLAG) $(OBJECTS)
		@echo "Linking complete!"

	$(OBJECTS) : $(SOURCES)
		$(CC) $(CFLAG) $(SOURCES)
		@echo "Compilation complete!"

	PHONY: clean 
	clean :
		rm -rf target $(OBJECTS)
		@echo "Cleanup complete!"


.. note::
	wildcard用于查找目录下所有符合规则的文件，SOURCES:.c=.o 把SOURCES中 .c 名字换成 .o
