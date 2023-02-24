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
    case object PC extends ReservedRegister // AssProg counter

    val generalRegisters = Set(R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10)

    case class Imm(x: Integer) extends Operand
    case class Label(label: String) extends Operand
    case class Offset(reg: Operand, offset: Imm) extends Operand

    sealed trait Opcode
    case object Add extends Opcode
    case object Mov extends Opcode
    case object Ldr extends Opcode
    case object Str extends Opcode
    case object Push extends Opcode
    case object Pop extends Opcode
    case object Sub extends Opcode
    case object Cmp extends Opcode
    case object Mul extends Opcode
    case object And extends Opcode
    case object Or extends Opcode
    
    sealed trait Condition
    case object EQ extends Condition with Opcode
    case object NE extends Condition with Opcode
    case object GE extends Condition with Opcode
    case object LT extends Condition with Opcode
    case object GT extends Condition with Opcode
    case object LE extends Condition with Opcode
    
    sealed trait AssInstr
    // General convention being dest src src1 ...
    case class QuaternaryAssInstr(op: Opcode, cond: Option[Condition], op1: Operand, op2: Operand, op3: Operand, op4: Operand) extends AssInstr
    case class TernaryAssInstr(op: Opcode, cond: Option[Condition], op1: Operand, op2: Operand, op3: Operand) extends AssInstr
    case class BinaryAssInstr(op: Opcode, cond: Option[Condition], op1: Operand, op2: Operand) extends AssInstr
    case class UnaryAssInstr(op: Opcode, cond: Option[Condition], op1: Operand) extends AssInstr
    case class MultiAssInstr(op: Opcode, operands: List[Operand]) extends AssInstr
    case class BranchLinked(function: String) extends AssInstr

    case class AssProg(blocks: List[Block])
    case class Block(label: Label, instrs: List[AssInstr])
}