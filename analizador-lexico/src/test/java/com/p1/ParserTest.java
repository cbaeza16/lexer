package com.p1;

import java.io.StringReader;

import org.junit.jupiter.api.Test;

public class ParserTest {

    @Test
    public void testParser() throws Exception{
        String cadena ="hola";
        parser p = new parser(new Lexer(new StringReader(cadena)));

        String resultado = (String) p.parse().value;
    }
    
}
