%top{
#include <stdio.h>
#include <string.h>
#include "parser.h"
}

%{
char msg[150];
int nerrlex;
%}

%option outfile="scanner.c"
%option header-file="scanner.h"
%option noinput 
%option nounput
%option yylineno


/* definiciones */

programa "programa"
declarar "declarar"
leer "leer"
escribir "escribir"
asignacion "<-"
digito [0-9]
letra [[:alpha:]]
alfanumerico [[:alnum:]]
cualquiera [[:^space:]]{-}[+*/(),;-]
caracterError [[:^alnum:]]{-}[[:space:]]{-}[+*/(),;-]
espacios [[:space:]]
puntuacion [[:punct:]]{-}[+*/(),;-]{-}[[:space:]]
comentario ##(.)+
finprog "fin-prog"
mas "+"
menos "-"
por "*"
dividido "/"
parenizq "("
parender ")"
coma ","
pycoma ";"



%%

{programa}            	{return PROGRAMA;}

{mas}			{return '+';}
{menos}		return '-';
{por}			return '*';
{dividido}		{return '/';}
{asignacion}           {return ASIG;}
{comentario}*		;
{espacios}+		;
{declarar}             {return DECLARAR;}
{finprog}              {return FIN_PROG;}
{leer}                 {return LEER;}
{escribir}             {return ESCRIBIR;}
{parenizq}		return '(';
{parender}		return ')';
{coma}			return ',';
{pycoma}		return ';';
{letra}{alfanumerico}*     {yylval = strdup(yytext); return ID;}
{digito}+             {yylval = strdup(yytext); return CTE;}
{caracterError}+  {nerrlex++; sprintf(msg, "Error léxico: cadena desconocida: %s\n", yytext); yyerror(msg);}
{letra}{alfanumerico}*{cualquiera}+ {nerrlex++; sprintf(msg, "Error léxico: identificador inválido: %s\n", yytext); yyerror(msg);}
{digito}+{alfanumerico}+   {nerrlex++; sprintf(msg, "Error léxico: constante invalida: %s\n", yytext); yyerror(msg);}
{puntuacion}+	    	{return CARAC_PUNT;}


%%
