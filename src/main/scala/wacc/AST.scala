package wacc

import parsley.Parsley

object abstractSyntaxTree {
    import parsley.genericbridges._

    sealed trait ASTNode

    case class WACCprogram(funcs: List[FunctionUnit], stat: StatementUnit) extends ASTNode
    
    sealed trait FunctionUnit extends ASTNode
    case class ParamFunc(t: Type, id: Identifier, params: ParamList, body: StatementUnit) extends FunctionUnit
    case class NiladicFunc(t: Type, id: Identifier, body: StatementUnit) extends FunctionUnit

    case class ParamList(paramlist: List[Param]) extends ASTNode

    case class Param(t: Type, id: Identifier) extends ASTNode

    sealed trait StatementUnit extends ASTNode
    case object SkipStat extends StatementUnit with ParserBridge0[StatementUnit]
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

    sealed trait Lvalue extends ASTNode

    case class PairElem(fst: Lvalue, snd: Lvalue) extends Lvalue with Rvalue

    sealed trait Rvalue extends ASTNode
    sealed trait Expr extends Rvalue
    case class ArrayLiteral(value: List[Expr]) extends Rvalue
    case class NewPair(exprLeft: Expr, exprRight: Expr) extends Rvalue
    sealed trait Call extends Rvalue
    case class ParamCall(id: Identifier, args: ArgList) extends Call
    case class NiladicCall(id: Identifier) extends Call

    case class ArgList(args: List[Expr]) extends ASTNode

    sealed trait Type extends ASTNode
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
    case object NestedPair extends PairElemType with ParserBridge0[PairElemType]

    case class IntExpr(value: BigInt) extends Expr
    case class BoolExpr(value: Boolean) extends Expr
    case class CharExpr(value: Char) extends Expr
    case class StrExpr(value: String) extends Expr
    case object PairLiteral extends Expr with ParserBridge0[Expr]
    case class ArrayElem(id: Identifier, position: List[Expr]) extends Expr with Lvalue
    case class ParenExpr(expr: Expr) extends Expr
    case class Identifier(id: String) extends Expr with Lvalue


    // precedence implemented using number Expr
    // lower number = higher precendece but 0 is used for no precedence i.e. for unary
    sealed trait Expr0 extends Expr1
    sealed trait Expr1 extends Expr2
    sealed trait Expr2 extends Expr3
    sealed trait Expr3 extends Expr4
    sealed trait Expr4 extends Expr5
    sealed trait Expr5 extends Expr6
    sealed trait Expr6 extends Expr

    // Unary Operators
    case class NotOp(expr: Expr0) extends Expr0
    case class NegateOp(expr: Expr0) extends Expr0
    case class LenOp(expr: Expr0) extends Expr0
    case class OrdOp(expr: Expr0) extends Expr0
    case class ChrOp(expr: Expr0) extends Expr0

    // note left-associativitiy so typing is (B,A) => B
    case class Div(exprLeft: Expr1, exprRight: Expr0) extends Expr1
    case class Mod(exprLeft: Expr1, exprRight: Expr0) extends Expr1
    case class Mul(exprLeft: Expr1, exprRight: Expr0) extends Expr1
    case class Add(exprLeft: Expr2, exprRight: Expr1) extends Expr2
    case class Sub(exprLeft: Expr2, exprRight: Expr1) extends Expr2
    case class GreaterThan(exprLeft: Expr3, exprRight: Expr2) extends Expr3
    case class GreaterOrEqualThan(exprLeft: Expr3, exprRight: Expr2) extends Expr3
    case class LessThan(exprLeft: Expr3, exprRight: Expr2) extends Expr3
    case class LessOrEqualThan(exprLeft: Expr3, exprRight: Expr2) extends Expr3
    case class Equal(exprLeft: Expr4, exprRight: Expr4) extends Expr4
    case class NotEqual(exprLeft: Expr4, exprRight: Expr4) extends Expr4
    case class And(exprLeft: Expr5, exprRight: Expr4) extends Expr5
    case class Or(exprLeft: Expr6, exprRight: Expr5) extends Expr6


    // Bridges

    object WACCprogram extends ParserBridge2[List[FunctionUnit], StatementUnit, WACCprogram]

    object ParamFunc extends ParserBridge4[Type, Identifier, ParamList, StatementUnit, ParamFunc]
    object NiladicFunc extends ParserBridge3[Type, Identifier, StatementUnit, NiladicFunc]

    object ParamList extends ParserBridge1[List[Param], ParamList]

    object Param extends ParserBridge2[Type, Identifier, Param]

    object AssignStat extends ParserBridge3[Type, Identifier, Rvalue, AssignStat]
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

    object PairElem extends ParserBridge2[Lvalue, Lvalue, Either[Lvalue, Rvalue]]

    object ArrayLiteral extends ParserBridge1[List[Expr], Rvalue]
    object NewPair extends ParserBridge2[Expr, Expr, Rvalue]
    object ParamCall extends ParserBridge2[Identifier, ArgList, Rvalue]
    object NiladicCall extends ParserBridge1[Identifier, Rvalue]

    object ArgList extends ParserBridge1[List[Expr], ArgList]

    object ArrayType extends ParserBridge1[Type, ArrayType]

    object PairType extends ParserBridge2[PairElemType, PairElemType, PairType]
    object BasePairElem extends ParserBridge1[BaseType, PairElemType]
    object ArrayPairElem extends ParserBridge1[ArrayType, PairElemType]
    
    object IntExpr extends ParserBridge1[BigInt, Expr]
    object BoolExpr extends ParserBridge1[Boolean, Expr]
    object CharExpr extends ParserBridge1[Char, Expr]
    object StrExpr extends ParserBridge1[String, Expr]
    object ArrayElem extends ParserBridge2[Identifier, List[Expr], Either[Lvalue, Expr]]
    object ParenExpr extends ParserBridge1[Expr, Expr]
    object Identifer extends ParserBridge1[String, Either[Lvalue, Expr]]
    // Unary operations
    object NotOp extends ParserBridge1[Expr0, Expr0]
    object NegateOp extends ParserBridge1[Expr0, Expr0]
    object LenOp extends ParserBridge1[Expr0, Expr0]
    object OrdOp extends ParserBridge1[Expr0, Expr0]
    object ChrOp extends ParserBridge1[Expr0, Expr0]
    // Binary operations
    object Div extends ParserBridge2[Expr1, Expr0, Expr1] 
    object Mod extends ParserBridge2[Expr1, Expr0, Expr1] 
    object Mul extends ParserBridge2[Expr1, Expr0, Expr1] 
    object Add extends ParserBridge2[Expr2, Expr1, Expr2] 
    object Sub extends ParserBridge2[Expr2, Expr1, Expr2] 
    object GreaterThan extends ParserBridge2[Expr3, Expr2, Expr3]
    object GreaterOrEqualThan extends ParserBridge2[Expr3, Expr2, Expr3]
    object LessThan extends ParserBridge2[Expr3, Expr2, Expr3]
    object LessOrEqualThan extends ParserBridge2[Expr3, Expr2, Expr3]
    object Equal extends ParserBridge2[Expr4, Expr4, Expr4]
    object NotEqual extends ParserBridge2[Expr4, Expr4, Expr4]
    object And extends ParserBridge2[Expr5, Expr4, Expr5]
    object Or extends ParserBridge2[Expr6, Expr5, Expr6]    
}