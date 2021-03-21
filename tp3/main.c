
/*GRUPO 6 : 
	ANDREA ZUMARRAGA	LEGAJO: 1677640
	GUILLERMO FELIPETTI	LEGAJO: 1730678
	AGUSTIN VARGAS		LEGAJO: 1648226


*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "scanner.h"



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


int main(){

	enum token t;

	while((t = yylex()) != FDT){		

	     switch(t){
			    case CTE: 
			    case ID: 
			    printf("Token: %s \t\t Lexema: %s \n", token_names[t], yytext);
			        break; 
			        
			    case CARACTERPUNT:
			    printf("Token: '%s' \n", yytext);
			      break; 
			   case PROGRAMA:
			   case DECLARAR:
			   case LEER:
			   case ESCRIBIR:
			   case FINPROG:
			   case ASIGNACION:
			   case FDT:
			  printf("Token: %s \t\t \n", token_names[t]);
				break;

			}

	
	}
	  printf("Token: %s \t\t \n", token_names[t]);

}

