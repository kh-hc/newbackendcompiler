package wacc

class AssemblyTranslator {
    import assemblyCode._
    import assemblyAbstractStructure._
    import scala.collection.mutable.Set
    import scala.collection.mutable.Map

    val usedFunctions = Set.empty[InBuilt]
    val stringLabelMap = Map.empty[String, String]
    var stringsCount = 0
    var labelCount = 0

    def translate(program: Program): (AssProg, Set[InBuilt], Map[String, String]) = {
        val main = translateMain(program.main)
        return (AssProg(List(main)), usedFunctions, stringLabelMap)
    }

    def translateMain(instructions: List[Instruction]): Block = {
        val allocator = new RegisterAllocator()
        val assembly = instructions.map(i => translateInstruction(i, allocator)).flatten
        val (prefix, suffix) = allocator.generateBoilerPlate()
        return Block(Label("main"), prefix ++ (assembly :+ BinaryAssInstr(Mov, None, Return, Imm(0))) ++ suffix)
    }

    def translateFunction(function: Function): Block = {
        val allocator = new RegisterAllocator()
        //TODO link arguments to their registers in the allocator
        val assembly = function.body.map(i => translateInstruction(i, allocator)).flatten
        val (prefix, suffix) = allocator.generateBoilerPlate()
        return Block(Label(function.id), prefix ++ assembly ++ suffix)
    }

    // TODO: Deal with arrays, pairs and strings properly
    def translateValue(value: Value, allocator: RegisterAllocator): (List[AssInstr], Operand) = value match {
        case Stored(id) => allocator.getRegister(id)
        case Immediate(x) => (Nil, Imm(x))
        case ArrayAccess(pos, Stored(id)) => {
            // val accessInstructions = List.empty[AssInstr]
            val (instrs, arrayToAccess) = allocator.getRegister(id)
            for (p: Value <- pos) {
                //TODO
            }
            return (instrs, arrayToAccess)
        }
        case PairAccess(pos, pair) => {
            //val accessInstructions = List.empty[AssInstr]
            // TODO
            return translateValue(pair, allocator)
        }
        case StringLiteral(value) => {
            val stringLabel = generateStringLabel(stringsCount)
            stringLabelMap.addOne(stringLabel, value)
            stringsCount = stringsCount + 1
            return (Nil, Label(stringLabel))
        }
        
        case Null => return (Nil, Imm(0))
    }

