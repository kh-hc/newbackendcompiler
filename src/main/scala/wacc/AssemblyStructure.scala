package wacc

/*
Assembly language abstract structure.
This will be used to help translate the AST into Assembly language.
*/

object assemblyAbstractStructure {
    case class Program(main: List[Instruction], functions: List[Function])
    case class Function(id: String, body: List[Instruction], args: List[Stored])

    sealed trait Instruction
    
    case class BinaryOperation(operator: AssemblyOperator, src1: Value, src2: Value, dest: Value) extends Instruction
    case class UnaryOperation(operator: AssemblyOperator, src: Value, dest: Value) extends Instruction
    case class InbuiltFunction(operator: AssemblyOperator, src: Value) extends Instruction
    case class FunctionCall(functionName: String, args: List[Value], returnTo: Value) extends Instruction

    case class IfInstruction(condition: Conditional, ifInstructions: List[Instruction], elseInstructions: List[Instruction]) extends Instruction
    case class WhileInstruction(condition: Conditional, body: List[Instruction]) extends Instruction

    case class Conditional(value: Value, conditions: List[Instruction])

    sealed trait Value
    case class Stored(id: String) extends Value
    case class Immediate(value: Int) extends Value
    case class StringLiteral(value: String) extends Value
    case object Null extends Value

    case class PairAccess(pos: PairPos, pair: Value) extends Value
    case class ArrayAccess(pos: List[Value], array: Stored) extends Value

    sealed trait PairPos
    case object Fst extends PairPos
    case object Snd extends PairPos

    sealed trait AssemblyOperator
    case object A_Add extends AssemblyOperator
    case object A_Sub extends AssemblyOperator
    case object A_Mul extends AssemblyOperator
    case object A_Div extends AssemblyOperator
    case object A_Mod extends AssemblyOperator
    case object A_And extends AssemblyOperator
    case object A_Or extends AssemblyOperator
    case object A_GT extends AssemblyOperator
    case object A_GTE extends AssemblyOperator
    case object A_LT extends AssemblyOperator
    case object A_LTE extends AssemblyOperator
    case object A_EQ extends AssemblyOperator
    case object A_NEQ extends AssemblyOperator
    case object A_Not extends AssemblyOperator
    case object A_Neg  extends AssemblyOperator
    case object A_Len extends AssemblyOperator
    case object A_Chr extends AssemblyOperator
    case object A_Ord extends AssemblyOperator
    case object A_Print extends AssemblyOperator
    case object A_Println extends AssemblyOperator
    case object A_Assign extends AssemblyOperator
    case object A_Read extends AssemblyOperator
    case object A_Free extends AssemblyOperator
    case object A_Return extends AssemblyOperator
    case object A_Exit extends AssemblyOperator
    case object A_ArrayCreate extends AssemblyOperator // src: Length, dst: Addr
    case object A_PairCreate extends AssemblyOperator // src: Addr
}
