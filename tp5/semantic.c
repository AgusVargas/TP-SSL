#include <stdio.h>
#include <string.h>
#include "semantic.h"
#include "scanner.h"
#include "parser.h"
#include "symbol.h"

int nerrsem = 0;
char buffer2[200];
char temporal[50];
int cantTemporales = 1;

//CADA RUTINA SEMANTICA, CARGA EN EL REGISTRO SEMANTICO QUÉ INSTRUCCION ES

int procesarID(char * id) {
	if (!buscar(id)) {
		sprintf(buffer2,"Error semantico: identificador %s NO declarado", id);
		nerrsem++;
		yyerror(buffer2);
		return 1;
		}	
	return 0;
}

//generar infijo, le da todos los datos para generar el codigo assembler
char* generarInfijo (char* a, char operador, char* b) {
	char * temp; //variable para guardar el resultado
	sprintf(temporal, "Temp#%d",cantTemporales);
	cantTemporales++;
	temp = strdup(temporal);
	declarar(temp);
	
	switch (operador) {	
	case '+': generar("ADD", a, b, temporal); break;
	case '*': generar("MUL", a, b, temporal); break;
	case '-': generar("SUB", a, b, temporal); break;
	case '/': generar("DIV", a, b, temporal); break;
	}
	return temp; //devuelve el resultado
}

char* generarUnario (char* a, char operador) {
	char * temp;
	sprintf(temporal, "Temp#%d",cantTemporales); 
	cantTemporales++;
	temp = strdup(temporal);
	declarar(temp);
	generar("INV", a, "", temporal);
	return temp;
}

void comenzar(void) {
	generar("Load","rtlib","",""); //runtime library
}

void leer(char* a) {
	generar("Read", a, "","Integer");
}

void escribir (char* a) {
	generar("Write", a, "", "Integer");
}

int declarar (char * id) {
	if(chequearEnTabla(id)) { //Chequear devuelve 1 si no estaba y tuvo que agregarlo						//Revisar si está en la TS
		generar("Reserve ",id, "", "4");
		return 0;
		}
	else {	
		sprintf(buffer2,"Error semantico: identificador %s ya declarado", id);
		nerrsem++;
		yyerror(buffer2);
		return 1;
		}
}


void asignar(char* a, char* b) {
	generar("Store", a, b, "");
}


void terminar() {
	generar("Exit","","","");
}


