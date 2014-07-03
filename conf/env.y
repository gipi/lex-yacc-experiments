%{
#include <stdio.h>
#include <string.h>
extern int yydebug;
int variable;
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 
  
main() {
#ifdef YYDEBUG
        yydebug = 1;
#endif
        yyparse();
} 

%}
%token PATH_TOK QUOTE ALPHA START_VARIABLE END_VARIABLE
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
        | QUOTE character QUOTE {
            $$ = $2;
        }
        ;
variable:
        START_VARIABLE {variable = 1;} ALPHA END_VARIABLE {variable = 0; $$ = $3; }
        ;
character: /* empty */
        | ALPHA
        | ALPHA variable
        | variable
        | variable ALPHA {
            char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+1));
                                strcpy(s,$1); strcat(s,$2);
                                $$=s;
        }
        ;
