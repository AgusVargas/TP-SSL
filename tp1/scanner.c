
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "scanner.h"


char* Tokens[] = {"IDENTIFICADOR", "CONSTANTE ENTERA", "NUMERAL", "ERROR", "FIN DE ARCHIVO"};


char* nombreToken(token tok) {
	return Tokens[tok];
}


enum {
	digito,
	letra,
	numeral,
	espacio,
	fda,
	error
};

int tipoDeCaracter(char c){
    if (isdigit(c) )              {return digito;}
    else if(isalpha(c))			  {return letra;}
    else if (c == '#')            {return numeral;}
    else if (isspace(c))          {return espacio;} //el primero es un espacio y el segundo una tabulacion!
    else if (c == EOF)            {return fda;}
    else                          {return error;}
}

token tipoDeToken(int estado){
    switch (estado){
        case 4: return CONSTANTE;
        case 5: return IDENTIFICADOR;
        case 6: return NUMERAL;
        case 7: return ERROR;
        case 8: return FDA;
        default: return (token)-1;
    }
}

int estadoAceptor(int estado) {
	return (estado == 4 || (estado ==5) || (estado == 6) || (estado == 7) || (estado ==8));
}

int estadoCentinela(int estado) {
	return (estado == 4 || estado == 5|| estado == 7);
}



static int tabla[4][6]={
         //     Dig Letr # Esp eof otro
        /*0- */{ 1,  2,  6,  0,  8,  3}, // Inicial
        /*1  */{ 1,  4,  4,  4,  4,  4}, // Casos de cte entera
        /*2  */{ 2,  2,  5,  5,  5,  5}, // Casos de identificador
        /*3  */{ 7,  7,  7,  7,  7,  3} // Casos de error
};



token scanner(){
		token tok;
	    char caracterLeido;
	    int estado=0;
	    int estadoColumna;

	    while (!estadoAceptor(estado)) {
			caracterLeido = (char) getchar();
			estadoColumna = tipoDeCaracter(caracterLeido);
			estado = tabla[estado][estadoColumna];
			
		}

		if(estadoAceptor(estado)){
            if (estadoCentinela(estado)){
                        ungetc(caracterLeido,stdin);
                    }
                    tok = tipoDeToken(estado);
                    return tok;
            }else{
                return error;
            }


}

