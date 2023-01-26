object ast {
    case class WACCprogram(funcs: List[FunctionUnit], stat: StatementUnit)
    
    sealed trait FunctionUnit
    case class ParamFunc(t: Type, id: Identifier, params: Paramlist, body: StatementUnit) extends FunctionUnit
    case class NiladicFunc(t: Type, id: Identifier, body: StatementUnit)

    case class Paramlist(paramlist: List[Param])

    case class Param(t: Type, id: Identifier)

    sealed trait StatementUnit
    case object SkipStat extends StatementUnit
    sealed trait AssignmentStat extends StatementUnit
    case class AssignStat(t: Type, id: Identifier, value: Rvalue) extends AssignmentStat
    case class ReassignStat(left: Lvalue, right: Rvalue) extends AssignmentStat
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
    case object IntT extends BaseType
    case object BoolT extends BaseType
    case object CharT extends BaseType
    case object StringT extends BaseType

    case class ArrayType(t: Type) extends Type

    case class PairType(left: PairElemType, right: PairElemType) extends Type
    sealed trait PairElemType
    case class BasePairElem(t: BaseType) extends PairElemType
    case class ArrayPairElem(t: ArrayType) extends PairElemType
    case object Pair extends PairElemType

    sealed trait Expr
    case class IntExpr(value: IntLiteral) extends Expr
    case class BoolExpr(value: BoolLiteral) extends Expr
    case class CharExpr(value: CharLiteral) extends Expr
    case class StrExpr(value: StringLiteral) extends Expr
    case class PairExpr(value: PairLiteral) extends Expr
    case class IdentifierExpr(id: Identifier) extends Expr
    case class ArrayElemExpr(value: ArrayElemLiteral) extends Expr
    case class UnaryOpExpr(op: UnaryOp, expr: Expr) extends Expr
    case class BinOpExpr(exprLeft: Expr, op: BinOp, exprRight: Expr) extends Expr
    case class ParenExpr(expr: Expr) extends Expr

    sealed trait UnaryOp 
    case object NotOp extends UnaryOp
    case object NegateOp extends UnaryOp
    case object LenOp extends UnaryOp
    case object OrdOp extends UnaryOp
    case object ChrOp extends UnaryOp

    sealed trait BinOp
    case object Add extends BinOp
    case object Div extends BinOp 
    case object Mod extends BinOp
    case object Mul extends BinOp
    case object Sub extends BinOp
    case object GreaterThan extends BinOp
    case object GreaterOrEqualThan extends BinOp
    case object LessThan extends BinOp
    case object LessOrEqualThan extends BinOp
    case object Equal extends BinOp
    case object NotEqual extends BinOp
    case object And extends BinOp
    case object Or extends BinOp

    case class Identifier(id: String)
    
    case class ArrayElemLiteral(id: Identifer, position: List[Expr])
    
    case class IntLiteral(value: Int)
    case class BoolLiteral(value: Bool) 
    case class CharLiteral(value: Char) 
    case class StringLiteral(value: String)

    case class ArrayLiteral(value: List[Expr])

    case object PairLiteral
}