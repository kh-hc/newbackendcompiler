package wacc

import parsley.Parsley

object lexer {
    import parsley.token.Lexer 
    import parsley.token.descriptions.{LexicalDesc, NameDesc, SymbolDesc, SpaceDesc, numeric, text}
    import parsley.token.predicate.{Unicode, Basic}
    import parsley.Parsley.{attempt, notFollowedBy}
    import parsley.character.{char, digit}

    private val waccDesc = LexicalDesc.plain.copy(
        NameDesc.plain.copy(
            identifierStart = Unicode(c => Character.isLetter(c) || c == '_'),
            identifierLetter = Unicode(c => Character.isLetterOrDigit(c) || c == '_'),
        ),
        SymbolDesc.plain.copy(
            hardKeywords = Set("begin", "end", "is", "skip", "read", "free",
                                "return", "exit", "print", "println", "if", 
                                "then", "else", "fi", "while", "do", "done", 
                                "fst", "snd", "newpair", "call", "int", 
                                "bool", "char", "string", "pair", "true", "false", "null"),
            hardOperators = Set("!", "-", "len", "ord", "chr", "*", "/", "%",
                                "+", ">", ">=", "<", "<=", "==", "!=", "&&", "||"),
        ),
        numeric.NumericDesc.plain.copy(),
        text.TextDesc.plain.copy(
            escapeSequences = text.EscapeDesc.plain.copy(
                literals = Set('\'','\"','\\'),
                singleMap = Map('0' -> 0x00,
                                'b' -> 0x08, 
                                't' -> 0x09, 
                                'n' -> 0x0a, 
                                'f' -> 0x0c, 
                                'r' -> 0x0d
                ),
            ),
            characterLiteralEnd = '\'',
            graphicCharacter = Basic(c => (c >= ' '.toInt) && !Set(0x22, 0x27, 0x5C).contains(c))
        ),
        SpaceDesc.plain.copy(
            commentLine = "#",
            space = Basic(_.isWhitespace),
        )
    )

    private val lexer = new Lexer(waccDesc)

    val IDENT = lexer.lexeme.names.identifier

    // define POS and NEG numbers
    private val NEG = (char('-') *> lexer.lexeme(attempt(lexer.lexeme.numeric.integer.number32))).map(x => x * -1)
    private val NUM = lexer.lexeme.numeric.integer.number32

    // define NEGATE
    val NEGATE = lexer.lexeme(attempt(char('-') ~> notFollowedBy(digit)))

    val INT = lexer.lexeme(attempt(NEG)) <|> NUM
    val STRING = lexer.lexeme.text.string.ascii
    val CHAR = lexer.lexeme.text.character.ascii

    def fully[A](p: Parsley[A]) = lexer.fully(p)

    val implicits = lexer.lexeme.symbol.implicits
}
