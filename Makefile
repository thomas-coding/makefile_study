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
