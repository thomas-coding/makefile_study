2、变量和打印
==========================================

基于上一个例子，部分内容使用变量来替换

.. code-block:: makefile
   :emphasize-lines: 6,9,13

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

	$(Target) : main.o
		$(LINKER) $(Target) main.o
		@echo "Linking complete!"

	main.o : main.c
		$(CC) main.c
		@echo "Compilation complete!"

	clean :
		rm -rf target main.o
		@echo "Cleanup complete!"

定义了变量 Target、CC、LINKER，相应的地方用这些变量替换，echo用于输出，@表示命令本身不打印
