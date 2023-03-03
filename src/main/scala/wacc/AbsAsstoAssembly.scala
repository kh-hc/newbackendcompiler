package wacc

import scala.collection.mutable.ListBuffer

class AssemblyTranslator {
    import assemblyCode._
    import assemblyAbstractStructure._
    import scala.collection.mutable.Set
    import scala.collection.mutable.Map

    val usedFunctions = Set.empty[InBuilt]
    val stringLabelMap = Map.empty[String, String]
    var stringsCount = 0
    var labelCount = 0

 def translate(program: Program): (AssProg, Set[InBuilt], List[Block], Map[String, String]) = {
        val main = translateMain(program.main)
        val funcs = program.functions.map(f => translateFunction(f))
        return (AssProg(List(main)), usedFunctions, funcs, stringLabelMap)
    }

    def translateMain(instructions: List[Instruction]): Block = {
        val allocator = new RegisterAllocator()
        val assembly = new ListBuffer[AssInstr]
        instructions.foreach(i => assembly.appendAll(translateInstruction(i, allocator)))
        val (prefix, suffix) = allocator.generateBoilerPlate()
        return Block(Label("main"), prefix ++ (assembly.toList :+ BinaryAssInstr(Mov, None, Return, Imm(0))) ++ suffix)
    }

    def translateFunction(function: Function): Block = {
        val allocator = new RegisterAllocator()
        val retrieveArgs = allocator.loadArgs(function.args.map(p => p.id))
        //TODO link arguments to their registers in the allocator
        val assembly = new ListBuffer[AssInstr]
        function.body.foreach(i => assembly.appendAll(translateInstruction(i, allocator)))
        val (prefix, suffix) = allocator.generateBoilerPlate()
        return Block(Label(function.id), prefix ++ retrieveArgs ++ assembly.toList ++ (NewLabel("0") +: suffix))
    }

    // TODO: Deal with arrays, pairs and strings properly
    def translateValue(value: Value, allocator: RegisterAllocator): (List[AssInstr], Operand) = value match {
        case Stored(id) => allocator.getRegister(id)
        case Immediate(x) => (Nil, Imm(x))
        case ArrayAccess(pos, Stored(id), formation) => {
            val (instrs, arrayToAccess) = allocator.getRegister(id)
            val (posInstrs, posLoc) = translateValue(pos, allocator)
            // Ensure that the array is not bounds checked during creation
            val errList = new ListBuffer[AssInstr]
            if (!formation){
                usedFunctions.add(OutOfBound)
                errList.appendAll(List(UnaryAssInstr(Push, None, R1),
                    BinaryAssInstr(Mov, None, R3, posLoc),
                    BinaryAssInstr(Cmp, None, R3, Imm(0)),
                    BinaryAssInstr(Mov, Some(LT), R1, R3),
                    BranchLinked(OutOfBound, Some(LT)),
                    BinaryAssInstr(Ldr, None, LR, Offset(arrayToAccess, Imm(-4))),
                    BinaryAssInstr(Mov, None, Return, Imm(4)),
                    TernaryAssInstr(Mul, None, LR, LR, Return),
                    BinaryAssInstr(Mov, None, R3, posLoc),
                    BinaryAssInstr(Cmp, None, R3, LR),
                    BinaryAssInstr(Mov, Some(GT), R1, R3),
                    BranchLinked(OutOfBound, Some(GT)),
                    UnaryAssInstr(Pop, None, R1)))
            }
            return (instrs ++ posInstrs ++ errList.toList, Offset(arrayToAccess, posLoc))
        }
        case PairAccess(pos, pair) => {
            val (pairInstrs, p) = translateValue(pair, allocator)
            usedFunctions.addOne(NullError)
            usedFunctions.addOne(PrintS)
            return (pairInstrs ++ 
                    List(BinaryAssInstr(Cmp, None, p, Imm(0)), BranchLinked(NullError, Some(EQ))),
                    Offset(p, Imm(pos match {
                case Fst => 0
                case Snd => 4
            })))
        }
        case StringLiteral(value) => {
            val stringLabel = generateStringLabel(stringsCount)
            stringLabelMap.addOne(stringLabel, value.flatMap(escapedChar))
            stringsCount = stringsCount + 1
            return (Nil, Label(stringLabel))
        }
        
        case Null => return (Nil, Imm(0))
    }

