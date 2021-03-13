//code top: incluye el codigo al principio de PARSER.C

%code top{
#include <stdio.h>
#include "scanner.h"
#include "semantic.h"
}
//code provides: codigo para el parser.h
%code provides{
void yyerror(const char *);

extern int nerrlex;
extern int yynerrs;
extern int nerrsem;
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

//crea parser.h y parser.c
%defines "parser.h"
%output "parser.c"
%define api.value.type {char *} //indica si el registro semantico es de tipo char *
%define parse.error verbose // es para tirar un mensaje de error mas especifico, que syntax error

%token FDT PROGRAMA DECLARAR FIN_PROG ASIG "<-" LEER ESCRIBIR ID CTE CARAC_PUNT //define los tokens y bison genera un enum con los valores de los tokens

//declara las precedencias, la que está mas arriba es la de menor precedencia
%left '-' '+'
%left '*' '/'
%precedence NEG

%%
lenguaje_mini	: {comenzar();} PROGRAMA lsentencias FIN_PROG {terminar();} {if(nerrlex || yynerrs || nerrsem) YYABORT; else YYACCEPT;} ;
lsentencias 	: %empty
		| sentencias lsentencias
		;
sentencias	: sentencia_declarar
		| sentencia_leer';'
		| sentencia_escribir';'
		| sentencia_asignacion';'
		| error';'
		;
sentencia_declarar	: DECLARAR ID';'		            {if(declarar($2)) YYERROR;};
sentencia_leer : LEER '('lIdentificadores')'		    {leer($3);};
sentencia_escribir: ESCRIBIR '('lExpresiones')'	        {escribir($3);};
sentencia_asignacion: identificador "<-" expresion 	    {asignar($1,$3);};

lIdentificadores: identificador
		| lIdentificadores',' identificador
		;
		
lExpresiones	: expresion
		| expresion ',' lExpresiones
		;
	
expresion	: expresion '+' expresion			{$$ = generarInfijo($1, '+', $3);}
		| expresion '-' expresion 			{$$ = generarInfijo($1, '-', $3);}
		| expresion '/' expresion 			{$$ = generarInfijo($1, '/', $3);}
		| expresion '*' expresion 			{$$ = generarInfijo($1, '*', $3);}
		| '-' expresion %prec NEG 			{$$ = generarUnario($2, '-');}
		| '(' expresion ')' 				
		| CTE					//	PROCESAR CTE?
		| identificador				
		;

identificador	: ID						{if(procesarID($1)) YYERROR;}; //ESTO SE HACE PARA QUE PRIMERO PROCESE EL ID Y FDESPUES SIGUE LA RUTINA SEMANTICA QUE LE SIGUE, POR EJ EN LEER IDENTIF
//PROCESARID ES CARGAR EL ID EN EL REGISTRO SEMANTICO
%%

int nerrlex = 0; //numero de errores lexicos

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("\nlínea #%d: %s", yylineno, s);
	return;
}

