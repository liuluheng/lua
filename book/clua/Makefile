CC = clang
CFLAGS = -g -O2 -Wall
LDFLAGS = -llua -lm -ldl

all : call_va clean

call_va: call_va.o
	$(CC) -o $@ $^ $(LDFLAGS) 

table: table.o
	$(CC) -o $@ $^ $(LDFLAGS) 

clean:
	rm -f *.o

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

indent:
	indent -kr -l72 -br -ce -npsl -nut -i4 *.[hc]
	rm -rf *~