    def translateValueInto(value: Value, allocator: RegisterAllocator, destination: Register): List[AssInstr] = {
        val (origInstr, origOperand) = translateValue(value, allocator)
        origInstr ++ translateMov(origOperand, destination, allocator)
    }

    def escapedChar(ch: Char): String = ch match {
        case '"'  => "\\\""
        case '\'' => "\\\'"
        case '\\' => "\\\\"
        case '\b' => "\\b"
        case '\n' => "\\n"
        case '\f' => "\\f"
        case '\r' => "\\r"
        case '\t' => "\\t"
        case _    => String.valueOf(ch)
    }


    def translateInstruction(instruction: Instruction, allocator: RegisterAllocator): List[AssInstr] = instruction match{
        case BinaryOperation(op, src1, src2, dst) => {
            val src1Instr = translateValueInto(src1, allocator, R1)
            val src2Instr = translateValueInto(src2, allocator, R2)
            val (destInstr, destAssembly) = translateValue(dst, allocator)
            val finalInstr: List[AssInstr] = op match {
                case A_Add => {
                    usedFunctions.addOne(Overflow)
                    usedFunctions.addOne(PrintS)
                    List(
                    TernaryAssInstr(Add, None, destAssembly, R1, R2),
                    BranchLinked(Overflow, Some(VS)))
                }
                case A_Sub => {
                    usedFunctions.addOne(Overflow)
                    usedFunctions.addOne(PrintS)
                    List(TernaryAssInstr(Sub, None, destAssembly, R1, R2),
                    BranchLinked(Overflow, Some(VS)))
                }
                case A_Mul => {
                    usedFunctions.addOne(Overflow)
                    usedFunctions.addOne(PrintS)
                    List(QuaternaryAssInstr(Smull, None, destAssembly, R3, R1, R2),
                    TernaryAssInstr(Cmp, None, R3, destAssembly, ASR(31)),
                    BranchLinked(Overflow, Some(NE)))
                }
                case A_Div => {
                    val (saveRegs, restoreRegs) = allocator.saveArgs(List(R1))
                    usedFunctions.addOne(DivZero)
                    usedFunctions.addOne(PrintS)
                    saveRegs ++ List(BinaryAssInstr(Mov, None, Return, R1),
                    BinaryAssInstr(Mov, None, R1, R2),
                    BinaryAssInstr(Cmp, None, R1, Imm(0)),
                    BranchLinked(DivZero, Some(EQ)),
                    BranchLinked(DivMod, None),
                    BinaryAssInstr(Mov, None, destAssembly, Return)) ++ restoreRegs
                }
                case A_Mod => {
                    val (saveRegs, restoreRegs) = allocator.saveArgs(List(R1))
                    usedFunctions.addOne(DivZero)
                    usedFunctions.addOne(PrintS)
                    saveRegs ++ List(BinaryAssInstr(Mov, None, Return,  R1),
                    BinaryAssInstr(Mov, None, R1, R2),
                    BinaryAssInstr(Cmp, None, R1, Imm(0)),
                    BranchLinked(DivZero, Some(EQ)),
                    BranchLinked(DivMod, None),
                    BinaryAssInstr(Mov, None, destAssembly, R1)) ++ restoreRegs
                }
                case A_And => List(TernaryAssInstr(And, None, destAssembly, R1, R2))
                case A_Or => List(TernaryAssInstr(Or, None, destAssembly, R1, R2))
                case A_GT => List(TernaryAssInstr(GT, None, destAssembly, R1, R2))
                case A_GTE => List(TernaryAssInstr(GE, None, destAssembly, R1, R2))
                case A_LT => List(TernaryAssInstr(LT, None, destAssembly, R1, R2))
                case A_LTE => List(TernaryAssInstr(LE, None, destAssembly, R1, R2))
                case A_EQ => List(TernaryAssInstr(EQ, None, destAssembly, R1, R2))
                case A_NEQ => List(TernaryAssInstr(NE, None, destAssembly, R1, R2))
            }
            return src1Instr ++ src2Instr ++ destInstr ++ finalInstr
        }
        case UnaryOperation(op, src, dst) => {
            val srcInstr = translateValueInto(src, allocator, R1)
            val (destInstr, destAssembly) = translateValue(dst, allocator)
            val finalInstrs = op match {
                case A_Not => List(TernaryAssInstr(NE, None, destAssembly, R1, Imm(1)))
                case A_Neg => {
                    usedFunctions.addOne(Overflow)
                    usedFunctions.addOne(PrintS)
                    List(TernaryAssInstr(RightSub, None, destAssembly, R1, Imm(0)),
                    BranchLinked(Overflow, Some(VS)))
                }
                case A_Len => translateMov(Offset(R1, Imm(-4)), destAssembly, allocator)
                case A_Chr => translateMov(R1, destAssembly, allocator)
                case A_Ord => translateMov(R1, destAssembly, allocator)
                case A_ArrayCreate => translateMov(R1, Return, allocator) ++ List(BranchLinked(Malloc, None)) ++ translateMov(Return, destAssembly, allocator)
                case A_Assign => {
                    translateMov(R1, destAssembly, allocator)
                }
                case A_Mov => translateMov(R1, destAssembly, allocator)
            }
            srcInstr ++ destInstr ++ finalInstrs
        }
        case InbuiltFunction(op, src) => op match {
            case A_PrintI => {
                usedFunctions.addOne(PrintI)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return, allocator) :+
                BranchLinked(PrintI, None)
            }
            case A_PrintB => {
                usedFunctions.addOne(PrintB)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return, allocator) :+
                BranchLinked(PrintB, None)
            }
            case A_PrintC => {
                usedFunctions.addOne(PrintC)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return, allocator) :+
                BranchLinked(PrintC, None)
            }
            case A_PrintS => {
                usedFunctions.addOne(PrintS)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return, allocator) :+ BranchLinked(PrintS, None)
            }
            case A_PrintA => {
                usedFunctions.addOne(PrintA)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return, allocator) :+
                BranchLinked(PrintA, None)
            }
            case A_Println => {
                usedFunctions.addOne(PrintLn)
                List(BranchLinked(PrintLn, None))
            }
            case A_ArrayCreate => Nil
            case A_Exit => {   
                val (srcInstr, srcOp) = translateValue(src, allocator)
                val exitCode: Operand = srcOp match {
                    case Imm(x) => {
                        if (x == -1) {
                            Imm(255)
                        } else {
                            Imm(x)
                        }
                    }
                    case x => x
                } 
                srcInstr ++ translateMov(exitCode, Return, allocator) :+
                BranchLinked(Exit, None)
            }
            case A_Free => {    
                val (srcInstr, srcOp) = translateValue(src, allocator)
                usedFunctions.addOne(Free)
                usedFunctions.addOne(NullError)
                usedFunctions.addOne(PrintS)
                srcInstr ++ translateMov(srcOp, Return, allocator) :+
                BranchLinked(Free, None)
            }
            case A_Len => Nil
            case A_PairCreate => {
                // Call malloc on size 8
                //mov the address accordingly
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(Imm(8), Return, allocator) ++ List(BranchLinked(Malloc, None)) ++ translateMov(Return, srcOp, allocator)
            }
            case A_ReadI => {
                usedFunctions.addOne(ReadI)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                BranchLinked(ReadI, None) +: translateMov(Return, srcOp, allocator)     
            }
            case A_ReadC => {
                usedFunctions.addOne(ReadC)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                BranchLinked(ReadC, None) +: translateMov(Return, srcOp, allocator)
            }
            case A_Return => {
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return, allocator) :+ BranchUnconditional("0f")
            }
        }
        case FunctionCall(name, args, dst) => {
            var instr: List[AssInstr] = Nil
            var count = 0
            for (arg <- args) {
                val (argInstr, argOp) = translateValue(arg, allocator)
                if (count < 4) {
                    val reg = argumentRegisters(count)
                    instr = instr ++ (argInstr ++ translateMov(argOp, reg, allocator))
                } else {
                    instr = instr ++ (argInstr :+ UnaryAssInstr(Push, None, argOp))
                }
                count = count + 1
            }
            val (dstInstr, dstOp) = translateValue(dst, allocator)
            instr ++ (CallFunction(name) +: dstInstr) ++ translateMov(Return, dstOp, allocator)
        }
        case IfInstruction(condition, ifInstructions, elseInstructions) => {
            val conditionalInstr = condition.conditions.map(i => translateInstruction(i, allocator)).flatten
            val (assInstr, assOp) = translateValue(condition.value, allocator)
            val elseLabel = generateLabel(labelCount)
            labelCount = labelCount + 1
            val endLabel = generateLabel(labelCount)
            labelCount = labelCount + 1
            conditionalInstr ++ assInstr ++ (BinaryAssInstr(Cmp, None, assOp, Imm(1)) +: BranchNe(elseLabel) +: ifInstructions.map(i => translateInstruction(i, allocator)).flatten :+ BranchUnconditional(endLabel)) ++ 
            (NewLabel(elseLabel) +: elseInstructions.map(i => translateInstruction(i, allocator)).flatten :+ NewLabel(endLabel))
        }
        case WhileInstruction(condition, body) => {
            val originalConditionInstr = condition.conditions.map(i => translateInstruction(i, allocator)).flatten
            val (ocInstr, ocOp) = translateValue(condition.value, allocator)
            val preWhile = allocator.getState()
            val startLabel = generateLabel(labelCount)
            labelCount = labelCount + 1
            val endLabel = generateLabel(labelCount)
            labelCount = labelCount + 1
            val bodyInstrs = body.map(i => translateInstruction(i, allocator)).flatten
            val loopConditionInstr = condition.conditions.map(i => translateInstruction(i, allocator)).flatten
            val (loopInstr, loopOp) = translateValue(condition.value, allocator)
            // val preCond = allocator.getState()
            // val endCondition = condition.conditions.map(i => translateInstruction(i, allocator)).flatten
            val resetRegs = allocator.reloadState(preWhile)

            // Fails in the case that ecInstr clobbers a register
            originalConditionInstr ++ ocInstr ++ List(BinaryAssInstr(Cmp, None, ocOp, Imm(1)), BranchNe(endLabel), NewLabel(startLabel)) ++
            bodyInstrs ++ loopConditionInstr ++ loopInstr ++ List(BinaryAssInstr(Cmp, None, loopOp, Imm(1))) ++ resetRegs ++
            List(BranchEq(startLabel), NewLabel(endLabel))
        }
    }

    def generateLabel(counter: Int): String = s".L${counter.toString}"

    def generateStringLabel(counter: Int): String = s".L.str${counter.toString}"

    def translateMov(srcAss: Operand, dstAss: Operand, allocator: RegisterAllocator): List[AssInstr] = {
        (srcAss, dstAss) match {
            case (Label(label), Offset(reg, offset)) => {
                reg match {
                    case Offset(derefReg, derefOffset) => {
                        Nil
                    }
                    case r: Register => {
                        val (accessInstr, accessReg) = allocator.getNewAccessRegister(r)
                        accessInstr ++ List(BinaryAssInstr(Ldr, None, accessReg, Label(label)),
                            BinaryAssInstr(Str, None, accessReg, Offset(r, offset)))
                    }
                    case _ => Nil
                }
            }
            case (Label(label), _) => List(BinaryAssInstr(Ldr, None, dstAss, srcAss))
            case (Offset(srcReg, srcOffset), Offset(dstReg, dstOffset))=> {
                // Annoying
                Nil
            }
            case (Offset(reg, offset), o) => {
                reg match {
                    case Offset(derefReg, derefOffset) => {
                        Nil
                    }
                    case r: Register => {
                        val (accessInstr, accessReg) = allocator.getNewAccessRegister(r)
                        accessInstr ++ List(BinaryAssInstr(Ldr, None, accessReg, Offset(reg, offset)),
                            BinaryAssInstr(Mov, None, o, accessReg))
                    }
                    case _ => Nil
                }
            }
            case (o, Offset(reg, offset)) => {
                reg match {
                    case Offset(derefReg, derefOffset) => Nil
                    case r: Register => {
                        val (accessInstr, accessReg) = allocator.getNewAccessRegister(r)
                        accessInstr ++ List(BinaryAssInstr(Mov, None, accessReg, o),
                            BinaryAssInstr(Str, None, o, Offset(reg, offset)))
                    }
                    case _ => Nil
                }
            }
            case (Imm(x), _) => {
                if (x > 255 || x < -255) {
                    List(BinaryAssInstr(Ldr, None, dstAss, srcAss))
                } else {
                    List(BinaryAssInstr(Mov, None, dstAss, srcAss))
                }
            }
            case _ => List(BinaryAssInstr(Mov, None, dstAss, srcAss))
        }
    }
}
