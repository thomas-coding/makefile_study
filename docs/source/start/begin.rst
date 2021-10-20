让我们开始吧
==========================================

一个最简单的例子
-------------------------------------------

如果我们只有一个文件，那么可以直接使用gcc命令编译：

::

   gcc -c main.c #对c文件进行汇编，生成 .o 文件
   gcc -o target main.o 

我们把上面两条命令改成使用 Makefile 来实现：

::

	# ------------------------
	# Generic Makefile
	# ------------------------

	target : main.o
		gcc -o target main.o 

	main.o : main.c
		gcc -c main.c

	clean :
		rm target main.o


这是我们第一次看到 Makefile, 稍微做说明。

::
	target ... : prerequisites ... 
		command 

基本语法，第一行是目标，：后面跟依赖关系，即生成这个目录需要哪些东西预先准备好。
第二行是命令，执行这条命令可以用依赖关系生成目标。

比如我们这里目标main.o，要生成main.o ,首先需要有main.c，然后执行命令 gcc -c main.c，即可生成我们的目标 main.o，
target是我们的最终binary文件，这个文件是链接所有的.o文件生成的（当前只有一个 main.o），依赖所有 .o，执行链接命令。

接下来执行 make 就能直接生成 target 这个binary文件了。

make 是如何工作的？
-----------------------------------
 | 1、make会在当前目录下查找 Makefile 或者 makefile。
 | 2、如果找到，会在文件中找第一个目录，我们上面例子中的 target。
 | 3、接下来查看依赖， main.o ，进一步查找依赖 main.c ,先编译出 main.o, 再编译出 target。

.. note::
 像 clean 这样的目标，不是这个文件中第一个目标，也没有被其他人依赖。所以执行 make 时候不会被执行。需要显示的指定目标来执行它对应的命令： make clean。

