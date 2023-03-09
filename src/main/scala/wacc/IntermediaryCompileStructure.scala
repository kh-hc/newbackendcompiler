package wacc

object intermediaryCompileStructure {
    case class Program(main: List[Instr], functions: List[WaccFunction])
    case class WaccFunction(id: String, body: List[Instr], args: List[Stored])

    sealed trait IntermediateType
    case object IntType extends IntermediateType
    case object BoolType extends IntermediateType
    case object StringType extends IntermediateType
    case object CharType extends IntermediateType
    case object PointerType extends IntermediateType

    sealed trait Value
    sealed trait BaseValue extends Value
    case class Immediate(value: Int) extends BaseValue
    case class Stored(id: String, tiepe: IntermediateType) extends BaseValue
    case class IntermediateValue(id: Int, tiepe: IntermediateType) extends BaseValue
    
    case class StringLiteral(value: String) extends BaseValue
    case class Access(pointer: BaseValue, access: Value) extends Value

    val a_true = Immediate(1)
    val a_false = Immediate(0)

    sealed trait Instr
    case class BinaryOperation(operator: AssemblyBOperator, src1: Value, src2: Value, dest: Value) extends Instr
    case class UnaryOperation(operator: AssemblyUOperator, src: Value, dest: Value) extends Instr
    case class InbuiltFunction(operator: AssemblyIOperator, src: Value) extends Instr
    case class FunctionCall(functionName: String, args: List[Value], returnTo: Value) extends Instr

    case class IfInstruction(condition: Conditional, ifInstructions: List[Instr], elseInstructions: List[Instr]) extends Instr
    case class WhileInstruction(condition: Conditional, body: List[Instr]) extends Instr
    case class ScopeInstruction(body: List[Instr]) extends Instr

    case class Conditional(cond: Condition, body: List[Instr])

    sealed trait AssemblyUOperator
    sealed trait AssemblyBOperator
    sealed trait AssemblyIOperator
    sealed trait Condition
     
    case object A_Add extends AssemblyBOperator
    case object A_Sub extends AssemblyBOperator
    case object A_Mul extends AssemblyBOperator
    case object A_Div extends AssemblyBOperator
    case object A_Mod extends AssemblyBOperator
    case object A_Cmp extends AssemblyUOperator // Unary operation where src = src1, dest = src2 
    case object A_And extends AssemblyBOperator with Condition
    case object A_Or extends AssemblyBOperator with Condition
    case object A_GT extends AssemblyBOperator with Condition
    case object A_GTE extends AssemblyBOperator with Condition
    case object A_LT extends AssemblyBOperator with Condition
    case object A_LTE extends AssemblyBOperator with Condition
    case object A_EQ extends AssemblyBOperator with Condition
    case object A_NEQ extends AssemblyBOperator with Condition
    case object A_Not extends AssemblyUOperator with Condition
    case object A_Neg  extends AssemblyUOperator
    case object A_Len extends AssemblyUOperator with AssemblyIOperator
    case object A_Chr extends AssemblyUOperator
    case object A_Ord extends AssemblyUOperator
    case object A_Mov extends AssemblyUOperator
    case object A_Load extends AssemblyUOperator
    case object A_Print extends AssemblyIOperator
    case object A_Println extends AssemblyIOperator
    case object A_Read extends AssemblyIOperator
    case object A_Free extends AssemblyIOperator
    case object A_Return extends AssemblyIOperator
    case object A_Malloc extends AssemblyIOperator with AssemblyUOperator
    case object A_Exit extends AssemblyIOperator
}