
/*GRUPO 6 : 
	ANDREA ZUMARRAGA	LEGAJO: 1677640
	GUILLERMO FELIPETTI	LEGAJO: 1730678
	AGUSTIN VARGAS		LEGAJO: 1648226


*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "parser.h"
#include "semantic.h"
#include "symbol.h"



int main() {

switch( yyparse() ){

	case 0:
		puts("\nCompilacion terminada con exito"); break;
	case 1:
		puts("\nErrores de compilacion"); break;
	case 2:
		puts("\nMemoria insuficiente"); break;
	}

printf("\nErrores lexicos: %i  ", nerrlex);
printf("Errores sintacticos: %i  ", yynerrs);
printf("Errores semanticos: %i", nerrsem);
return 0;
}


