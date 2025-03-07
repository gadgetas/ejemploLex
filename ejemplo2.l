%{
#include <math.h>
%}

DIGIT [0-9]
ID [a-z][a-z0-9]*

%%

{DIGIT}+                                { printf( "An integer: %s (%d)\n", yytext,atoi( yytext ) ); }
{DIGIT}+"."{DIGIT}*                     { printf( "A float: %s (%g)\n", yytext, atof( yytext ) );}
[Bb][Oo][Dd][Yy]                    		{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Aa][Ll][Tt]                    		{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Hh][Tt][Mm][Ll]			{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Cc][Oo][Nn][Tt][Ee][Nn][Tt]		{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Cc][Hh][Aa][Rr][Ss][Ee][Tt]		{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Hh][Tt][Tt][Pp]-[Ee][Qq][Uu][Ii][Vv]		{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Nn][Aa][Mm][Ee]			{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Rr][Ee][Ll]				{ printf( "Etiqueta encontrada: %s\n", yytext );}
[!][Dd][Oo][Cc][Tt][Yy][Pp][Ee]	{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Dd][Ii][Vv]				{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Tt][Yy][Pp][Ee]\s*=\s*".*?"		{ printf( "Atributo encontrado: %s\n", yytext );}
[Oo][Ll]				{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Hh]1					{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Pp]					{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Hh][Ee][Aa][Dd]			{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Hh][Rr][Ee][Ff]			{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Ss][Rr][Cc]			{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Ff][Oo][Rr][Mm]			{ printf( "Etiqueta encontrada: %s\n", yytext );}
[Mm][Ee][Tt][Aa]                     	{ printf( "Etiqueta encontrada: %s\n", yytext ); }
[Mm][Ee][Dd][Ii][Aa]                     	{ printf( "Etiqueta encontrada: %s\n", yytext ); }
[Tt][Aa][Bb][Ll][Ee]                     	{ printf( "Etiqueta encontrada: %s\n", yytext ); }
[Tt][Ii][Tt][Ll][Ee]                     	{ printf( "Etiqueta encontrada: %s\n", yytext ); }
[Ll][Ii][Nn][Kk]                     	{ printf( "Etiqueta encontrada: %s\n", yytext ); }
[Ss][Cc][Rr][Ii][Pp][Tt]                     	{ printf( "Etiqueta encontrada: %s\n", yytext ); }
[Ss][Tt][Yy][Ll][Ee]                     	{ printf( "Etiqueta encontrada: %s\n", yytext ); }
[Tt][Rr]                             	{ printf( "Etiqueta encontrada: %s\n", yytext ); }
[Tt][Hh]                             	{ printf( "Etiqueta encontrada: %s\n", yytext ); }
[Tt][Dd]                             	{ printf( "Etiqueta encontrada: %s\n", yytext ); }
[Hh][1|2|3|4|5|6|7]                                		{ printf( "Etiqueta encontrada: %s\n", yytext ); }

"<"|">"|"="                         printf( "An operator: %s\n", yytext );
"{"[^}\n]*"}"                           /* eat up one-line comments */
[ \t\n]+                                /* eat up whitespace */
.                                       printf( "Unrecognized character: %s\n", yytext );

%%

main( argc, argv )
int argc;
char **argv;
{
    ++argv, --argc; /* skip over program name */
    if ( argc > 0 )
    yyin = fopen( argv[0], "r" );
    else
    yyin = stdin;
    yylex();
    
}