    def translateInstruction(instruction: Instruction, allocator: RegisterAllocator): List[AssInstr] = instruction match{
        case BinaryOperation(op, src1, src2, dst) => {
            var (src1Instr, src1Assembly) = translateValue(src1, allocator)
            var (src2Instr, src2Assembly) = translateValue(src2, allocator)
            src1Assembly match {
                case r: Register => 
                case _: Any => {
                    val (instr, newReg) = allocator.getNewAccessRegister(src2Assembly match {
                        case r: Register => r
                        case _ => Return
                    })
                    src1Instr = src1Instr ++ instr ++ translateMov(src1Assembly, newReg)
                    src1Assembly = newReg                
                }
            }
            val (destInstr, destAssembly) = translateValue(dst, allocator)
            val finalInstr: List[AssInstr] = op match {
                case A_Add => List(TernaryAssInstr(Add, None, destAssembly, src1Assembly, src2Assembly))
                case A_Sub => List(TernaryAssInstr(Sub, None, destAssembly, src1Assembly, src2Assembly))
                case A_Mul => List(TernaryAssInstr(Mul, None, destAssembly, src1Assembly, src2Assembly))
                case A_Div => {
                    val (saveRegs, restoreRegs) = allocator.saveArgs(List(R1))
                    saveRegs ++ List(BinaryAssInstr(Mov, None, Return, src1Assembly),
                    BinaryAssInstr(Mov, None, R1, src2Assembly),
                    BranchLinked(DivMod),
                    BinaryAssInstr(Mov, None, destAssembly, Return)) ++ restoreRegs
                }
                case A_Mod => {
                    val (saveRegs, restoreRegs) = allocator.saveArgs(List(R1))
                    saveRegs ++ List(BinaryAssInstr(Mov, None, Return, src1Assembly),
                    BinaryAssInstr(Mov, None, R1, src2Assembly),
                    BranchLinked(DivMod),
                    BinaryAssInstr(Mov, None, destAssembly, R1)) ++ restoreRegs
                }
                case A_And => List(TernaryAssInstr(And, None, destAssembly, src1Assembly, src2Assembly))
                case A_Or => List(TernaryAssInstr(Or, None, destAssembly, src1Assembly, src2Assembly))
                case A_GT => List(TernaryAssInstr(GT, None, destAssembly, src1Assembly, src2Assembly))
                case A_GTE => List(TernaryAssInstr(GE, None, destAssembly, src1Assembly, src2Assembly))
                case A_LT => List(TernaryAssInstr(LT, None, destAssembly, src1Assembly, src2Assembly))
                case A_LTE => List(TernaryAssInstr(LE, None, destAssembly, src1Assembly, src2Assembly))
                case A_EQ => List(TernaryAssInstr(EQ, None, destAssembly, src1Assembly, src2Assembly))
                case A_NEQ => List(TernaryAssInstr(NE, None, destAssembly, src1Assembly, src2Assembly))
            }
            return src1Instr ++ src2Instr ++ destInstr ++ finalInstr
        }
        case UnaryOperation(op, src, dst) => {
            var (srcInstr, srcAssembly) = translateValue(src, allocator)
            val (destInstr, destAssembly) = translateValue(dst, allocator)
            srcAssembly match {
                case r: Register => 
                case _: Any => {
                    val (instr, newReg) = allocator.getNewAccessRegister(destAssembly match {
                        case r: Register => r
                        case _: Any => Return
                    })
                    srcInstr = srcInstr ++ instr ++ translateMov(srcAssembly, newReg)
                    srcAssembly = newReg                
                }
            }
            val finalInstrs = op match {
                case A_Not => List(TernaryAssInstr(NE, None, destAssembly, srcAssembly, Imm(1)))
                case A_Neg => List(TernaryAssInstr(RightSub, None, destAssembly, srcAssembly, Imm(0)))
                case A_Len => translateMov(Offset(srcAssembly, Imm(-4)), destAssembly)
                case A_Chr => translateMov(srcAssembly, destAssembly)
                case A_Ord => translateMov(srcAssembly, destAssembly)
                case A_ArrayCreate => Nil
                case A_Assign => translateMov(srcAssembly, destAssembly)
                case A_Mov => translateMov(srcAssembly, destAssembly)
            }
            srcInstr ++ destInstr ++ finalInstrs
        }
        case InbuiltFunction(op, src) => op match {
            case A_PrintI => {
                usedFunctions.addOne(PrintI)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+
                BranchLinked(PrintI)
            }
            case A_PrintB => {
                usedFunctions.addOne(PrintB)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+
                BranchLinked(PrintB)
            }
            case A_PrintC => {
                usedFunctions.addOne(PrintC)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+
                BranchLinked(PrintC)
            }
            case A_PrintS => {
                usedFunctions.addOne(PrintS)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+ BranchLinked(PrintS)
            }
            case A_PrintA => {
                usedFunctions.addOne(PrintA)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+
                BranchLinked(PrintA)
            }
            case A_Println => {
                usedFunctions.addOne(PrintLn)
                List(BranchLinked(PrintLn))
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
                srcInstr ++ translateMov(exitCode, Return) :+
                BranchLinked(Exit)
            }
            case A_Free => {    
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+
                BranchLinked(Free)
            }
            case A_Len => Nil
            case A_PairCreate => Nil
            case A_Read => Nil
            case A_Return => {
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(SP, FP) ++ translateMov(srcOp, Return) ++ List(UnaryAssInstr(Pop, None, PC), UnaryAssInstr(Pop, None, FP))
            }
        }
        case FunctionCall(name, args, dst) => {
            var instr: List[AssInstr] = Nil
            var count = 0
            for (arg <- args) {
                val (argInstr, argOp) = translateValue(arg, allocator)
                if (count < 4) {
                    val reg = argumentRegisters(count)
                    instr = (argInstr ++ translateMov(argOp, reg))++ instr
                } else {
                    instr = (argInstr :+ UnaryAssInstr(Push, None, argOp))++ instr
                }
                count = count + 1
            }
            val (save, unsave) = allocator.saveArgs(assemblyCode.generalRegisters.toList) 
            val (dstInstr, dstOp) = translateValue(dst, allocator)
            (save :+ BranchLinkedF(name)) ++ dstInstr ++ translateMov(Return, dstOp) ++ unsave
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
            val conditionalInstr = condition.conditions.map(i => translateInstruction(i, allocator)).flatten
            val (assInstr, assOp) = translateValue(condition.value, allocator)
            val loopLabel = generateLabel(labelCount)
            labelCount = labelCount + 1
            val endLabel = generateLabel(labelCount)
            labelCount = labelCount + 1
            conditionalInstr ++ assInstr ++ List(BinaryAssInstr(Cmp, None, assOp, Imm(1))) ++ List(BranchNe(endLabel)) ++
            List(NewLabel(loopLabel)) ++ (body.map(i => translateInstruction(i, allocator)).flatten :+ NewLabel(endLabel))
        }
    }

    def generateLabel(counter: Int): String = s".L${counter.toString}"

    def generateStringLabel(counter: Int): String = s".L.str${counter.toString}"

    def translateMov(srcAss: Operand, dstAss: Operand): List[AssInstr] = srcAss match {
        case Label(label) => List(BinaryAssInstr(Ldr, None, dstAss, srcAss))
        case Offset(reg, offset) => List(BinaryAssInstr(Ldr, None, dstAss, srcAss))
        case _ => List(BinaryAssInstr(Mov, None, dstAss, srcAss))
    }
}
