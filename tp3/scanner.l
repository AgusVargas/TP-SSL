%top{
#include "tokens.h"
}
%option outfile="scanner.c"
%option header-file="scanner.h"
%option nodefault
%option noinput 
%option nounput


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
puntuacion [[:punct:]]{-}[+*/(),;-]
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
{asignacion}           {return ASIGNACION;}
{comentario}*		;
{espacios}+		;
{declarar}             {return DECLARAR;}
{finprog}              {return FINPROG;}
{leer}                 {return LEER;}
{escribir}             {return ESCRIBIR;}
{parenizq}		return '(';
{parender}		return ')';
{coma}			return ',';
{pycoma}		return ';';
{letra}{alfanumerico}*     {return ID;}
{digito}+             {return CTE;}
{caracterError}+  {printf("Error léxico: cadena desconocida: %s\n",yytext);}
{letra}{alfanumerico}*{cualquiera}+ {printf("Error léxico: identificador inválido: %s\n",yytext);}
{digito}+{alfanumerico}+   {printf("Error léxico: constante inválida: %s\n",yytext);}
{puntuacion}+	    	{return CARACTERPUNT;}


%%
