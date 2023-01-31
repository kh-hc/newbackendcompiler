package wacc

import parsley.Parsley

object parser {
    import parsley.combinator._
    import parsley.character.string
    import parsley.Parsley.attempt

    import lexer._
    import implicits.implicitSymbol
    import abstractSyntaxTree._
    import parsley.expr.{precedence, SOps, InfixL, InfixN, Prefix, Atoms}

    private val lValue: Parsley[Lvalue] = identifier

    private val rValue: Parsley[Rvalue] = (expression
        <|> arrayLiteral
        <|> NewPair("newpair" *> "(" *> expression <* ",", expression <* ")")
        <|> pairElem
        <|> attempt(NiladicCall("call" *> identifier <* "(" <* ")"))
        <|> attempt(ParamCall("call" *> identifier <* "(", argList <* ")")))

    private val argList: Parsley[ArgList] = ArgList(sepBy1(expression, ","))

    private val pairElem: Parsley[PairElem] = (PairElemFst("fst" *> lValue)
        <|> PairElemSnd("snd" *> lValue))
        
    private val arrayLiteral: Parsley[ArrayLiteral] = ArrayLiteral("[" *> sepBy1(expression, ",") <* "]")

    private val baseType: Parsley[BaseType] = ("int" #> IntT 
        <|> "bool" #> BoolT
        <|> "char" #> CharT
        <|> "string" #> StringT)

    private val arrayType: Parsley[ArrayType] = ArrayType(tiepe <* "[" <* "]")

    private val pairType: Parsley[PairType] = PairType("pair" *> "(" *> pairElemType <* ",", pairElemType <* ")")

    private val pairElemType: Parsley[PairElemType] = "pair" #> NestedPair <|> BasePairElem(baseType) <|> ArrayPairElem(arrayType)

    private val tiepe: Parsley[Type] = baseType <|> arrayType

    private val identifier: Parsley[Identifier] = Identifier(IDENT)

    private val arrayElem: Parsley[ArrayElem] = ArrayElem(identifier, many("[" *> expression <* "]"))
    
    private val atomicExpression: Parsley[Expr0] = (IntExpr(INT)
        <|> StrExpr(STRING)
        <|> CharExpr(CHAR)
        <|> "true" #> BoolExpr(true)
        <|> "false" #> BoolExpr(false)
        <|> "null" #> PairLiteral
        <|> identifier
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
