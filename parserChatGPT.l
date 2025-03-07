%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dentro_etiqueta = 0;  // Bandera para saber si estamos dentro de una etiqueta de interés
int dentro_tabla = 0;    // Bandera para indicar si estamos dentro de una tabla
int dentro_celda = 0;    // Bandera para capturar texto dentro de <th> o <td>
int primera_fila = 1;    // Indica si es la primera fila (para imprimir línea de separación)

void imprimir_linea() {
    printf("+----------------+----------------+----------------+\n");
}

void imprimir_celda(const char *contenido) {
    printf("| %-14s ", contenido);
}
%}

%%
"<p>"      { dentro_etiqueta = 1; } 
"<h1>"     { dentro_etiqueta = 1; } 
"<h2>"     { dentro_etiqueta = 1; } 
"</p>"     { dentro_etiqueta = 0; printf("\n"); } 
"</h1>"    { dentro_etiqueta = 0; printf("\n"); } 
"</h2>"    { dentro_etiqueta = 0; printf("\n"); } 

"<table>"   { dentro_tabla = 1; imprimir_linea(); } 
"</table>"  { dentro_tabla = 0; imprimir_linea(); printf("\n"); } 

"<th>"      { dentro_celda = 1; }
"</th>"     { dentro_celda = 0; if (primera_fila) printf("|"); } 

"<td>"      { dentro_celda = 1; }
"</td>"     { dentro_celda = 0; printf("|"); } 

"<tr>"      { if (!primera_fila) imprimir_linea(); } 
"</tr>"     { printf("\n"); primera_fila = 0; }




"<[^>]+>"  { /* Ignora otras etiquetas HTML */ }

[^<>\n]+   { if (dentro_etiqueta) printf("%s ", yytext);
             if (dentro_tabla && dentro_celda) printf("%s ", yytext); /*imprimir_celda(yytext);*/
           }

\n         { /* Ignorar saltos de línea */ }
.          { /* Ignorar otros caracteres */ }
%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <archivo.html>\n", argv[0]);
        return 1;
    }

    FILE *archivo = fopen(argv[1], "r");
    if (!archivo) {
        perror("Error al abrir el archivo");
        return 1;
    }

    yyin = archivo;
    yylex();

    fclose(archivo);
    return 0;
}

int yywrap() {
    return 1;
}
