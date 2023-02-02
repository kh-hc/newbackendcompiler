package wacc

import parsley.Parsley

object parser {
    import parsley.combinator._
    import parsley.Parsley.attempt
    import parsley.Result
    import parsley.errors.ErrorBuilder

    import lexer._
    import implicits.implicitSymbol
    import abstractSyntaxTree._
    import parsley.expr.{precedence, SOps, InfixL, InfixN, Prefix, Atoms}

    def parse[Err: ErrorBuilder](input: String): Result[Err, WACCprogram] = program.parse(input)

    private val program: Parsley[WACCprogram] = WACCprogram("begin" *> many(func), statement <* "end")

    private val func: Parsley[FunctionUnit] = (ParamFunc(tiepe, identifier, "(" *> paramList <* ")", "is" *> statement <* "end")
        <|> NiladicFunc(tiepe, identifier, "(" *> ")" *> "is" *> statement <* "end"))

    private val paramList: Parsley[ParamList] = ParamList(sepBy1(param, ","))

    private val param: Parsley[Param] = Param(tiepe, identifier)

    private val statement: Parsley[StatementUnit] = ("skip" #> SkipStat
        <|> AssignStat(tiepe, identifier, "=" *> rValue)
        <|> ReassignStat(lValue, "=" *> rValue)
        <|> ReadStat("read" *> lValue)
        <|> FreeStat("free" *> expression)
        <|> ReturnStat("return" *> expression)
        <|> ExitStat("exit" *> expression)
        <|> PrintStat("print" *> expression)
        <|> PrintlnStat("println" *> expression)
        <|> IfStat("if" *> expression, "then" *> statement, "else" *> statement <* "fi")
        <|> WhileStat("while" *> expression, "do" *> statement <* "done")
        <|> ScopeStat("begin" *> statement <* "end")
        <|> SeqStat(statement, ";" *> statement)
    )

    private val lValue: Parsley[Lvalue] = identifier <|> arrayElem <|> pairElem

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
