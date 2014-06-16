YACC=yacc
LEX=flex

BIN=heater

%: %.tab.c %.scan.c
	gcc -Wall $^ -lfl -o $@

%.tab.c %.tab.h: %.y
	$(YACC) -d $^ -o $@

%.scan.c:%.l
	$(LEX) --outfile=$@ $^

clean:
	rm -f *.o *.tab.c *.tab.h $(BIN)
