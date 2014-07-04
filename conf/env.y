%{
#include <stdio.h>
#include <string.h>
extern int yydebug;
extern FILE* yyin;
int variable;
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 
  
void parse_configuration_file(char* configuration_file_path) {
    // open a file handle to a particular file:
    FILE* configuration_file = fopen(configuration_file_path, "r");
    // make sure it's valid:
    if (!configuration_file) {
        char message[256];
        snprintf(message, 256, "error opening '%s'", configuration_file_path);
        perror(message);
        return;
    }

    // set lex to read from it instead of defaulting to STDIN:
    yyin = configuration_file;
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
variable_declaration:
        VAR_TOK ALPHA EQUAL_TOK QUOTE ALPHA QUOTE {
            printf("find out variable '%s' with value '%s'\n", $2, $5);
        }
        ;
block:
        BLOCK_NAME BRACE_START path BRACE_END
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
