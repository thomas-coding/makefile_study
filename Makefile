# ------------------------
# Generic Makefile
# ------------------------

target : main.o
	gcc -o target main.o 

main.o : main.c
	gcc -c main.c

clean :
	rm -rf target main.o