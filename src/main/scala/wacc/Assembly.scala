package wacc

object assemblyCode {
    sealed trait Operand

    sealed trait Register extends Operand
    sealed trait GeneralRegister extends Register
    sealed trait ReservedRegister extends Register
    case object R0 extends GeneralRegister
    case object R1 extends GeneralRegister
    case object R2 extends GeneralRegister
    case object R3 extends GeneralRegister
    case object R4 extends GeneralRegister
    case object R5 extends GeneralRegister
    case object R6 extends GeneralRegister
    case object R7 extends GeneralRegister
    case object R8 extends GeneralRegister
    case object R9 extends GeneralRegister
    case object R10 extends GeneralRegister
    case object FP extends ReservedRegister // frame pointer
    case object IPC extends ReservedRegister // intra procedural call
    case object SP extends ReservedRegister // stack pointer
    case object LR extends ReservedRegister // link register
    case object PC extends ReservedRegister // program counter

    val generalRegisters = Set(R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10)

    case class Immediate(x: Integer) extends Operand
    case class Label(label: String) extends Operand
    case class Offset(reg: Reg, offset: Immediate) extends Operand

    sealed trait Opcode
    case object Add extends Opcode
    case object Mov extends Opcode
    case object BL extends Opcode
    case object Ldr extends Opcode
    case object Str extends Opcode
    case object Push extends Opcode
    case object Pop extends Opcode
    case object Sub extends Opcode
    case object Cmp extends Opcode
    case object Mul extends Opcode
    
    sealed trait Condition
    case object EQ extends Condition
    case object NE extends Condition
    case object GE extends Condition
    case object LT extends Condition
    case object GT extends Condition
    case object LE extends Condition
    
    sealed trait Block(label: Label, instructions: List[Instruction])

    sealed trait Instruction
    case class QuaternaryInstruction(op: Opcode, cond: Condition, op1: Operand, op2: Operand, op3: Operand, op4: Operand) extends Instruction
    case class TernaryInstruction(op: Opcode, cond: Condition, op1: Operand, op2: Operand, op3: Operand) extends Instruction
    case class BinaryInstruction(op: OpCode, cond: Condition, op1: Operand, op2: Operand, op3: Operand) extends Instruction
    case class UnaryInstruction(op: OpCode, cond: Condition, op1: Operand) extends Instruction
    case class MultiInstruction(op: OpCode, operands: List[Operand]) extends Instruction
}