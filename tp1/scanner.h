
#ifndef SCANNER_H_INCLUDED
#define SCANNER_H_INCLUDED


typedef enum {
	IDENTIFICADOR,
	CONSTANTE,
	NUMERAL,
	ERROR,
	FDA
} token;


char* nombreToken(token);
extern token scanner();



#endif // SCANNER_H_INCLUDED


