package wacc

import parsley.Parsley
import parsley.errors.ErrorBuilder

import wacc.lexer
object parser {
    import parsley.combinator._
    import parsley.Parsley.attempt
    import parsley.io.ParseFromIO
    import java.io.File

    import lexer._
    import implicits.implicitSymbol
    import abstractSyntaxTree._
    import parsley.expr.{precedence, SOps, InfixL, InfixN, Prefix, Atoms, chain}
    import parsley.errors.combinator._
    import WACCErrors._

    /*-------------------------------------Types-------------------------------------*/

    private val identifier: Parsley[Identifier] = Identifier(IDENT)

    /*
    Array element type parsed via an identifier and then with 0 or more "[expr]".
    */
    private val arrayElem: Parsley[ArrayElem] = ArrayElem(identifier, many("[" *> expression <* "]"))
        .label("Array element")

    /* 
    A pair elements can be of types:
        >   nested pair
        >   or a pair element taking a type
    */
    private lazy val pairElemType: Parsley[PairElemType] = ("pair" #> NestedPair <|> PairElemTypeT(tiepe))
        .label("Pair element type")
    
    /* 
    Our base types are:
        >   int
        >   char
        >   string
        > bool
    */
    private val baseType: Parsley[BaseType] = ("int" #> IntT 
        <|> "bool" #> BoolT
        <|> "char" #> CharT
        <|> "string" #> StringT)
        .label("Base Type")
        .explain("Valid base types are int, bool, char and string")

    /*
    A pair is initiliased with the keyword "pair" and is followed by two elements of type
    pairElemType separated by "(", "," and ")"
    */
    private val pairType: Parsley[PairType] = PairType("pair" *> "(" *> pairElemType.label("fst") <* ",", pairElemType.label("snd") <* ")")
        .label("Pair Type")

    private val tiepe: Parsley[Type] = chain.postfix(baseType <|> pairType, ArrayType <# "[]")
        .label("Type")

    /*-------------------------------------Functions-------------------------------------*/
    /*
    Functions require an identifier, a type, a paramList which can be 0 or more, and a 
    statement.
    */
    private lazy val func: Parsley[FunctionUnit] = (attempt(FunctionUnit(tiepe.label("type"), identifier.label("identifier"),
            ("(" *> paramList.label("parameter list") <* ")"), 
            ("is" *> statement.label("statement") <* "end").filter(stats => endsInRet(stats)))))

    /*
    This is the parser for parameter lists as they are used in functions, paramters are 
    separated by "," and there can be 0 or more.
    */
    private lazy val paramList: Parsley[ParamList] = ParamList(sepBy(param, (",")))
        .label("Parameter list")

    /*
    A parameter is parsed from a type and identifier, e.g.
        >   int x
        >   bool y
    */
    private val param: Parsley[Param] = Param(tiepe, identifier)
        .label("Parameter")

    /*-------------------------------------Statements-------------------------------------*/
    /*
    We can have both singular statements (atomStatements) or a list of statements. So 
    we made the design choice to have our statements all be parsed as though they are
    a list of atomStatements using sepBy1 so that there can be 1 or more statements 
    and they can be atomStatements and not lists. 
    */
    private lazy val statement: Parsley[StatementUnit] = SeqStat(sepBy1(atomStatement, (";")))
        .label("Statement")
        .explain("A statement can be either a list of statements or a singular statement")

    /*
    Our atomStatements are all statements apart from a sequence of statements.
    */
    private lazy val atomStatement: Parsley[StatementUnit] = ("skip" #> SkipStat
        <|> AssignStat(tiepe, identifier, "=" *> rValue).label("assignment")
        <|> ReassignStat(lValue, "=" *> rValue).label("reassignment")
        <|> ReadStat("read" *> lValue).label("read")
        <|> FreeStat("free" *> expression).label("free")
        <|> ReturnStat("return" *> expression).label("return")
        <|> ExitStat("exit" *> expression).label("exit")
        <|> PrintStat("print" *> expression).label("print")
        <|> PrintlnStat("println" *> expression).label("println")
        <|> IfStat("if" *> expression, "then" *> statement, "else" *> statement <* "fi").label("if statement")
        <|> WhileStat("while" *> expression, "do" *> statement <* "done").label("while")
        <|> ScopeStat("begin" *> statement <* "end").label("new scope")
    )
        .label("Atomic Statement")
        .explain("An atomic statement can be 'skip', 'assignment', 'reassignment'," +
          "'read', 'free', 'return', 'exit', 'print', 'println', 'if', 'while', or " +
          "a new scope definition with 'begin'")

    /*-------------------------------------values-------------------------------------*/
    /*
    Lvalues are either arrayElems, pairElems or identifiers. 
    */
    private lazy val lValue: Parsley[Lvalue] = arrayElem <|> (pairElem <|> identifier)
        .label("Left Value")

    /*
    Rvalues are expressions, arrayLiterals, the creation of a new pair with "newpair",
    pairElems or function calls which take in the function identifier and the argument
    list.
    */
    private lazy val rValue: Parsley[Rvalue] = (expression
        <|> arrayLiteral
        <|> NewPair("newpair" *> "(" *> expression <* ",", expression <* ")")
        <|> pairElem
        <|> attempt(Call("call" *> identifier <* "(", argList <* ")")))
        .label("Right Value")

    /*
    Pair elements are either fst and snd depending on whether they are first or second 
    in the pair
    */
    private val pairElem: Parsley[PairElem] = (PairElemFst("fst" *> lValue)
        <|> PairElemSnd("snd" *> lValue))
        .label("Pair element")
        
    /*
    An array literal is parsed  from square braces "[" and "]" with  0 or more expressions
    separated by  "," in between.
    */
    private val arrayLiteral: Parsley[ArrayLiteral] = ArrayLiteral("[" *> sepBy(expression, ",") <* "]")
        .label("Array Literal")

    /*-------------------------------------Expressions-------------------------------------*/
    /*
    Our expressions are split in atomicExpressions and expressions, our atomicExpressions are
    parsed with highest precedence.
    */
    private val atomicExpression: Parsley[Expr0] = (IntExpr(INT).label("int")
        <|> StrExpr(STRING).label("string")
        <|> CharExpr(CHAR).label("char")
        <|> BoolExpr("true" #> true).label("true")
        <|> BoolExpr("false" #> false).label("false")
        <|> ("null" #> PairLiteral).label("pair literal")
        <|> arrayElem.label("array element")
        <|> identifier.label("identifier")
        <|> ParenExpr("(" *> expression <* ")").label("parenthesised expression"))
        .label("Atomic expression")
        .explain("An atomic expression can be: \na string, char, boolean, pair literal, array element, " +
          "identifier, or a paranthesised expression")

    /*
    Our expressions parsed here include unary and binary operators and are parsed with precedence from
    top to bottom.
    */
    private val expression: Parsley[Expr] = 
        precedence(SOps(InfixL)((Or <# "||").label("OR")) +:
            SOps(InfixL)((And <# "&&").label("AND")) +:
            SOps(InfixN)((NotEqual <# "!=").label("NOT EQUAL"), (Equal <# "==").label("EQUAL")) +:
            SOps(InfixN)((LessOrEqualThan <# "<=").label("LESS OR EQUAL"), (LessThan <# "<").label("LESS"),
                (GreaterOrEqualThan <# ">=").label("GREATER OR EQUAl"), (GreaterThan <# ">").label("GREATER")) +:
            SOps(InfixL)((Add <# "+").label("AND"), (Sub <# "-").label("SUB")) +:
            SOps(InfixL)((Mul <# "*").label("MUL"), (Div <# "/").label("DIV"), (Mod <# "%").label("MOD")) +:
            SOps(Prefix)((NotOp <# "!").label("NOT"), (NegateOp <# NEGATE).label("NEGATE") , (LenOp <# "len").label("LEN"),
                (OrdOp <# "ord").label("ORD"), (ChrOp <# "chr").label("CHR")) +:
            Atoms(atomicExpression))
        .label("Expression")
        .explain("An expression can be a binary operation, unary operation, or atomic expression. \n" +
          "Binary operations are infix notated and can be: \n    '||', '&&', '!=', '==', '<=', '<','>=', '>'" +
          "'+', '-', '*', '/', '%'.\nUnary operations are prefix notated and can be: \n    '!', '-', 'len', " +
          "'ord', 'chr'")

    /*
    The argument list is a series of 0 or more expressions separated by ","
    */
    private val argList: Parsley[ArgList] = ArgList(sepBy(expression, ",")).label("Argument list")
    
    /*-------------------------------------Program-------------------------------------*/
    /*
    A WACC program is parsed from an opening "begin" keyword followed by 0 or more functions and a
    statement, then it is terminated with the keyword "end".
    */
    private val program: Parsley[WACCprogram] = fully(WACCprogram("begin" *> many(func), statement <* "end"))
        .label("WACC program")

    implicit val eb: ErrorBuilder[WACCError] = new WACCErrorBuilder
    
    def parse(input: File) = program.parseFromFile(input).get

    def endsInRet(input: StatementUnit) : Boolean = input match {
        /*
        Ensures a function ends with either a return or exit  statement
        by recursively stepping through the final statement.
        */
        case WhileStat(_, body) => endsInRet(body)
        case ScopeStat(body) => endsInRet(body)
        case IfStat(_, ifStat, elseStat) => endsInRet(ifStat) && endsInRet(elseStat)
        case SeqStat(statements) => endsInRet(statements.last)
        case ExitStat(expr) => true
        case ReturnStat(expr) => true
        case _ => false
    }

}
