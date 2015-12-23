/**
* \file calc1-2.y
* \brief 
nclude the header <string.h> or explicitly provide a declaration for 'strncpy'* \author islands
* \version 1.0.0
* \date 2015-12-21
*/

%{
/** @brief define YYSTYPE to be double */
#define YYSTYPE double
#include<stdio.h>
#include<string.h>
#include<math.h>
#include<stdlib.h>
YYSTYPE res = 0;
extern void setBuffer();
extern int yyparse();
extern int yyerror();
//#undef YY_INPUT
//#define YY_INPUT(b,r,s) readInput(b,&r,s)
static int globalReadOffset = 0;
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
    | calclist exp EOL { res=$2 ; /*printf(" log -f ans = %f\n " ,res ) ;*/ }
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
* @brief yyerror  
* 
* deal whit error
* @param s
*/
//int max (int x,int y)
//{
//	return x>y?x:y;
//}
//int readInputForLexer(char *buffer,int * numBytesRead,int maxBytesToRead)
//{
//	//printf("-----------------------\n");
//	//printf("%s %d %d\n",InputText,globalReadOffset,*numBytesRead);
//	int numBytesToRead = maxBytesToRead;
//	int bytesRemaining = strlen(InputText) - globalReadOffset ;
//	int i;
//	if( numBytesToRead > bytesRemaining)  { numBytesToRead = bytesRemaining ;}
//	for(i=0;i<numBytesToRead ;i++)
//		buffer[i] = InputText[globalReadOffset++];
//	*numBytesRead = max(1,numBytesToRead);
//	//printf("%s %d %d\n",InputText,globalReadOffset,*numBytesRead);
//	//printf("-----------------------\n");
//	return 0;
//}
int yyerror(char *s)
{
    fprintf(stderr,"error : %s\n",s);
	return 0;
}
double get(char *ss,int sslen)
{
	//strncpy(InputText,ss,sslen);
	char *InputText = (char* )malloc(sizeof(char)*(sslen+2));
	strncpy(InputText,ss,sslen);
	InputText[sslen]='\n';
	InputText[sslen+1]=0;
	//printf("%s",InputText);
	setBuffer(InputText,sslen+1);
	yyparse();
	//printf("log get  ans = %f\n",res);
	free(InputText);
	return res;
}
