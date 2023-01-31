package wacc

import parsley.Parsley

object parser {
    //import parsley.combinator._
    import parsley.character.string
    import parsley.Parsley.attempt

    import lexer._
    import implicits.implicitSymbol
    import abstractSyntaxTree._
    import parsley.expr.{precedence, SOps, InfixL, InfixN, Prefix, Atoms}
    
    private val atomicExpression: Parsley[Expr0] = (IntExpr(INT)
                                    <|> StrExpr(STRING)
                                    <|> CharExpr(CHAR)
                                    <|> "true" #> BoolExpr(true)
                                    <|> "false" #> BoolExpr(false)
                                    <|> "null" #> PairLiteral
                                    <|> Identifier(IDENT)
                                    <|> ParenExpr("(" *> expression <* ")"))

    private lazy val expression: Parsley[Expr] = 
        precedence(SOps(InfixL)(Or <# "||") +:
                   SOps(InfixL)(And <# "&&") +:
                   SOps(InfixN)(NotEqual <# "!=", Equal <# "==") +:
                   SOps(InfixN)(LessOrEqualThan <# "<=", LessThan <# "<",
                                         GreaterOrEqualThan <# ">=", GreaterThan <# ">") +:
                   SOps(InfixL)(Add <# "+", Sub <# "-") +:
                   SOps(InfixL)(Mul <# "*", Div <# "/", Mod <# "%") +:
                   SOps(Prefix)(NotOp <# "!", NegateOp <# "-", LenOp <# "len",
                                        OrdOp <# "ord", ChrOp <# "chr") +:
                    Atoms(atomicExpression))

}
