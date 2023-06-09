package wacc

object assemblyIR {
    sealed trait Operand

    sealed trait Register extends Operand
    sealed trait GeneralRegister extends Register
    sealed trait ReservedRegister extends Register
    case object Return extends ReservedRegister // R0
    case object R1 extends GeneralRegister // Used for access
    case object R2 extends GeneralRegister // used for expressions
    case object R3 extends GeneralRegister // used for expressions
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

    val generalRegisters = Set(R4, R5, R6, R7, R8, R9, R10)
    val argumentRegisters = Map(0 -> Return, 1 -> R1, 2 -> R2, 3 -> R3)

    case class Imm(x: Integer) extends Operand
    case class Label(label: String) extends Operand
    case class Offset(reg: Operand, offset: Operand, tiepe: Type) extends Operand

    val ir_true = Imm(1)
    val ir_false = Imm(0)

    sealed trait Type
    case object Byte extends Type
    case object Word extends Type

    sealed trait Opcode
    case object Add extends Opcode
    case object Mov extends Opcode
    case class Ldr(opType: Type) extends Opcode
    case class Str(opType: Type) extends Opcode // NOTE: arguments otherway around with str
    case object Push extends Opcode
    case object Pop extends Opcode
    case object Sub extends Opcode
    case object Cmp extends Opcode
    case object Mul extends Opcode
    case object Smull extends Opcode
    case object And extends Opcode
    case object Or extends Opcode
    case object RightSub extends Opcode

    sealed trait Condition
    case object EQ extends Condition with Opcode
    case object NE extends Condition with Opcode
    case object GE extends Condition with Opcode
    case object LT extends Condition with Opcode
    case object GT extends Condition with Opcode
    case object LE extends Condition with Opcode
    case object VS extends Condition with Opcode

    sealed trait InBuilt
    case object PrintI extends InBuilt
    case object PrintB extends InBuilt
    case object PrintC extends InBuilt
    case object PrintS extends InBuilt
    case object PrintA extends InBuilt
    case object PrintCA extends InBuilt
    case object PrintLn extends InBuilt
    case object ReadI extends InBuilt
    case object ReadC extends InBuilt
    case object DivMod extends InBuilt
    case object DivZero extends InBuilt
    case object Exit extends InBuilt
    case object Free extends InBuilt
    case object FreePair extends InBuilt
    case object Overflow extends InBuilt
    case object NullError extends InBuilt
    case object Malloc extends InBuilt
    case object OutOfBound extends InBuilt
    case object Ret extends InBuilt
    case object Len extends InBuilt
    
    sealed trait AssInstr
    // General convention being dest src src1 ...
    case class QuaternaryAssInstr(op: Opcode, cond: Option[Condition], op1: Operand, op2: Operand, op3: Operand, op4: Operand) extends AssInstr
    case class TernaryAssInstr(op: Opcode, cond: Option[Condition], op1: Operand, op2: Operand, op3: Operand) extends AssInstr
    case class BinaryAssInstr(op: Opcode, cond: Option[Condition], op1: Operand, op2: Operand) extends AssInstr
    case class UnaryAssInstr(op: Opcode, cond: Option[Condition], op1: Operand) extends AssInstr
    case class MultiAssInstr(op: Opcode, operands: List[Operand]) extends AssInstr
    case class BranchLinked(function: InBuilt, cond: Option[Condition]) extends AssInstr
    case class Branch(function: String, cond: Option[Condition]) extends AssInstr
    case class BL(function: String, cond: Option[Condition]) extends AssInstr
    case class CallFunction(function: String) extends AssInstr
    case class NewLabel(label: String) extends AssInstr

    case class AssProg(blocks: List[Block])
    case class Block(label: Label, instrs: List[AssInstr])
}
