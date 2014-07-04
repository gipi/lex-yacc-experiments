# Lex&Yacc

These are two fundamental tools for programming

**Lex** is a generator of lexical analyzers, **Yacc** a parser generator.

# Internals

- In the YACC file, you write your own ``main()`` function, which calls ``yyparse()`` at one point.
The function ``yyparse()`` is created for you by ``YACC`` and ends up in ``y.tab.c``
- ``yyparse()`` reads a stream of token/value pairs from ``yylex()``, which needs to be supplied.
You can code this function yourself, or have Lex do it for you
- ``yylex()`` as written by lex reads characters from a ``FILE *`` file pointer called ``yyin``. If you
do no set ``yyin``, it defaults to standard input. It outputs to ``yyout``, which if unset defaults to ``stdout``.
    You can also modify ``yyin`` in the ``yywrap()`` function which is called at the end of the file. It allows
    you to open another file, and continue parsing. If this is the case, have it return 0. If you want to
    end parsing at this file, let it return 1
- each call to ``yylex()`` returns an interger value which represents a token type. This tells ``YACC`` what
kind of token it has read. The token ay optionally have a value, which should be placed in the variable ``yylval``
- by default ``yylval`` is of type int, but you can override that be re#defining ``YYSTYPE``
- the lexer needs to be able to access ``yylval``. In order to do so, it must be declared in the scope
of lexer as an extern vaariable. You will find this extern declaration in the ``*.tab.h`` file

## EXAMPLE

Exists a simple program that parse a path directive with environment variable inside

    $ make conf/env
    $ ./conf/env
    find out variable 'root' with value '/srv/'
    find out path with value '/home/gipi/bin/'

If you want to have debugging activated pass ``DEBUG=1`` to the ``make`` command.

## Link

 - http://ds9a.nl/lex-yacc/cvs/lex-yacc-howto.html
 - http://moss.csc.ncsu.edu/~mueller/codeopt/codeopt00/y_man.pdf
 - http://luv.asn.au/overheads/lex_yacc/yacc.html
 - http://epaperpress.com/lexandyacc/download/LexAndYaccTutorial.pdf
