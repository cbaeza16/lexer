package com.p1;


import java.io.IOException;
import com.p1.*;


public class MainJFlexCup {

    public void inilexerParser(String lexerPath, String[] strArrParser) throws InternalError, Exception{
        GenerateLexer (lexerPath);
        GenerateParser(strArrParser);
    }

    private void GenerateParser(String[] strArrParser) throws InternalError, Exception, IOException {
        //java_cup.Main.main(strArrParser);
    }
    
    public void GenerateLexer(String lexerPath) throws IOException {
        String [] strArr = {lexerPath};
        //jflex.Main.generate(strArr);
        
    }
}
