CC = g++
BIT = 32
NFLAGS = -g -f elf$(BIT)
CFLAGS = -g -Wall -m$(BIT) -std=c++11
HEADERS = -I/SFML$(BIT)/include
LIBS = -L/SFML$(BIT)/lib -lsfml-graphics -lsfml-window -lsfml-system

all: main.o rotateL.o rotateUD.o rotateR.o
	$(CC) $(CFLAGS) rotateL.o rotateUD.o rotateR.o main.o -o obrot $(LIBS)

rotateL.o: rotateL.asm
	nasm $(NFLAGS) rotateL.asm -o rotateL.o
rotateUD.o: rotateUD.asm
	nasm $(NFLAGS) rotateUD.asm -o rotateUD.o
rotateR.o: rotateR.asm
	nasm $(NFLAGS) rotateR.asm -o rotateR.o
main.o: main.cpp
	$(CC) $(CFLAGS) -c main.cpp $(HEADERS)

clean:
	rm -f *.o
