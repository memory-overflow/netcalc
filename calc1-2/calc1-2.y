/**
* \file calc1-2.y
* \brief 
* \author islands
* \version 1.0.0
* \date 2015-12-21
*/

%{
/** @brief define YYSTYPE to be double */
#define YYSTYPE double
#include<stdio.h>
#include<math.h>
%}

/** @brief using  mark */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP
%token SQR SQRT
/** @}*/

/**  @brief using  rule */
%%

calclist:
    | calclist exp EOL { printf("ans = %f\n>>> " ,$2 );  }
    ;

exp: factor { $$ = $1; }
    | exp ADD factor { $$ = $1 + $3 ; }
    | exp SUB factor { $$ = $1 - $3 ; }
    ;
factor: tmp { $$ =$1; }
    | factor MUL tmp { $$ = $1 * $3; }
    | factor DIV tmp { $$ = $1 / $3; }
    ;
tmp: term { $$ = $1; }
    | SUB tmp { $$ = -$2; }
    | tmp SQR tmp { $$ = pow($1,$3);  /*printf("%d %d %d\n",$1,$2,$3);*/}
    ;

term: NUMBER { $$ = $1;}
    | ABS exp ABS { $$ = fabs($2);}
    | OP exp CP { $$ = $2; }
    | SQRT OP exp CP { $$ = sqrt($3) ;/*printf(" %d %d %d\n",$1,$2,$3);*/ }
    ;
%%



/**
* @brief main 
*
* @return 
*/
int main()
{
    printf(">>> ");
    yyparse();
    return 0;
}


/**
* @brief yyerror  
* 
* deal whit error
* @param s
*/
yyerror(char *s)
{
    fprintf(stderr,"error : %s\n",s);
}
