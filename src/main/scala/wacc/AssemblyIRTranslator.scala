package wacc

class AssemblyIRTranslator {
  import intermediaryCompileStructure._
  import assemblyIR._
  import scala.collection.mutable.{Map, ListBuffer, Set}

  val functions: ListBuffer[Block] = new ListBuffer[Block]()
  val stringLabelMap: Map[Label, String] = Map.empty[Label, String]
  val usedFunctions: Set[InBuilt] = Set.empty
  var labelCount: Int = 0
  var stringLabelCount: Int = 0

  def generateLabel(): String = {
    val ret = s".L${labelCount.toString}"
    labelCount = labelCount + 1
    ret
  }

  def generateStringLabel(): String = {
    val ret = s".L.str${stringLabelCount.toString}"
    stringLabelCount = stringLabelCount + 1
    ret
  }

  def translate(program: Program): (AssProg, Set[InBuilt], List[Block], Map[Label,String]) = {
    val main = translateMain(program.main)
    val funcs = program.functions.map(translateFunction)
    funcs.map(b => functions.addOne(b))
    (AssProg(main +: funcs), usedFunctions, functions.toList, stringLabelMap)
  }

  def translateMain(instrs: List[Instr]): Block = {
    val assembly = new ListBuffer[AssInstr] 
    val alloc = new RegisterAllocator()
    instrs.map(i => translateInstruction(i, alloc, assembly))
    Block(Label("main"), assembly.toList)
  }

