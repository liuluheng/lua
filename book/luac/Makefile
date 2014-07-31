CC = clang
CFLAGS = -g -O2 -Wall -fPIC
LDFLAGS = -shared -Wl,-soname -Wl,

all : mylib.so clean

mylib.so: mylib.o
	$(CC) -o $@ $^ $(LDFLAGS) 

array.so: array.o
	$(CC) -o $@ $^ $(LDFLAGS) 

dir.so: dir.o
	$(CC) -o $@ $^ $(LDFLAGS) 

clean:
	rm -f *.o

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

indent:
	indent -kr -l72 -br -ce -npsl -nut -i4 *.[hc]
	rm -rf *~
