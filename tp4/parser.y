
%code top{
#include <stdio.h>
#include "scanner.h"
}
%code provides{
void yyerror(const char *);

extern int nerrlex;
extern int yynerrs;
}
%code {
char *token_names[] = {
"Fin de Archivo",
"Programa",
"Declarar",
"Fin-Prog",
"Asignación",
"Leer",
"Escribir",
"Identificador",
"Constante",
"otro",
""};
}
%defines "parser.h"
%output "parser.c"
%define api.value.type {char *}
%define parse.error verbose

%token FDT PROGRAMA DECLARAR FIN_PROG ASIG "<-" LEER ESCRIBIR ID CTE CARAC_PUNT
%left '-' '+'
%left '*' '/'
%precedence NEG

%%

lenguaje_mini	: PROGRAMA lsentencias FIN_PROG {if(nerrlex || yynerrs) YYABORT; else YYACCEPT;};
lsentencias 	: %empty
		| sentencias lsentencias
		;
sentencias	: sentencia_declarar
		| sentencia_leer';'
		| sentencia_escribir';'
		| sentencia_asignacion';'
		| error';'
		;
sentencia_declarar	: DECLARAR ID';'			{printf("\n%s %s",token_names[2],$ID);};
sentencia_leer : LEER '('lIdentificadores')'		{printf("\n%s",token_names[5]);};
sentencia_escribir: ESCRIBIR '('lExpresiones')'	{printf("\n%s",token_names[6]);};
sentencia_asignacion: ID "<-" expresion 		{printf("\n%s",token_names[4]);};

lIdentificadores: ID
		| lIdentificadores',' ID
		;
		
lExpresiones	: expresion
		| expresion ',' lExpresiones
		;
	
expresion	: expresion '+' expresion			{printf("\nSuma");}
		| expresion '-' expresion 			{printf("\nResta");}
		| expresion '/' expresion 			{printf("\nDivision");}
		| expresion '*' expresion 			{printf("\nMultiplicacion");}
		| '-' expresion %prec NEG 			{printf("\nInversion");}
		| '(' expresion ')' 				{printf("\nParentesis");}
		| CTE
		| ID
		;

%%

int nerrlex = 0;
/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("\nlínea #%d: %s", yylineno, s);
	return;
}
