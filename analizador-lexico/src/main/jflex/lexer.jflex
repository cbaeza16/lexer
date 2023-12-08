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

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"

// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*
DecIntegerLiteral = 0 | [1-9][0-9]* //CAMBIAR PARA QUE PERMITA NEGATIVO

//digit =[0-9]
//noCeroDigit = [1-9]
//DecIntegerLiteral = (-?{noCeroDigit}{digit}*)
//letter = [a-zA-Z]
//whitespace = [ \t\n]


%state STRING
%%

/* keywords */
<YYINITIAL> "abstract"           { return symbol(sym.ABSTRACT); }
<YYINITIAL> "boolean"            { return symbol(sym.BOOLEAN); }
<YYINITIAL> "break"              { return symbol(sym.BREAK); }
//<YYINITIAL> "int"              { return symbol(sym.INT); }
//<YYINITIAL> "float"              { return symbol(sym.FLOAT); }
//<YYINITIAL> "string"              { return symbol(sym.STRING); }
//<YYINITIAL> "char"              { return symbol(sym.CHAR); }

<YYINITIAL> {
  /* identifiers */ 
  {Identifier}                   { return symbol(sym.IDENTIFIER); }
     
  /* literals */
  {DecIntegerLiteral}            { return symbol(sym.INTEGER_LITERAL); }
  \"                             { string.setLength(0); yybegin(STRING); }

  /* operators */
  "="                            { return symbol(sym.EQ); }
  "=="                           { return symbol(sym.EQEQ); }
  "+"                            { return symbol(sym.PLUS); }

  /* comments */
  {Comment}                      { /* ignore */ }
     
  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
}

//Cuando lo reconoce como String
<STRING> {
  \"                             { yybegin(YYINITIAL); 
                                    return symbol(sym.STRING_LITERAL, 
                                    string.toString()); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
  }

    //En caso de error
    [^]                              { throw new Error("Cadena ilegal <"+
                                                        yytext()+">"); }