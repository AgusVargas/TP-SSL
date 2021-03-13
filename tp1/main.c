#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "scanner.h"



int main(){

	token tokenAux=0;

	int tokensIDENTIFICADOR=0;
    int tokensCONSTANTE=0;
    int tokensNUMERAL=0;
    int tokensERROR=0;

	while(tokenAux!=FDA){

		tokenAux=scanner();
		
		if(tokenAux!=FDA){ 
			printf("%s \n", nombreToken(tokenAux));
		}
		
		switch(tokenAux){
	            case IDENTIFICADOR: tokensIDENTIFICADOR++;
	                break;
	            case CONSTANTE: tokensCONSTANTE++;
	                break;
	            case NUMERAL: tokensNUMERAL++;
	                break;
	            case ERROR: tokensERROR++;
	                break;
				case FDA: //findearchivo no hace nada
				;
					}



	}




	printf("-------------------------------------------------\n");
    printf("Identificadores: %d\n",tokensIDENTIFICADOR);
    printf("Constantes enteras: %d\n",tokensCONSTANTE);
    printf("Numerales: %d\n",tokensNUMERAL);
    printf("Errores: %d\n",tokensERROR);
}


