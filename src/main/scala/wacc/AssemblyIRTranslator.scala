package wacc

class AssemblyIRTranslator {
  import intermediaryCompileStructure._
  import assemblyIR._
  import scala.collection.mutable.Map
  import scala.collection.mutable.ListBuffer

  val functionMap: Map[Label, Block] = Map.empty[Label, Block]

  def translate(program: Program): AssProg = {
    val main = translateMain(program.main)
    val funcs = program.functions.map(translateFunction)
    funcs.map(b => functionMap.addOne(b.label, b))
    AssProg(main +: funcs)
  }

  def translateMain(instrs: List[Instr]): Block = {
    val assembly = new ListBuffer[AssInstr] 
    val alloc = new RegisterAllocator()
    instrs.map(i => translateInstruction(i, alloc, assembly))
    Block(Label("main"), assembly.toList)
  }

  // Requires there to be 4 or more registers in the general register set
  def translateInstruction(instr: Instr, allocator: RegisterAllocator, lb: ListBuffer[AssInstr]) = instr match {
    case UnaryOperation(operator, src, dest) => {
      val srcOp = translateValue(src, allocator, lb)
      val dstOp = translateValue(dest, allocator, lb)
      operator match {
        case A_Cmp => {
          lb += BinaryAssInstr(Cmp, None, dstOp, srcOp)
        }
        case A_Not => {
          lb += BinaryAssInstr(Cmp, None, srcOp, ir_true)
          lb += BinaryAssInstr(Mov, Some(NE), dstOp, ir_true)
          lb += BinaryAssInstr(Mov, Some(EQ), dstOp, ir_false)
        }
        case A_Neg => {
          lb += TernaryAssInstr(RightSub, None, dstOp, srcOp, Imm(0))
        }
        case A_Len => {
          // Fuck this one 
        }
        case A_Chr => {
           lb += BinaryAssInstr(Mov, None, dstOp, srcOp)
        }
        case A_Ord => {
          lb += BinaryAssInstr(Mov, None, dstOp, srcOp)
        }
        case A_Mov => {

        }
        case A_Load => {
          
        }
        case A_Malloc => {
          
        }
      }
    }
    case BinaryOperation(operator, src1, src2, dest) => {
      NewLabel("I'm sure edoardo could perform a binary operation with me ;)")
    }
    case ScopeInstruction(body) => {
      NewLabel("hehe")
    }
    case IfInstruction(condition, ifInstructions, elseInstructions) => {
      NewLabel("if edoardo dies I will die also")
    }
    case WhileInstruction(condition, body) => {
      NewLabel("while edoardo lives I will love him")
    }
    case FunctionCall(functionName, args, returnTo) => {
      NewLabel("edoardo can call me anytime :)")

    }
    case InbuiltFunction(operator, src) => {
      NewLabel("mmmm eddie mmmm")
    }
    allocator.clearReserve()
  }

  def translateFunction(function: WaccFunction): Block = {
    Block(Label(function.id), Nil)
  }

  def translateValue(value: Value, allocator: RegisterAllocator, lb: ListBuffer[AssInstr]): Operand = {
    value match {
      case Access(pointer, access) => Imm(0)
      case Immediate(value) => Imm(value)
      case IntermediateValue(id, tiepe) => Imm(0)
      case Stored(id, tiepe) => Imm(0)
      case StringLiteral(value) => Imm(0)
    }
  }

  def translateMove(src: Operand, dst: Operand, lb: ListBuffer[AssInstr]) = {
    dst match {
      case Label(label) => throw new Exception("Warning, you're stupid") 
      case r: Register => src match {
        case Label(label) =>
        case r: Register =>
        case Imm(x) => 
        case Offset(reg, offset) =>
      }
      case Imm(x) => throw new Exception("Imagine being this stupid")
      case Offset(reg, offset) => src match {
        case Label(label) =>
        case r: Register =>
        case Imm(x) => 
        case Offset(reg, offset) =>
      }
    }
  }

}
