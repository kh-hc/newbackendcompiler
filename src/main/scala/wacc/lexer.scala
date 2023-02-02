package wacc

import parsley.Parsley
import scala.language.implicitConversions

object lexer {
    import parsley.token.Lexer 
    import parsley.token.descriptions.{LexicalDesc, NameDesc, SymbolDesc, SpaceDesc, numeric, text}
    import parsley.token.predicate.{Unicode, Basic}
    import parsley.character.newline

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
            space = Basic(c => c == ' ' || c == '\t' || c == '\n'),
        )
    )

    private val lexer = new Lexer(waccDesc)

    val IDENT = lexer.lexeme.names.identifier

    val INT = lexer.lexeme.numeric.integer.number
    val STRING = lexer.lexeme.text.string.ascii
    val CHAR = lexer.lexeme.text.character.ascii

    val NEWLINE = lexer.lexeme(newline).void

    def fully[A](p: Parsley[A]) = lexer.fully(p)

    val implicits = lexer.lexeme.symbol.implicits
}
