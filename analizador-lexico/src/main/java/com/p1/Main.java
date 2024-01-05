package com.p1;


import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.Reader;
import java_cup.runtime.Symbol;


public class Main {

/*  Entrada: Ruta del archivo a analizar y ruta de salida para el archivo de resultados
  * Salida: Archivo de texto con los resultados del análisis léxico
  * Objetivo: Inicializa un lexer para el archivo de entrada, identifica los tokens en el archivo
  * y escribe los resultados en un archivo de salida. 
*/
    public static void initLexer(String ruta, String rutaSalida) throws Exception{

        Reader reader = new FileReader(ruta);
        reader.read();
        Lexer lex = new Lexer(reader);
        int i = 0;
        Symbol token;
        String result = "";
        boolean bandera = true;

        System.out.println("-------Inicio Fase Lexica-------");

        while(bandera){
            token = lex.next_token();
            if(token.sym != 0){
                result+= "Token: "+ String.valueOf(token.sym) +", Lexema: "+(token.value==null?lex.yytext():token.value.toString())+
                ", Linea: "+ String.valueOf(lex.getLine())+", Columna: "+ String.valueOf(lex.getCol())+ "\n";
                System.out.println("Token: "+ String.valueOf(token.sym) +", Lexema: "+(token.value==null?lex.yytext():token.value.toString())+
                ", Linea: "+ String.valueOf(lex.getLine())+", Columna: "+ String.valueOf(lex.getCol()));
            }else{
                result += "Cantidad de lexemas encontrados: "+ String.valueOf(i);
                System.out.println( "\nCantidad de lexemas encontrados: "+ String.valueOf(i)+ "\n");
                bandera = false;
            }
            i ++;
        }
         
        System.out.println("-------Fin Fase Lexica-------\n");
        BufferedWriter writer = new BufferedWriter(new FileWriter(rutaSalida, false));
        writer.write(result);
        writer.close();
    }

    /* Entrada: Ruta del archivo a analizar
     * Objetivo: Inicializa un parser para el archivo txt de entrada, 
     * crea un lexer a partir del mismo y ejecuta el parse
     */
    public static void initParser(String ruta) throws Exception{

        Reader readerx = new FileReader(ruta);

        Lexer lexer = new Lexer(readerx);
        parser myParser = new parser (lexer);
        myParser.parse();    
    }


    public static void main(String[] args) {
        try {
            // Directorio del usuario
            String userPath = System.getProperty("user.dir");
            // Archivo de entrada
            String fileName = "text.txt";
            // Archivo de salida
            String outputFile = "lexerRes.txt";

            // Ruta del rchivo de entrada
            String ruta = userPath+"\\src\\main\\"+fileName;
            // Ruta del rchivo de salida
            String rutaSalida = userPath+"\\src\\main\\"+outputFile;
            
            initLexer(ruta, rutaSalida);
            initParser(ruta);
           

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
