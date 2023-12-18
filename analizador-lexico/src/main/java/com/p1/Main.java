package com.p1;


import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.Reader;
import java_cup.runtime.Symbol;


public class Main {

    public static void initParser(String ruta) throws Exception{

        Reader readerx = new FileReader(ruta);

        Lexer lexer = new Lexer(readerx);
        parser myParser = new parser (lexer);
        System.out.println("aqui");
        myParser.parse();
        System.out.println("aqui");
    }

    public static void initLexer(String ruta, String rutaSalida) throws Exception{

        Reader reader = new FileReader(ruta);
            reader.read();
            Lexer lex = new Lexer(reader);
            int i = 0;
            Symbol token;
            String result = "";
            boolean bandera = true;


            while(bandera){
                token = lex.next_token();
                if(token.sym != 0){
                    result+= "Token: "+ String.valueOf(token.sym) +", Lexema: "+(token.value==null?lex.yytext():token.value.toString())+
                    ", Linea: "+ String.valueOf(lex.getLine())+", Columna: "+ String.valueOf(lex.getCol())+ "\n";
                    System.out.println("Token: "+ String.valueOf(token.sym) +", Lexema: "+(token.value==null?lex.yytext():token.value.toString())+
                    ", Linea: "+ String.valueOf(lex.getLine())+", Columna: "+ String.valueOf(lex.getCol()));
                }else{
                    result += "Cantidad de lexemas encontrados: "+ String.valueOf(i);
                    System.out.println( "Cantidad de lexemas encontrados: "+ String.valueOf(i));
                    bandera = false;
                }
                i ++;
            }
            
            BufferedWriter writer = new BufferedWriter(new FileWriter(rutaSalida, false));
            writer.write(result);
            writer.close();
    }


    public static void main(String[] args) {
        try {
            String userPath = System.getProperty("user.dir");
            String fileName = "text.txt";
            String outputFile = "lexerRes.txt";
            String ruta = userPath+"\\src\\main\\"+fileName;
            String rutaSalida = userPath+"\\src\\main\\"+outputFile;
            
            initLexer(ruta, rutaSalida);
            initParser(ruta);
           

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