  // Requires there to be 4 or more registers in the general register set
  def translateInstruction(instr: Instr, allocator: RegisterAllocator, lb: ListBuffer[AssInstr]): Unit = instr match {
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
          translateMove(Offset(R1, Imm(-4), Word), dstOp, lb)
        }
        case A_Chr => {
           lb += BinaryAssInstr(Mov, None, dstOp, srcOp)
        }
        case A_Ord => {
          lb += BinaryAssInstr(Mov, None, dstOp, srcOp)
        }
        case A_Mov => {
          translateMove(R1, dstOp, lb)
        }
        case A_Load => {
          lb += BinaryAssInstr(Ldr(Word), None, dstOp, srcOp)
        }
        case A_Malloc => {
          translateMove(srcOp, Return, lb)
          lb += BranchLinked(Malloc, None)
        }
      }
    }
    case BinaryOperation(operator, src1, src2, dest) => {
      val src1Op = translateValue(src1, allocator, lb)
      val src2Op = translateValue(src2, allocator, lb)
      val dstOp = translateValue(dest, allocator, lb) 
      operator match {
        case A_Add => {
          usedFunctions.addOne(Overflow)
          usedFunctions.addOne(PrintS)
          lb += TernaryAssInstr(Add, None, dstOp, src1Op, src2Op)
          lb += BranchLinked(Overflow, Some(VS))
        }
        case A_Sub => {
          usedFunctions.addOne(Overflow)
          usedFunctions.addOne(PrintS)
          lb += TernaryAssInstr(Sub, None, dstOp, src1Op, src2Op)
          lb += BranchLinked(Overflow, Some(VS))
        }
        case A_Mul => {
          usedFunctions.addOne(Overflow)
          usedFunctions.addOne(PrintS)
          lb += QuaternaryAssInstr(Smull, None, dstOp, R1, src1Op, src2Op)
          lb += BinaryAssInstr(Cmp, None, R1, Imm(0))
          lb += BranchLinked(Overflow, Some(GT))
        }
        case A_Div => {
          val (saveRegs, restoreRegs) = allocator.saveArgs(List(R1))
          usedFunctions.addOne(DivZero)
          usedFunctions.addOne(PrintS)
          lb.addAll(saveRegs)
          lb += BinaryAssInstr(Mov, None, Return, src1Op)
          lb += BinaryAssInstr(Mov, None, R1, src2Op)
          lb += BinaryAssInstr(Cmp, None, R1, Imm(0))
          lb += BranchLinked(DivZero, Some(EQ))
          lb += BranchLinked(DivMod, None)
          lb += BinaryAssInstr(Mov, None, dstOp, Return)
          lb.addAll(restoreRegs)
        }
        case A_Mod => {
          val (saveRegs, restoreRegs) = allocator.saveArgs(List(R1))
          usedFunctions.addOne(DivZero)
          usedFunctions.addOne(PrintS)
          lb.addAll(saveRegs)
          lb += BinaryAssInstr(Mov, None, Return, src1Op)
          lb += BinaryAssInstr(Mov, None, R1, src2Op)
          lb += BinaryAssInstr(Cmp, None, R1, Imm(0))
          lb += BranchLinked(DivZero, Some(EQ))
          lb += BranchLinked(DivMod, None)
          lb += BinaryAssInstr(Mov, None, dstOp, R1)
          lb.addAll(restoreRegs)
        }
        case A_And => {
          lb += TernaryAssInstr(And, None, dstOp, src1Op, src2Op)
        }
        case A_Or => {
          lb += TernaryAssInstr(Or, None, dstOp, src1Op, src2Op)
        }
        case A_EQ => {
          lb += BinaryAssInstr(Cmp, None, src1Op, src2Op)
          lb += BinaryAssInstr(Mov, Some(EQ), dstOp, ir_true)
          lb += BinaryAssInstr(Mov, Some(NE), dstOp, ir_false)
        }
        case A_NEQ => {
          lb += BinaryAssInstr(Cmp, None, src1Op, src2Op)
          lb += BinaryAssInstr(Mov, Some(NE), dstOp, ir_true)
          lb += BinaryAssInstr(Mov, Some(EQ), dstOp, ir_false)
        }
        case A_GTE => {
          lb += BinaryAssInstr(Cmp, None, src1Op, src2Op)
          lb += BinaryAssInstr(Mov, Some(GE), dstOp, ir_true)
          lb += BinaryAssInstr(Mov, Some(LT), dstOp, ir_false)
        }
        case A_GT => {
          lb += BinaryAssInstr(Cmp, None, src1Op, src2Op)
          lb += BinaryAssInstr(Mov, Some(GT), dstOp, ir_true)
          lb += BinaryAssInstr(Mov, Some(LE), dstOp, ir_false)
        }
        case A_LTE => {
          lb += BinaryAssInstr(Cmp, None, src1Op, src2Op)
          lb += BinaryAssInstr(Mov, Some(LE), dstOp, ir_true)
          lb += BinaryAssInstr(Mov, Some(GT), dstOp, ir_false)
        }
        case A_LT => {
          lb += BinaryAssInstr(Cmp, None, src1Op, src2Op)
          lb += BinaryAssInstr(Mov, Some(LT), dstOp, ir_true)
          lb += BinaryAssInstr(Mov, Some(GE), dstOp, ir_false)
        }
      }     
    }
    case ScopeInstruction(body) => {
      val preScope = allocator.getState()
      val resetRegs = allocator.reloadState(preScope)
      body.map(i => translateInstruction(i, allocator, lb))
      lb.addAll(resetRegs)
    }
    case IfInstruction(condition, ifInstructions, elseInstructions) => {
      val preIf = allocator.getState()
      val elseLabel = generateLabel()
      val endLabel = generateLabel()
      condition.body.map(i => translateInstruction(i, allocator, lb))
      val cond = translateCond(condition.cond)
      lb += Branch(elseLabel, Some(cond))
      val resetRegs = allocator.reloadState(preIf)
      val ifBuf = new ListBuffer[AssInstr]()
      val elseBuf = new ListBuffer[AssInstr]()
      
      ifInstructions.map(i => translateInstruction(i, allocator, ifBuf))
      ifBuf.addAll(resetRegs)
      ifBuf += Branch(endLabel, None)
      elseBuf += NewLabel(elseLabel)
      elseInstructions.map(i => translateInstruction(i, allocator, elseBuf))
      elseBuf.addAll(resetRegs)
      elseBuf += NewLabel(endLabel)

      lb.addAll(ifBuf)
      lb.addAll(elseBuf)
    }
    case WhileInstruction(condition, body) => {
      val preWhile = allocator.getState()
      val condLabel = generateLabel()
      val bodyLabel = generateLabel()
      val endLabel = generateLabel()
      val cond = translateCond(condition.cond)
      lb += Branch(condLabel, None)
      lb += NewLabel(bodyLabel)
      body.map(i => translateInstruction(i, allocator, lb))
      lb += NewLabel(condLabel)
      condition.body.map(i => translateInstruction(i, allocator, lb))
      Branch(bodyLabel, Some(cond))
      lb += NewLabel(endLabel)
      lb.addAll(allocator.reloadState(preWhile))
    }
    case FunctionCall(functionName, args, returnTo) => {
      // Set arguments into the stack and then branch linked
      for ((arg, i) <- args.zipWithIndex) {
        val op = translateValue(arg, allocator, lb)
        if (i < 4) {
          translateMove(op, argumentRegisters(i), lb)
        } else {
          lb += UnaryAssInstr(Push, None, op)
        }
        allocator.clearReserve()
      }
      val returnOp = translateValue(returnTo, allocator, lb)
      lb += Branch(functionName, None)
      translateMove(Return, returnOp, lb)
    }
    case InbuiltFunction(operator, src) => {
      val srcOp = translateValue(src, allocator, lb)
      translateMove(srcOp, Return, lb)
      val inbuilt = translateInbuilt(operator, src)
      BranchLinked(inbuilt, None)
    }
    allocator.clearReserve()
  } 

  def translateFunction(function: WaccFunction): Block = {
    val funcBuffer = new ListBuffer[AssInstr]()
    val allocator = new RegisterAllocator()
    val retrieveArgs = allocator.loadArgs(function.args.map(p => p.id))
    function.body.map(i => translateInstruction(i, allocator, funcBuffer))
    val (pref, suff) = allocator.generateBoilerPlate()
    funcBuffer.prependAll(retrieveArgs)
    funcBuffer.prependAll(pref)
    funcBuffer.addAll(suff)
    Block(Label(function.id), funcBuffer.toList)
  }

  def translateValue(value: Value, allocator: RegisterAllocator, lb: ListBuffer[AssInstr]): Operand = value match {
      case Access(pointer, access, t) => {
        val pointOp = translateValue(pointer, allocator, lb)
        val accOp = translateValue(access, allocator, lb)
        Offset(pointOp, accOp, translateType(t))
      }
      case Immediate(value) => Imm(value)
      case Character(value) => Imm(value)
      case IntermediateValue(id, tiepe) => {
        val (instrs, op) = allocator.getRegister(s"__$id")
        lb.addAll(instrs)
        op
      }
      case Stored(id, tiepe) => {
        val (instrs, op) = allocator.getRegister(id)
        lb.addAll(instrs)
        op
      }
      case StringLiteral(value) => {
        val stringLabel = generateStringLabel()
        stringLabelMap.addOne((Label(stringLabel), value.flatMap(escapedChar)))
        Label(stringLabel)
      }
  }

  def translateType(tiepe: IntermediateType): Type = tiepe match {
    case BoolType => Byte
    case CharType => Byte
    case _ => Word
  }

  def getTypeFromValue(value: Value): IntermediateType = value match {
    case Access(pointer, access, t) => PointerType
    case Immediate(value) => IntType
    case Character(value) => CharType
    case IntermediateValue(id, tiepe) => tiepe
    case Stored(id, tiepe) => tiepe
    case StringLiteral(value) => StringType
  }

  def translateMove(src: Operand, dst: Operand, lb: ListBuffer[AssInstr]) = {
    dst match {
      case Label(label) => throw new Exception("Warning, you're stupid") 
      case r: Register => src match {
        case Label(label) => BinaryAssInstr(Ldr(Word), None, dst, src)
        case r: Register => BinaryAssInstr(Mov, None, dst, src)
        case Imm(x) => {
          if (x > 255 || x < -255) {
            lb += BinaryAssInstr(Ldr(Word), None, dst, src)
          } else {
            lb += BinaryAssInstr(Mov, None, dst, src)
          }
        }
        case Offset(reg, offset, t) => BinaryAssInstr(Ldr(t), None, dst, src)
      }
      case Imm(x) => throw new Exception("Imagine being this stupid")
      case Offset(reg, offset, t) => src match {
        case Label(label) => BinaryAssInstr(Str(t), None, dst, src)
        case r: Register => BinaryAssInstr(Str(t), None, dst, src)
        case Imm(x) => {
          if (x > 255 || x < 0) {
            lb += BinaryAssInstr(Ldr(Word), None, Return, src)
            lb += BinaryAssInstr(Str(t), None, dst, Return)
          } else {
            lb += BinaryAssInstr(Str(t), None, dst, src)
          }
        }
        case Offset(reg, offset, t2) => {
          BinaryAssInstr(Ldr(t2), None, Return, src)
          BinaryAssInstr(Str(t), None, dst, Return)
        }
      }
    }
  }

  def translateCond(cond: A_Condition): Condition = cond match {
    case A_GT =>  GT
    case A_GTE => GE
    case A_LT => LT
    case A_LTE => LE
    case A_EQ => EQ
    case A_NEQ => NE
  }

  def translateInbuilt(inbuilt: AssemblyIOperator, v: Value): InBuilt = inbuilt match {
    case A_Exit => Exit
    case A_Read => {
      val vtype = getTypeFromValue(v)
      vtype match {
        case IntType => ReadI
        case _ => ReadC
      }
    }
    case A_Print => {
      val vtype = getTypeFromValue(v)
      vtype match {
        case PointerType => PrintCA
        case IntType => PrintI
        case CharType => PrintC
        case StringType => PrintS
        case BoolType => PrintB
      }
    }
    case A_Malloc => Malloc
    case A_Println => PrintLn
    case A_Len => Len
    case A_Free => Free
    case A_Return => Ret
  }

  def escapedChar(c: Char): String = c match {
        case '"'  => "\\\""
        case '\'' => "\\\'"
        case '\\' => "\\\\"
        case '\b' => "\\b"
        case '\n' => "\\n"
        case '\f' => "\\f"
        case '\r' => "\\r"
        case '\t' => "\\t"
        case _    => String.valueOf(c)
  }
}