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
