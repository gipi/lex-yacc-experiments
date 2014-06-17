%{
#include <math.h>
#include <string.h>
#include "env.tab.h"
extern int variable;
%}
%x VARIABLE
%%
path                    return PATH_TOK;
\"                      return QUOTE;
\$\{                    return START_VARIABLE;
\}                      return END_VARIABLE;
[^\n$"{} ]*             {
                            char* s = NULL;
                            if (variable) {
                                s = getenv(yytext);
                            }
                            yylval = strdup(s != NULL ? s : yytext);
                            return ALPHA;
                        }
