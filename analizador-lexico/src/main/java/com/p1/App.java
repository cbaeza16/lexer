package com.p1;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class App {

    public static void generatePath() throws Exception{
        String userPath, lexer, parser, lexerPath, parserPath;
    
        userPath = System.getProperty("user.dir");
        
        lexer ="Lexer.java";
        parser ="Parser.java";

        lexerPath = userPath+"\\src\\main\\jflex\\lexer.jflex";
        Files.deleteIfExists(Paths.get(userPath+"\\target\\generated-sources\\jflex\\com\\p1"+lexer));

        parserPath = userPath+"\\src\\main\\cup\\parser.cup";
        Files.deleteIfExists(Paths.get(userPath+"\\target\\generated-sources\\cup\\com\\p1"+parser));
    }

    public static void main(String[] args) throws Exception{

    }
    
}
