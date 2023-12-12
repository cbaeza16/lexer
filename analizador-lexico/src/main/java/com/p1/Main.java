package com.p1;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
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
            String result = "";
            boolean bandera = true;

            while(bandera){
                token = lex.next_token();
                if(token.sym != 0){
                    result+= "Token: "+ String.valueOf(token.sym) +", Lexema: "+(token.value==null?lex.yytext():token.value.toString())+"\n";
                }else{
                    result += "Cantidad de lexemas encontrados: "+ String.valueOf(i);
                    bandera = false;
                }
                i ++;
            }
            
            BufferedWriter writer = new BufferedWriter(new FileWriter(userPath+"\\src\\main\\lexerRes.txt", false));
            writer.write(result);
            writer.close();

            System.out.println(result);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
