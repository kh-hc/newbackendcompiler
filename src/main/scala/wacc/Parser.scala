package wacc

object parser {
    import parsley.combinator._
    import parsley.character.string

    import lexer._
    import implicits.implicitSymbol
    import abstractSyntaxTree._
    import parsley.expr.{precedence, SOps, InfixL, InfixR, InfixN, Prefix, Atoms}
    
    private val atomicExpression = (IntExpr(INT)
                                                <|> StrExpr(STRING)
                                                <|> CharExpr(CHAR)
                                                <|> attempt(string("true") #> BoolExpr(true))
                                                <|> attempt(string("false") #> BoolExpr(false))
                                                <|> attempt(string("null") #> PairExpr(PairLiteral))
                                                <|> IdentifierExpr(Identifer(IDENT))
                                                <|> attempt("(" *> expression <* ")"))

    private lazy val expressionOps: Parsley[Expr] = 
        precedence(SOps(InfixR)(Or <# "||") +:
                   SOps(InfixR)(And <# "&&") +:
                   SOps(InfixN)(NotEqual <# "!=", Equal <# "==") +:
                   SOps(InfixN)(LessOrEqualThan <# "<=", LessThan <# "<",
                                GreaterOrEqualThan <# ">=", GreaterThan <# ">") +:
                   SOps(InfixL)(Add <# "+", Sub <# "-") +:
                   SOps(InfixL)(Mul <# "*", Div <# "/", Mod <# "%") +:
                   SOps(Prefix)(NotOp <# "!", NegateOp <# "-", LenOp <# "len",
                                OrdOp <# "ord", ChrOp <# "chr"))
    
    private val expression: Parsley[Expr] = atomicExpression <|> expressionOps

}
