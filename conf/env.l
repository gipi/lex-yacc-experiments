%{
#include <math.h>
#include <string.h>
#include "env.tab.h"
extern int variable;
// needed in order to have line numbered errors
//struct { int first_line; } yyltype;
//yyltype yylloc;
%}
%x VARIABLE
%%
\{                      return BRACE_START;
\}                      return BRACE_END;
path                    return PATH_TOK;
var                     return VAR_TOK;
smtp                    return BLOCK_NAME;
=                       return EQUAL_TOK;
\"                      return QUOTE;
\$\{                    return START_VARIABLE;
[^\n$"{} ]*             {
                            char* s = NULL;
                            if (variable) {
                                s = getenv(yytext);
                            }
                            yylval = strdup(s != NULL ? s : yytext);
                            return ALPHA;
                        }
.|\n                    ;// ignore all the not recognized token and newlines
