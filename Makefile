CC= gcc
CFLAGS= -Wall -Werror -Wextra -pedantic -std=c99
CPPFLAGS= -O2 -DNDBUG
LDFLAGS= -fsanitize=address

OBJ= -Isrc/add/ -Isrc/mul/ -Isrc/sub/
ADD= -c -o src/add/add.o src/add/add.c
MUL= -c -o src/mul/mul.o src/mul/mul.c
SUB= -c -o src/sub/sub.o src/sub/sub.c
PROG= -c -o src/prog.o src/prog.c
TESTFILE= -c -o tests/testfile.o tests/testfile.c
LAST= src/prog.o src/add/add.o src/mul/mul.o src/sub/sub.o -o prog
 

all: release

release:
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) $(PROG)
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) $(ADD)
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) $(MUL)
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) $(SUB)
	 $(CC) $(LAST)

debug:
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) -g $(LDFLAGS) $(PROG)
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) -g $(LDFLAGS) $(ADD)
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) -g $(LDFLAGS) $(MUL)
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) -g $(LDFLAGS) $(SUB)
	 $(CC) $(LDFLAGS) $(LAST)

test:
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) -g $(LDFLAGS) $(ADD)
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) -g $(LDFLAGS) $(MUL)
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) -g $(LDFLAGS) $(SUB)
	 $(CC) $(CFLAGS) $(OBJ) $(CPPFLAGS) -g $(LDFLAGS) $(TESTFILE)
	 $(CC) $(LDFLAGS) -lcriterion src/add/add.o src/mul/mul.o src/sub/sub.o tests/testfile.o -o test-suite



clean:   
	rm -f prog
	rm -f test-suite
	rm -f src/prog.o
	rm -f src/add/add.o src/mul/mul.o src/sub/sub.o
	rm -f tests/testfile.o tests/testfile.o
