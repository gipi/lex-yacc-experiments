CC=gcc
CPFLAGS=-Wall

ifneq ($(DEBUG),)
    CPFLAGS+=-DYYDEBUG
endif

YACC=yacc
YACC_OPTS=-t -d

LEX=flex

BIN=heater conf/env

all:$(BIN)

%: %.tab.c %.scan.c
	$(CC) $(CPFLAGS) $^ -lfl -o $@

%.tab.c %.tab.h: %.y
	$(YACC) $(YACC_OPTS) $^ -o $@

%.scan.c:%.l
	$(LEX) --outfile=$@ $^

conf/env: conf/env.tab.c conf/env.scan.c conf/main.c
	$(CC) $(CPFLAGS) $^ -lfl -o $@

clean:
	rm -f *.o */*.tab.c */*.tab.h */*.scan.c $(BIN)
