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
  val defaultIntSize: Int = 4

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
    (AssProg(main +: funcs), usedFunctions, functions.toList, stringLabelMap)
  }

  def translateMain(instrs: List[Instr]): Block = {
    val assembly = new ListBuffer[AssInstr] 
    val alloc = new RegisterAllocator()
    instrs.map(i => translateInstruction(i, alloc, assembly))
    val (pref, suff) = alloc.generateBoilerPlate()
    assembly.prependAll(pref)
    translateMove(Imm(0), Return, assembly)
    assembly.appendAll(suff)
    Block(Label("main"), assembly.toList)
  }

  // Requires there to be 4 or more registers in the general register set
  def translateInstruction(instr: Instr, allocator: RegisterAllocator, lb: ListBuffer[AssInstr]): Unit = instr match {
    case UnaryOperation(operator, src, dest) => {
      val srcOp = translateValueInto(src, allocator, lb, R1)
      val dstOp = translateValue(dest, allocator, lb)
      operator match {
        case A_Cmp => {
          lb += BinaryAssInstr(Cmp, None, srcOp, dstOp)
        }
        case A_Not => {
          lb += BinaryAssInstr(Cmp, None, srcOp, ir_true)
          lb += BinaryAssInstr(Mov, Some(NE), dstOp, ir_true)
          lb += BinaryAssInstr(Mov, Some(EQ), dstOp, ir_false)
        }
        case A_Neg => {
          usedFunctions.addOne(Overflow)
          usedFunctions.addOne(PrintS)
          lb += TernaryAssInstr(RightSub, None, dstOp, srcOp, Imm(0))
          lb += BranchLinked(Overflow, Some(VS))
        }
        case A_Len => {
          translateMove(Offset(srcOp, Imm(-4), Word), dstOp, lb)
        }
        case A_Chr => {
          lb += BinaryAssInstr(Mov, None, dstOp, srcOp)
        }
        case A_Ord => {
          lb += BinaryAssInstr(Mov, None, dstOp, srcOp)
        }
        case A_Mov => {
          translateMove(srcOp, dstOp, lb)
        }
        case A_Load => {
          translateMove(srcOp, dstOp, lb)
        }
        case A_Malloc => {
          translateMove(srcOp, Return, lb)
          lb += BranchLinked(Malloc, None)
          translateMove(Return, dstOp, lb)
        }
      }
    }
    case BinaryOperation(operator, src1, src2, dest) => {
      val src1Op = translateValueInto(src1, allocator, lb, R2)
      val src2Op = translateValueInto(src2, allocator, lb, R3)
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
          lb += QuaternaryAssInstr(Smull, None, dstOp, Return, src1Op, src2Op)
          lb += BinaryAssInstr(Cmp, None, Return, Imm(0))
          lb += BranchLinked(Overflow, Some(NE))
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
      
      val ifLabel = generateLabel()
      val endLabel = generateLabel()
      condition.body.map(i => translateInstruction(i, allocator, lb))
      val cond = translateCond(condition.cond)
      val preIf = allocator.getState()

      lb += Branch(ifLabel, Some(cond))
      elseInstructions.map(i => translateInstruction(i, allocator, lb))
      lb.addAll(allocator.reloadState(preIf))
      lb += Branch(endLabel, None)

      lb += NewLabel(ifLabel)
      ifInstructions.map(i => translateInstruction(i, allocator, lb))
      lb.addAll(allocator.reloadState(preIf))
      lb += NewLabel(endLabel)
    }
    case WhileInstruction(condition, body) => {
      val preWhile = allocator.getState()
      val condLabel = generateLabel()
      val bodyLabel = generateLabel()
      val cond = translateCond(condition.cond)
      lb += Branch(condLabel, None)
      lb += NewLabel(bodyLabel)
      body.map(i => translateInstruction(i, allocator, lb))
      lb.addAll(allocator.reloadState(preWhile))
      lb += NewLabel(condLabel)
      condition.body.map(i => translateInstruction(i, allocator, lb))
      lb.addAll(allocator.reloadState(preWhile))
      lb += Branch(bodyLabel, Some(cond))
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
      lb += BL(s"wacc_$functionName", None)
      translateMove(Return, returnOp, lb)
    }
    case InbuiltFunction(operator, src) => {
      val srcOp = translateValue(src, allocator, lb)
      if (operator == A_Exit) {
        srcOp match {
          case Imm(x) => {
            if (x == -1) {
              Imm(255)
            } else {
              Imm(x)
            }
          }
          case x => x
        }
      }
      translateMove(srcOp, Return, lb)
      translateInbuilt(operator, src, lb)
      if (operator == A_Read) {
        translateMove(Return, srcOp, lb)
      }
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
    funcBuffer += NewLabel("0")
    funcBuffer.addAll(suff)
    Block(Label(function.id), funcBuffer.toList)
  }

  def translateValue(value: Value, allocator: RegisterAllocator, lb: ListBuffer[AssInstr]): Operand = value match {
      case Access(pointer, access, t) => {
        val pointOp = translateValue(pointer, allocator, lb)
        val accOp = translateValueInto(access, allocator, lb, R2)
        t match{
          case PointerType(None) => {
            // Pair
            usedFunctions.add(NullError)
            usedFunctions.add(PrintS)
            lb += BinaryAssInstr(Cmp, None, pointOp, Imm(0))
            lb += BranchLinked(NullError, Some(EQ))
          }
          case _ => {
            // Arrays
            usedFunctions.add(OutOfBound)
            usedFunctions.add(PrintS)
            translateMove(Offset(pointOp, Imm(-4), translateType(IntType)), Return, lb)
            lb += BinaryAssInstr(Mov, None, R3, Imm(getElementSize(t)))
            lb += TernaryAssInstr(Mul, None, Return, Return, R3)
            lb += BinaryAssInstr(Cmp, None, accOp, Return)
            lb += BranchLinked(OutOfBound, Some(GE))
          }
        }
        Offset(pointOp, accOp, translateType(t))
      }
      case Immediate(value) => Imm(value)
      case Character(value) => Imm(value)
      case Bool(value) => Imm(value)
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

  def getElementSize(t: IntermediateType): Int = t match {
      case CharType => 1
      case BoolType => 1
      case _ => defaultIntSize
    }

  def translateType(tiepe: IntermediateType): Type = tiepe match {
    case BoolType => Byte
    case CharType => Byte
    case _ => Word
  }

  def getTypeFromValue(value: Value): IntermediateType = value match {
    case Access(pointer, access, t) => t
    case Immediate(value) => IntType
    case Character(value) => CharType
    case Bool(value) => BoolType
    case IntermediateValue(id, tiepe) => tiepe
    case Stored(id, tiepe) => tiepe
    case StringLiteral(value) => StringType
  }

  def translateMove(src: Operand, dst: Operand, lb: ListBuffer[AssInstr]) = {
    dst match {
      case Label(label) => throw new Exception("") 
      case r: Register => src match {
        case Label(label) => lb += BinaryAssInstr(Ldr(Word), None, dst, src)
        case r: Register => lb += BinaryAssInstr(Mov, None, dst, src)
        case Imm(x) => {
          if (x > 255 || x < 0) {
            lb += BinaryAssInstr(Ldr(Word), None, dst, src)
          } else {
            lb += BinaryAssInstr(Mov, None, dst, src)
          }
        }
        case Offset(reg, offset, t) => {
          lb += BinaryAssInstr(Ldr(t), None, dst, src)
        }
      }
      case Imm(x) => throw new Exception("")
      case Offset(reg, offset, t) => {
        src match {
          case Label(label) => {
            lb += BinaryAssInstr(Ldr(t), None, Return, src)
            lb += BinaryAssInstr(Str(t), None, Return, dst)
          }
          case r: Register => {
            lb += BinaryAssInstr(Str(t), None, src, dst)
          }
          case Imm(x) => {
            if (x > 255 || x < 0) {
              lb += BinaryAssInstr(Ldr(Word), None, Return, src)
              lb += BinaryAssInstr(Str(t), None, Return, dst)
            } else {
              lb += BinaryAssInstr(Mov, None, Return, src)
              lb += BinaryAssInstr(Str(t), None, Return, dst)
            }
          }
          case Offset(reg, offset, t2) => {
            lb += BinaryAssInstr(Ldr(t2), None, Return, src)
            lb += BinaryAssInstr(Str(t), None, Return, dst)
          }
        }
      }
    }
  }

  def translateValueInto(value: Value, allocator: RegisterAllocator, lb: ListBuffer[AssInstr], destination: Register): Register = {
    val operand = translateValue(value, allocator, lb)
    translateMove(operand, destination, lb)
    destination
  }

  def translateCond(cond: A_Condition): Condition = cond match {
    case A_GT => GT
    case A_GTE => GE
    case A_LT => LT
    case A_LTE => LE
    case A_EQ => EQ
    case A_NEQ => NE
  }

  def translateInbuilt(inbuilt: AssemblyIOperator, v: Value, lb: ListBuffer[AssInstr]) = inbuilt match {
    case A_Exit => lb += BranchLinked(Exit, None)
    case A_Read => {
      val vtype = getTypeFromValue(v)
      val f = vtype match {
        case IntType => ReadI
        case _ => ReadC
      }
      usedFunctions.add(f)
      lb += BranchLinked(f, None)
    }
    case A_Print => {
      val vtype = getTypeFromValue(v)
      val f = getPrintType(vtype)
      usedFunctions.add(f)
      lb += BranchLinked(f, None)
    }
    case A_Println => {
      val vtype = getTypeFromValue(v)
      val f = getPrintType(vtype)
      usedFunctions.add(f)
      usedFunctions.add(PrintLn)
      lb += BranchLinked(f, None)
      lb += BranchLinked(PrintLn, None)
    }
    case A_Len => {
      val f = Len
      usedFunctions.add(f)
      lb += BranchLinked(f, None)
    }
    case A_Free => {
      val vtype = getTypeFromValue(v)
      vtype match {
        case PointerType(Some(_)) => {
          lb += BinaryAssInstr(Mov, None, R1, Imm(4))
          lb += TernaryAssInstr(Sub, None, Return, Return, R1)
          lb += BranchLinked(Free, None)
        }
        case _ => {
          lb += BranchLinked(FreePair, None)
          usedFunctions.add(FreePair)
        }
      }
      usedFunctions.add(NullError)
      usedFunctions.add(PrintS)
    }
    case A_Return => lb += Branch("0f", None)
  }

  def getPrintType(t: IntermediateType): InBuilt = t match {
    case IntType => PrintI
    case BoolType => PrintB
    case CharType => PrintC
    case PointerType(t) => t match {
      case None => PrintA
      case Some(value) => value match {
        case IntType => PrintI
        case BoolType => PrintB
        case CharType => PrintC
        case PointerType(dest) => dest match {
          case None => PrintA 
          case Some(value) => value match {
            case CharType => PrintS
            case _ => PrintA
          }
        }
        case StringType => PrintS
      }
    }
    case StringType => PrintS
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