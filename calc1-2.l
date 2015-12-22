/**
 * @file calc1-2.l
 * @brief 
 * @author islands
 * @version 1.0.0
 * @date 2015-12-21
 */

%{
/** @brief define the YYSTYPE to be double */
#define YYSTYPE double
#include "calc1-2.tab.h"
#include <stdlib.h>
/**  @brief to debug  */
#ifdef debug
    YYSTYPE yylval;
#endif
%}
/** @brief rule
 *  
 * the  Regular Expressions of the match 
 */
%%

"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"|"     { return ABS; }
"("     { return OP; }
")"     { return CP; }
([0-9]*\.?[0-9]+|[0-9]+\.)  { yylval = atof(yytext); return NUMBER;}
"sqrt"  { return SQRT; }
"**"    { return SQR; }
\n      { return EOL; }
[ \t]   {}
"//".*  {}
%%
/** @brief to debug */
#ifdef debug
int main(int argc ,char* argv[])
{
    int token;
    
	while(token = yylex())
    {
        printf("%d",token);

        if(token ==NUMBER)
        {
            printf("= %f\n",yylval);
        }
        else
            printf("\n");
    }
    return 0;
}
#endif
