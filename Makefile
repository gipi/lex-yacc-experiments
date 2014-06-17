CC=gcc
CPFLAGS=-Wall -DYYDEBUG

YACC=yacc
YACC_OPTS=-t -d

LEX=flex

BIN=heater conf/env

%: %.tab.c %.scan.c
	$(CC) $(CPFLAGS) $^ -lfl -o $@

%.tab.c %.tab.h: %.y
	$(YACC) $(YACC_OPTS) $^ -o $@

%.scan.c:%.l
	$(LEX) --outfile=$@ $^

clean:
	rm -f *.o *.tab.c *.tab.h $(BIN)
