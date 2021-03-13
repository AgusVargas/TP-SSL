
/*GRUPO 6 : 
	ANDREA ZUMARRAGA	LEGAJO: 1677640
	GUILLERMO FELIPETTI	LEGAJO: 1730678
	AGUSTIN VARGAS		LEGAJO: 1648226


*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "parser.h"




int main() {

switch( yyparse() ){

	case 0:
		puts("\nCompilacion terminada con exito"); break;
	case 1:
		puts("\nErrores de compilacion"); break;
	case 2:
		puts("\nMemoria insuficiente"); break;
	}

printf("\nErrores lexicos: %i\t", nerrlex);
printf("Errores sintacticos: %i\n", yynerrs);
return 0;
}


