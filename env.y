%{
#include <stdio.h>
#include <string.h>
extern int yydebug;
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 
  
main() {
        yydebug = 1;
        yyparse();
} 

%}
%token PATH_TOK QUOTE ALPHA
%%
paths: /* empty */
        | paths path
        ;
path:
        PATH_TOK filename {
            printf("PATH %s", $2);
        }
        ;

filename: /* empty */
        | QUOTE ALPHA QUOTE {
            $$ = $2;
        }
        ;
