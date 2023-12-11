package com.p1;


import java.io.BufferedReader;
import java.io.FileReader;
import java.io.Reader;

import java_cup.runtime.Symbol;


public class Main {

    public static void main(String[] args) {
        try {
            String userPath = System.getProperty("user.dir");
            String fileName = "text.txt";
            String ruta = userPath+"\\src\\main\\"+fileName;
            Reader reader = new BufferedReader(new FileReader(ruta));
            reader.read();
            Lexer lex = new Lexer(reader);
            int i = 0;
            Symbol token;

            while(true){
                token = lex.next_token();
                if(token.sym != 0){
                    System.out.println("Token: "+token.sym+", Lexema: "+(token.value==null?lex.yytext():token.value.toString()));
                }else{
                    System.out.println("Cantidad de lexemas encontrados: "+i);
                    return;
                }
                i ++;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
