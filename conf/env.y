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
%token BRACE_START BRACE_END PATH_TOK QUOTE ALPHA START_VARIABLE END_VARIABLE BLOCK_NAME VAR_TOK EQUAL_TOK
%%
blocks: /* empty */
        | blocks block
        | blocks variable_declaration
        ;
variable_declaration:   /* empty */
        | VAR_TOK ALPHA EQUAL_TOK QUOTE ALPHA QUOTE {
            printf("find out variable '%s' with value '%s'\n", $2, $5);
        }
        ;
block: /* empty */
        | BLOCK_NAME BRACE_START path BRACE_END
        ;
paths: /* empty */
        | paths path
        ;
path:
        PATH_TOK filename {
            printf("find out path with value '%s'\n", $2);
        }
        ;

filename: /* empty */
        | QUOTE character QUOTE {
            $$ = $2;
        }
        ;
variable:
        START_VARIABLE {variable = 1;} ALPHA BRACE_END {variable = 0; $$ = $3; }
        ;
character: /* empty */
        | ALPHA
        | ALPHA variable
        | variable
        | variable ALPHA {
            char* s = malloc(sizeof(char) * (strlen($1) + strlen($2) + 1));
                                strcpy(s,$1);
                                strcat(s,$2);
                                $$ = s;
        }
        ;
