package wacc


/*
Assembly language abstract structure.
This will be used to help translate the AST into Assembly language.
*/


object assemblyAbstractStructure {
    case class Program(main: Function, functions: List[Function])
    case class Function(body: List[Instruction])

    sealed trait Instruction
    
    case class BinaryOperation(operator: AssemblyOperator, src1: Value, src2: Value, dest: Value) extends Instruction
    case class UnaryOperation(operator: AssemblyOperator, src: Value, dest: Value)
    case class FunctionCall(functionName: String, args: List[Value])

    case class IfInstruction(condition: Conditional, ifInstructions: List[Instruction], elseInstructions: List[Instruction])
    case class WhileInstruction(condition: Conditional, body: List[Instruction])

    case class Conditional(operator: AssemblyOperator, src1: Value, src2: Value)

    sealed trait Value
    case class Stored(id: String) extends Value
    case class Immediate(value: Int) extends Value
    case class StringLiteral(value: String) extends Value
    case class PairAccess(pos: PairPos, pair: Stored) extends Value
    case class ArrayAccess(pos: List[Int], array: Stored) extends Value

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
}
