package wacc

import parsley.Parsley

object lexer {
    import parsley.token.Lexer 
    import parsley.token.descriptions.{LexicalDesc, NameDesc, SymbolDesc, SpaceDesc, numeric, text}
    import parsley.token.predicate.{Unicode, Basic}
    private val waccDesc = LexicalDesc(
        NameDesc.plain.copy(
            identifierStart = Unicode(c => Character.isLetter(c) || c == '_'),
            identifierLetter = Unicode(c => Character.isLetterOrDigit(c) || c == '_'),
        ),
        SymbolDesc.plain.copy(
            hardKeywords = Set("begin", "end", "is", "skip", "read", "free",
                                "return", "exit", "print", "println", "if", 
                                "then", "else", "fi", "while", "do", "done", 
                                "fst", "snd", "newpair", "call", "int", 
                                "bool", "char", "string", "pair", "len", 
                                "ord", "chr", "true", "false", "null"),
            hardOperators = Set("!", "-", "len", "ord", "chr", "*", "/", "%",
                                "+", ">", ">=", "<", "<=", "==", "!=", "&&",
                                "||"),
        ),
        numeric.NumericDesc.plain.copy(),
        text.TextDesc.plain.copy(
            excapeSequence = text.ExcapeDesc.plain.copy(
                literals = Set('\'','\"','\\'),
                singleMap = Map('0' -> 0x00,
                                'b' -> 0x08, 
                                't' -> 0x09, 
                                'n' -> 0x0a, 
                                'f' -> 0x0c, 
                                'r' -> 0x0d, 
                                '\"' -> 0x22, 
                                '\'' -> 0x27,
                                '\\' -> 0x5c
                ),
                multiMap = Map("NUL" -> 0x00,
                                "BS" -> 0x08, 
                                "TAB" -> 0x09, 
                                "LF" -> 0x0a, 
                                "FF" -> 0x0c, 
                                "CR" -> 0x0d
                ),
            )
        ),
        SpaceDesc.plain.copy(
            commentLine = "#",
            space = Basic(c => c == ' ' || c == '\t'),
        )
    )
    private val lexer = new Lexer(waccDesc)
}
