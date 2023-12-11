package com.p1;

import java_cup.runtime.*;

//Reglas
%%

//nombre de clase generada
%class Lexer
%public
%unicode
%cup
%line
%column


%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

//Lo que pasa al final del archivo
//%eofval{
//  return symbol(ParserSym.EOF);
//%eofval}


LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/_" [^_] ~"_/" | "/_" "_"+ "/"

// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "@" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*

digit =[0-9]
noCeroDigit = [1-9]
IntegerLiteral = (0|-?{noCeroDigit}{digit}*)
FloatLiteral = (0.0|-?{noCeroDigit}{digit}*.{digit}*)
letter = [a-zA-Z]
whitespace = [ \t\n]


%state STRING
%%

/* keywords */
<YYINITIAL> "abstract"           { return symbol(sym.PERE_NOEL); }

<YYINITIAL> "boolean"            { return symbol(sym.FATHER_CHRISTMAS); }
<YYINITIAL> "int"              { return symbol(sym.SANTA_CLAUS); }
<YYINITIAL> "float"              { return symbol(sym.PAPA_NOEL); }
<YYINITIAL> "string"              { return symbol(sym.SAN_NICOLAS); }
<YYINITIAL> "char"              { return symbol(sym.SANTA); }

<YYINITIAL> "true"              { return symbol(sym.l_TFATHER_CHRISTMAS); }
<YYINITIAL> "false"              { return symbol(sym.l_FFATHER_CHRISTMAS); }

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
  /* identifiers */ 
  {Identifier}                   { return symbol(sym.PERSONA); }
     
  /* literals */
  {IntegerLiteral}            { return symbol(sym.l_SANTA_CLAUS); }
  {FloatLiteral}            { return symbol(sym.l_PAPA_NOEL); }
  {letter}            { return symbol(sym.l_SANTA); }

  \"                             { string.setLength(0); yybegin(STRING); }

  /* operators */
  "<="                            { return symbol(sym.ENTREGA); }
  "+"                            { return symbol(sym.RODOLFO); }
  "++"                           { return symbol(sym.QUIEN);}
  "-"                            { return symbol(sym.TURENO);}
  "--"                           { return symbol(sym.GRINCH); }
  "*"                            { return symbol(sym.COMETA); }
  "/"                            { return symbol(sym.DASHER) ;}
  ","                            { return symbol(sym.BASTON);}
  "~"                            { return symbol(sym.DANCER);}
  "**"                            { return symbol(sym.PRANCER);}     
  
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

  /* final de exoresion */
  "|"                           { return symbol(sym.FINREGALO); }

  /* comments */
  {Comment}                      { /* ignore */ }
     
  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
}

//Cuando lo reconoce como String
<STRING> {
  \"                             { yybegin(YYINITIAL); 
                                    return symbol(sym.l_SAN_NICOLAS, 
                                    string.toString()); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
  }

// En caso de error
[^] {
    System.err.println("Error léxico en la línea " + yyline + ": Cadena ilegal <" + yytext() + ">");
    yybegin(YYINITIAL); // Reinicia el análisis para continuar con la siguiente línea
}
