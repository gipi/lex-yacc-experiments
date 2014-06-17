%{
#include <math.h>
#include <string.h>
#include "env.tab.h"
%}
%x PATH
%%
path                    return PATH_TOK;
\"                      return QUOTE;
[^\n" ]*                 {
                            char* s = getenv(yytext);
                            yylval = strdup(s != NULL ? s : yytext);
                            return ALPHA;
                        }
