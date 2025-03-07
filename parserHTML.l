%{   
 int num_lines = 0, num_chars = 0;
 int num_tablas=0;
%}

%%

"<"[Hh][Ee][Aa][Dd]">"(.|(\n))*"</"[Hh][Ee][Aa][Dd]">"       { /*printf( "<head> encontrado: %s\n ===\n", yytext);*/ }
"<!DOCTYPE html>"                                 ;
"<body>"                                          ;
"<html>"                                          ;
"<"[Hh][1]">"(.|(\n))*"</"[Hh][1]">"            { printf( "<H1> encontrado: %s\n ===\n", yytext); }
"<"[Hh][2]">"(.|(\n))*"</"[Hh][2]">"            { printf( "<H2> encontrado: %s\n ===\n", yytext); }
\n ++num_lines; ++num_chars;
.                                               { ++num_chars; printf( "%s", yytext ); }

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
    printf( "# of lines = %d, # of chars = %d\n", num_lines, num_chars );
}
/*
ER <h1>texto</h1>                               print(texto)
ER <h2>texto</h2>                               print(texto)
ER <p>texto</p>                               print(texto)
ER <img>                                       ;
ER <table>                                      {print("Tabla #"); num_tablas++;}
*/