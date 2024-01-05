//-------Codigo del usuario---------
//se copia al inico de la clase generada
package com.p1;

import java_cup.runtime.*;


%%

//--------Opciones y declaraciones-------
//nombre de clase generada
%class Lexer
%public
%unicode
%cup
%line
%column

//Codigo que se copia directamente en la clase generada
%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }

//genera el codigo para poder presentar el numero de linea y columna
  public int getLine(){
    return yyline;
  }
  public int getCol(){
    return yycolumn;
  }

%}

//Lo que pasa al final del archivo
//%eofval{
//  return symbol(ParserSym.EOF);
//%eofval}


//-------Definicion de literales------

//Define el final de linea, los caracteres de ingreso y el "espacio banco"
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

//Definición de comentario
Comment = {TraditionalComment} | {EndOfLineComment}

TraditionalComment   = "/_" [^_] ~"_/" | "/_" "_"+ "/"


EndOfLineComment     = "@" {InputCharacter}* {LineTerminator}?
CommentContent       = ( [^*] | \*+ [^/*] )*

//Definicion de identificador
Identifier = [:jletter:] [:jletterdigit:]*

digit =[0-9]
noCeroDigit = [1-9]
IntegerLiteral = (0|-?{noCeroDigit}{digit}*)
FloatLiteral = (0.0|-?{noCeroDigit}{digit}*.{digit}+|-?0.0*{noCeroDigit})
letter = \'[a-zA-Z]\'
whitespace = [ \t\n]


%state STRING
%%

//---------Definicon y Asignacion de palabras reservadas y simbolos---------
//Definir las palabras y simbolos que va a reconocer el lexer

/* keywords */

<YYINITIAL> "boolean"            { return symbol(sym.FATHER_CHRISTMAS, yytext()); }
<YYINITIAL> "int"              { return symbol(sym.SANTA_CLAUS, yytext()); }
<YYINITIAL> "float"              { return symbol(sym.PAPA_NOEL, yytext()); }
<YYINITIAL> "string"              { return symbol(sym.SAN_NICOLAS, yytext()); }
<YYINITIAL> "char"              { return symbol(sym.SANTA, yytext()); }

<YYINITIAL> "true"              { return symbol(sym.l_TFATHER_CHRISTMAS); }
<YYINITIAL> "false"              { return symbol(sym.l_FFATHER_CHRISTMAS); }

<YYINITIAL> "function"              { return symbol(sym.FUNCTION); }
<YYINITIAL> "local"              { return symbol(sym.LOCAL); }
<YYINITIAL> "main"              { return symbol(sym.MAIN); }

<YYINITIAL> "if"              { return symbol(sym.ELFO); }
<YYINITIAL> "elif"              { return symbol(sym.HADA); }
<YYINITIAL> "else"              { return symbol(sym.DUENDE); }
<YYINITIAL> "for"              { return symbol(sym.ENVUELVE); }
<YYINITIAL> "do"              { return symbol(sym.HACE); }
<YYINITIAL> "until"              { return symbol(sym.REVISA); }
<YYINITIAL> "return"              { return symbol(sym.ENVIA); }
<YYINITIAL> "break"              { return symbol(sym.CORTA); }

<YYINITIAL> "print"              { return symbol(sym.NARRA); }
<YYINITIAL> "read"              { return symbol(sym.ESCUCHA); }

<YYINITIAL> {
  /* identificadores */ 
  {Identifier}                   { return symbol(sym.PERSONA, yytext()); }
     
  /* literales */
  {IntegerLiteral}            { return symbol(sym.l_SANTA_CLAUS, yytext()); }
  {FloatLiteral}            { return symbol(sym.l_PAPA_NOEL, yytext()); }
  {letter}            { return symbol(sym.l_SANTA); }

  \"                             { string.setLength(0); yybegin(STRING); }

  

  /* operadores */
  "<="                            { return symbol(sym.ENTREGA); }
  "+"                            { return symbol(sym.RODOLFO, yytext()); }
  "++"                           { return symbol(sym.QUIEN);}
  "-"                            { return symbol(sym.TURENO, yytext());}
  "--"                           { return symbol(sym.GRINCH); }
  "*"                            { return symbol(sym.COMETA, yytext()); }
  "/"                            { return symbol(sym.DASHER, yytext()) ;}
  ","                            { return symbol(sym.BASTON);}
  "~"                            { return symbol(sym.DANCER, yytext());}
  "**"                            { return symbol(sym.PRANCER, yytext());}     
  
  /* relacionales */
  "=="                           { return symbol(sym.SNOWBALL); }
  "<"                           { return symbol(sym.BUSHY); }
  "=<"                           { return symbol(sym.PEPPER); }
  ">"                           { return symbol(sym.SUGARPLUM); }
  "=>"                           { return symbol(sym.SHINNY); }
  "!="                           { return symbol(sym.WUNORSE); }

  /* logicos */ 
  "#"                           { return symbol(sym.MELCHOR); }
  "^"                           { return symbol(sym.GASPAR); }
  "!"                           { return symbol(sym.BALTAZAR); }
 
  /* parentesis*/
  "("                           { return symbol(sym.ABRECUENTO); }
  ")"                           { return symbol(sym.CIERRACUENTO); }
  "["                           { return symbol(sym.ABREEMPAQUE); }
  "]"                           { return symbol(sym.CIERRAEMPAQUE); }
  "{"                           { return symbol(sym.ABREREGALO); }
  "}"                           { return symbol(sym.CIERRAREGALO); }

  /* final de expresion */
  "|"                           { return symbol(sym.FINREGALO); }

  /* comentario */
  {Comment}                      { /* ignore */ }
     
  /* espaico en blanco */
  {WhiteSpace}                   { /* ignore */ }
}


//Cuando lo reconoce como String
<STRING> {
  \"                             { yybegin(YYINITIAL); 
                                    return symbol(sym.l_SAN_NICOLAS, 
                                    "\"" + string.toString() + "\""); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
  }


// En caso de encontrar un error 
[^] {
    System.err.println("Error léxico en la línea " + yyline + " Columna: "+ yycolumn +": Cadena ilegal <" + yytext() + ">");
    yybegin(YYINITIAL); // Reinicia el análisis para continuar con la siguiente línea
}
