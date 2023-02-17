package wacc


/*
Assembly language abstract structure.
This will be used to help translate the AST into Assembly language.
*/


object assemblyAbstractStructure {
    case class Program(main: Function, functions: List[Function])
    case class Function(body: List[Instruction], args: List[Stored])

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

    case class PairAccess(pos: PairPos, pair: Value) extends Value
    case class ArrayAccess(pos: List[Value], array: Stored) extends Value

    sealed trait PairPos
    case object Fst extends PairPos
    case object Snd extends PairPos

    sealed trait AssemblyOperator
    case object Add extends AssemblyOperator
    case object Sub extends AssemblyOperator
    case object Mul extends AssemblyOperator
    case object Div extends AssemblyOperator
    case object Print extends AssemblyOperator
    case object Println extends AssemblyOperator
    case object Assign extends AssemblyOperator
    case object Read extends AssemblyOperator
    case object Free extends AssemblyOperator
    case object Return extends AssemblyOperator
    case object Exit extends AssemblyOperator
    case object ArrayCreate extends AssemblyOperator // src: Length, dst: Addr
    case object PairCreate extends AssemblyOperator // src: Addr
}
