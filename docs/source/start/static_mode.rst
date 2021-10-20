四、静态模式
==========================================

静态模式更容易定义多目标规则，让规则定义变得更有弹性，更灵活

::

<targets ...>: <target-pattern>: <prereq-patterns ...> 
<commands> 

targets 定义了一系列的目标文件，target-parrtern 是指明了 targets 的模式，prereq-parrterns 是目标的依赖模式，它对 target-parrtern 形成的模式再进行一次依赖
目标的定义。


基于上一个例子修改如下：

.. code-block:: makefile
   :emphasize-lines: 24

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
	OBJECTS := $(SOURCES:%.c=%.o)

	$(Target) : $(OBJECTS)
		$(LINKER) $@ $(LFLAG) $(OBJECTS)
		@echo "Linking complete!"

	$(OBJECTS) : %.o : %.c
		$(CC) $(CFLAG) $<
		@echo "Compilation complete!"

	PHONY: clean 
	clean :
		rm -rf $(Target) $(OBJECTS)
		@echo "Cleanup complete!"



.. note::
	OBJECTS是指的 main.o、prog1.o ，目标规则 %.o ，取以.o 结尾的目标，这里是 main.o、prog1.o ，依赖规则 %c 取目标规则的 %，加上 .c 结尾，即 main.c、prog1.c 。

.. note::
	$< 表示依赖的集合，一个个取出来使用， 这里是 main.c、prog1.c。
	$@ 表示目标集合，一个个取出来使用， 这里只有一个 target。

执行结果：
::

	gcc -c  prog1.c
	Compilation complete!
	gcc -c  main.c
	Compilation complete!
	gcc -o target  prog1.o main.o
	Linking complete!

