package wacc

object AbstractSyntaxTree {
    import parsley.genericbridges._

    case class WACCprogram(funcs: List[FunctionUnit], stat: StatementUnit)
    
    sealed trait FunctionUnit
    case class ParamFunc(t: Type, id: Identifier, params: Paramlist, body: StatementUnit) extends FunctionUnit
    case class NiladicFunc(t: Type, id: Identifier, body: StatementUnit)

    case class Paramlist(paramlist: List[Param])

    case class Param(t: Type, id: Identifier)

    sealed trait StatementUnit
    case object SkipStat extends StatementUnit with ParserBridge0[SkipStat]
    case class AssignStat(t: Type, id: Identifier, value: Rvalue) extends StatementUnit
    case class ReassignStat(left: Lvalue, right: Rvalue) extends StatementUnit
    case class ReadStat(value: Lvalue) extends StatementUnit
    case class FreeStat(expr: Expr) extends StatementUnit
    case class ReturnStat(expr: Expr) extends StatementUnit
    case class ExitStat(expr: Expr) extends StatementUnit
    case class PrintStat(expr: Expr) extends StatementUnit
    case class PrintlnStat(expr: Expr) extends StatementUnit
    case class IfStat(cond: Expr, ifStat: StatementUnit, elseStat: StatementUnit) extends StatementUnit
    case class WhileStat(cond: Expr, body: StatementUnit) extends StatementUnit
    case class ScopeStat(body: StatementUnit) extends StatementUnit
    case class SeqStat(left: StatementUnit, right: StatementUnit) extends StatementUnit

    sealed trait Lvalue
    case class IdentLeft(id: Identifier) extends Lvalue
    case class ArrayElemLeft(elem: ArrayElem) extends Lvalue
    case class PairElemLeft(elem: PairElem) extends Lvalue

    sealed trait PairElem
    case class Fst(value: Lvalue) extends PairElem
    case class Snd(value: Lvalue) extends PairElem

    sealed trait Rvalue
    case class ExprRight(expr: Expr) extends Rvalue
    case class ArrayRight(array: ArrayLiteral) extends Rvalue
    case class NewPairRight(exprLeft: Expr, exprRight: Expr) extends Rvalue
    case class PairElemRight(elem: PairElem) extends Rvalue
    sealed trait CallRight extends Rvalue
    case class ParamCall(id: Identifier, args: ArgList) extends CallRight
    case class NiladicCall(id: Identifier) extends CallRight

    case class ArgList(args: List[Expr])

    sealed trait Type

    sealed trait BaseType extends Type
    case object IntT extends BaseType with ParserBridge0[Type]
    case object BoolT extends BaseType with ParserBridge0[Type]
    case object CharT extends BaseType with ParserBridge0[Type]
    case object StringT extends BaseType with ParserBridge0[Type]

    case class ArrayType(t: Type) extends Type

    case class PairType(left: PairElemType, right: PairElemType) extends Type
    sealed trait PairElemType
    case class BasePairElem(t: BaseType) extends PairElemType
    case class ArrayPairElem(t: ArrayType) extends PairElemType
    case object Pair extends PairElemType with ParserBridge0[Pair]

    sealed trait Expr
    case class IntExpr(value: Int) extends Expr
    case class BoolExpr(value: BooL) extends Expr
    case class CharExpr(value: Char) extends Expr
    case class StrExpr(value: String) extends Expr
    case class PairExpr(value: PairLiteral) extends Expr
    case class IdentifierExpr(id: Identifier) extends Expr
    case class ArrayElemExpr(value: ArrayElemLiteral) extends Expr
    case class UnaryOpExpr(op: UnaryOp, expr: Expr) extends Expr
    case class BinOpExpr(exprLeft: Expr, op: BinOp, exprRight: Expr) extends Expr
    case class ParenExpr(expr: Expr) extends Expr

    sealed trait UnaryOp 
    case object NotOp extends UnaryOp with ParserBridge0[UnaryOp]
    case object NegateOp extends UnaryOp with ParserBridge0[UnaryOp]
    case object LenOp extends UnaryOp with ParserBridge0[UnaryOp]
    case object OrdOp extends UnaryOp with ParserBridge0[UnaryOp]
    case object ChrOp extends UnaryOp with ParserBridge0[UnaryOp]

