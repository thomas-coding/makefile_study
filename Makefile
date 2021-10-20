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
