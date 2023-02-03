package wacc

import parsley.Parsley

object parser {
    import parsley.combinator._
    import parsley.Parsley.attempt
    import parsley.io.ParseFromIO
    import java.io.File
    import parsley.debug.DebugCombinators

    import lexer._
    import implicits.implicitSymbol
    import abstractSyntaxTree._
    import parsley.expr.{precedence, SOps, InfixL, InfixN, Prefix, Atoms, chain}

    private val identifier: Parsley[Identifier] = Identifier(IDENT)

    private val arrayElem: Parsley[ArrayElem] = ArrayElem(identifier, many("[" *> expression <* "]"))

    private lazy val pairElemType: Parsley[PairElemType] = "pair" #> NestedPair <|> PairElemTypeT(tiepe)
    
    private val baseType: Parsley[BaseType] = ("int" #> IntT 
        <|> "bool" #> BoolT
        <|> "char" #> CharT
        <|> "string" #> StringT)

    private val pairType: Parsley[PairType] = PairType("pair" *> "(" *> pairElemType <* ",", pairElemType <* ")")

    private val tiepe: Parsley[Type] = chain.postfix(baseType <|> pairType, ArrayType <# "[]")

    private lazy val func: Parsley[FunctionUnit] = (attempt(ParamFunc(tiepe, identifier, "(" *> paramList <* ")", "is" *> statement <* "end")
        <|> NiladicFunc(tiepe, identifier, "(" *> ")" *> "is" *> statement <* "end")))

    private lazy val paramList: Parsley[ParamList] = ParamList(sepBy(param, ","))

    private val param: Parsley[Param] = Param(tiepe, identifier)

    private lazy val statement: Parsley[StatementUnit] = SeqStat(sepBy1(atomStatement, ";"))

    private lazy val atomStatement: Parsley[StatementUnit] = ("skip" #> SkipStat
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
    )

    //chain.postfix(baseType <|> pairType, ArrayType <# "[]")
    //private lazy val lValue: Parsley[Lvalue] = chain.right(identifier <|> pairElem, ArrayElem "[" *> expression <* "]")
    private lazy val lValue: Parsley[Lvalue] = arrayElem <|> (pairElem <|> identifier)

    private lazy val rValue: Parsley[Rvalue] = (expression
        <|> arrayLiteral
        <|> NewPair("newpair" *> "(" *> expression <* ",", expression <* ")")
        <|> pairElem
        <|> attempt(ParamCall("call" *> identifier <* "(", argList <* ")"))
        <|> attempt(NiladicCall("call" *> identifier <* "(" <* ")")))

    private val pairElem: Parsley[PairElem] = (PairElemFst("fst" *> lValue)
        <|> PairElemSnd("snd" *> lValue))
        
    private val arrayLiteral: Parsley[ArrayLiteral] = ArrayLiteral("[" *> sepBy(expression, ",") <* "]").debug("arr lit")

    private val atomicExpression: Parsley[Expr0] = (IntExpr(INT)
        <|> StrExpr(STRING)
        <|> CharExpr(CHAR)
        <|> "true" #> BoolExpr(true)
        <|> "false" #> BoolExpr(false)
        <|> "null" #> PairLiteral
        <|> arrayElem
        <|> identifier
        <|> ParenExpr("(" *> expression <* ")"))

    private val expression: Parsley[Expr] = 
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

    private val argList: Parsley[ArgList] = ArgList(sepBy1(expression, ","))

    private val program: Parsley[WACCprogram] = fully(WACCprogram("begin" *> many(func), statement <* "end"))

    def parse(input: File) = program.parseFromFile(input).get

}