    sealed trait BinOp
    case object Add extends BinOp with ParserBridge0[BinOp]
    case object Div extends BinOp with ParserBridge0[BinOp]
    case object Mod extends BinOp with ParserBridge0[BinOp]
    case object Mul extends BinOp with ParserBridge0[BinOp]
    case object Sub extends BinOp with ParserBridge0[BinOp]
    case object GreaterThan extends BinOp with ParserBridge0[BinOp]
    case object GreaterOrEqualThan extends BinOp with ParserBridge0[BinOp]
    case object LessThan extends BinOp with ParserBridge0[BinOp]
    case object LessOrEqualThan extends BinOp with ParserBridge0[BinOp]
    case object Equal extends BinOp with ParserBridge0[BinOp]
    case object NotEqual extends BinOp with ParserBridge0[BinOp]
    case object And extends BinOp with ParserBridge0[BinOp]
    case object Or extends BinOp with ParserBridge0[BinOp]

    case class Identifier(id: String)
    
    case class ArrayElemLiteral(id: Identifer, position: List[Expr])

    case class ArrayLiteral(value: List[Expr])

    case object PairLiteral extends ParserBridge0[PairLiteral]

    // Bridges

    object ParamFunc extends ParserBridge4[Type, Identifier, ParamList, StatementUnit, ParamFunc]
    object NiladicFunc extends ParserBridge3[Type, Identifier, StatementUnit, NiladicFunc]

    object ParamList extends ParserBridge1[List[Param], ParamList]

    object Param extends ParserBridge2[Type, Identifer, Param]

    object AssignStat extends ParserBridge3[Type, Identifer, Rvalue, AssignStat]
    object ReassignStat extends ParserBridge2[Lvalue, Rvalue, ReassignStat]
    object FreeStat extends ParserBridge1[Expr, FreeStat]
    object ReturnStat extends ParserBridge1[Expr, ReturnStat]
    object ExitStat extends ParserBridge1[Expr, ExitStat]
    object PrintStat extends ParserBridge1[Expr, PrintStat]
    object PrintlnStat extends ParserBridge1[Expr, PrintlnStat]
    object IfStat extends ParserBridge3[Expr, StatementUnit, StatementUnit, IfStat]
    object WhileStat extends ParserBridge2[Expr, StatementUnit, WhileStat]
    object ScopeStat extends ParserBridge1[StatementUnit, ScopeStat]
    object SeqStat extends ParserBridge2[StatementUnit, StatementUnit, SeqStat]

    object IdentLeft extends ParserBridge1[Identifier,  Lvalue]
    object ArrayElemLeft extends ParserBridge1[ArrayElem, Lvalue]
    object PairElemLeft extends ParserBridge1[PairElem, Lvalue]

    object Fst extends ParserBridge1[Lvalue, PairElem]
    object Snd extends ParserBridge2[Lvalue, PairElem]

    object ExprRight extends ParserBridge1[Expr, Rvalue]
    object ArrayRight extends ParserBridge1[ArrayLiteral, Rvalue]
    object NewPairRight extends ParserBridge2[Expr, Expr, Rvalue]
    object PairElemRight extends ParserBridge1[PairElem, Rvalue]
    object ParamCall extends ParserBridge2[Identifier, ArgList, Rvalue]
    object NiladicCall extends ParserBridge1[Identifier, Rvalue]

    object ArgList extends ParserBridge1[List[Expr], ArgList]

    object ArrayType extends ParserBridge1[Type, ArrayType]

    object PairType extends ParserBridge1[PairElemType, PairElemType, PairType]
    object BasePairElem extends ParserBridge1[BaseType, PairElemType]
    object ArrayPairElem extends ParserBridge1[ArrayType, PairElemType]
    
    object IntExpr extends ParserBridge1[Int, Expr]
    object BoolExpr extends ParserBridge1[Bool, Expr]
    object CharExpr extends ParserBridge1[Char, Expr]
    object StrExpr extends ParserBridge1[String, Expr]
    object PairExpr extends ParserBridge1[PairLiteral, Expr]
    object IdentifierExpr extends ParserBridge1[IntLiteral, Expr]
    object ArrayElemExpr extends ParserBridge1[ArrayElemLiteral, Expr]
    object UnaryOpExpr extends ParserBridge2[UnaryOp, Expr, Expr]
    object BinOpExpr extends ParserBridge3[Expr, BinOp, Expr, Expr]
    object ParenExpr extends ParserBridge1[Expr, Expr]
    
    object Identifier extends ParserBridge1[String, Identifier]
    
    object ArrayElemLiteral extends ParserBridge2[Identifier, List[Expr], ArrayElemLiteral]

    object ArrayLiteral extends ParserBridge1[List[Expr], ArrayLiteral]
}