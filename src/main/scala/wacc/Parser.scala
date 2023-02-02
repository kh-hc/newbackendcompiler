package wacc

import parsley.Parsley

object parser {
    import parsley.combinator._
    import parsley.Parsley.{attempt, notFollowedBy}
    import parsley.Result
    import parsley.errors.ErrorBuilder
    import Parsley.LazyParsley

    import lexer._
    import implicits.implicitSymbol
    import abstractSyntaxTree._
    import parsley.expr.{precedence, SOps, InfixL, InfixN, Prefix, Atoms}

    private val identifier: Parsley[Identifier] = Identifier(IDENT)

    private val arrayElem: Parsley[ArrayElem] = ArrayElem(identifier, many("[" *> expression <* "]"))


    private lazy val pairElemType: Parsley[PairElemType] = "pair" #> NestedPair <|> PairElemTypeT(tiepe)
    
    private val baseType: Parsley[BaseType] = ("int" #> IntT 
        <|> "bool" #> BoolT
        <|> "char" #> CharT
        <|> "string" #> StringT)

    private val pairType: Parsley[PairType] = PairType("pair" *> "(" *> pairElemType <* ",", pairElemType <* ")")

    private val arrayType: Parsley[ArrayType] = ArrayType(~tiepe <~ "[]")

    private val tiepe: Parsley[Type] = (attempt((baseType <|> pairType) <~ notFollowedBy("["))) <|> arrayType

    private lazy val func: Parsley[FunctionUnit] = (ParamFunc(tiepe, identifier, "(" *> paramList <* ")", "is" *> statement <* "end")
        <|> NiladicFunc(tiepe, identifier, "(" *> ")" *> "is" *> statement <* "end"))

    private lazy val paramList: Parsley[ParamList] = ParamList(sepBy1(param, ","))

    private val param: Parsley[Param] = Param(tiepe, identifier)

    private lazy val statement: Parsley[StatementUnit] = attempt(atomStatement <~ notFollowedBy(";")) <|> seqStat

    private lazy val seqStat: Parsley[StatementUnit] = SeqStat(sepBy1(atomStatement, ";"))

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

    private lazy val lValue: Parsley[Lvalue] = identifier <|> arrayElem <|> pairElem

    private lazy val rValue: Parsley[Rvalue] = (expression
        <|> arrayLiteral
        <|> NewPair("newpair" *> "(" *> expression <* ",", expression <* ")")
        <|> pairElem
        <|> attempt(NiladicCall("call" *> identifier <* "(" <* ")"))
        <|> attempt(ParamCall("call" *> identifier <* "(", argList <* ")")))

    private val pairElem: Parsley[PairElem] = (PairElemFst("fst" *> lValue)
        <|> PairElemSnd("snd" *> lValue))
        
    private val arrayLiteral: Parsley[ArrayLiteral] = ArrayLiteral("[" *> sepBy1(expression, ",") <* "]")

    private val atomicExpression: Parsley[Expr0] = (IntExpr(INT)
        <|> StrExpr(STRING)
        <|> CharExpr(CHAR)
        <|> "true" #> BoolExpr(true)
        <|> "false" #> BoolExpr(false)
        <|> "null" #> PairLiteral
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

    def parse[Err: ErrorBuilder](input: String): Result[Err, WACCprogram] = program.parse(input)

}