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

    def translate(program: Program): (AssProg, Set[InBuilt], List[Block], Map[String, String]) = {
        val main = translateMain(program.main)
        val funcs = program.functions.map(f => translateFunction(f))
        return (AssProg(List(main)), usedFunctions, funcs, stringLabelMap)
    }

    def translateMain(instructions: List[Instruction]): Block = {
        val allocator = new RegisterAllocator()
        val assembly = instructions.map(i => translateInstruction(i, allocator)).flatten
        val (prefix, suffix) = allocator.generateBoilerPlate()
        return Block(Label("main"), prefix ++ (assembly :+ BinaryAssInstr(Mov, None, Return, Imm(0))) ++ suffix)
    }

    def translateFunction(function: Function): Block = {
        val allocator = new RegisterAllocator()
        val retrieveArgs = allocator.loadArgs(function.args.map(p => p.id))
        //TODO link arguments to their registers in the allocator
        val assembly = function.body.map(i => translateInstruction(i, allocator)).flatten
        val (prefix, suffix) = allocator.generateBoilerPlate()
        return Block(Label(function.id), prefix ++ retrieveArgs ++ assembly ++ (NewLabel("0") +: suffix))
    }

    // TODO: Deal with arrays, pairs and strings properly
    def translateValue(value: Value, allocator: RegisterAllocator): (List[AssInstr], Operand, List[AssInstr]) = value match {
        case Stored(id) => allocator.getRegister(id)
        case Immediate(x) => (Nil, Imm(x), Nil)
        case ArrayAccess(pos, Stored(id)) => {
            // val accessInstructions = List.empty[AssInstr]
            val (instrs, arrayToAccess, revInstr) = allocator.getRegister(id)
            for (p: Value <- pos) {
                //TODO
            }
            return (instrs, arrayToAccess, revInstr)
        }
        case PairAccess(pos, pair) => {
            val (pairInstrs, p) = translateValue(pair, allocator)
            return (pairInstrs, Offset(p, Imm(pos match {case Fst => 0
            case Snd => 4})))
        }
        case StringLiteral(value) => {
            val stringLabel = generateStringLabel(stringsCount)
            stringLabelMap.addOne((stringLabel, value.flatMap(c => escapedChar(c))))
            stringsCount = stringsCount + 1
            return (Nil, Label(stringLabel), Nil)
        }
        
        case Null => return (Nil, Imm(0), Nil)
    }

    def translateInstruction(instruction: Instruction, allocator: RegisterAllocator): List[AssInstr] = instruction match{
        case BinaryOperation(op, src1, src2, dst) => {
            var (src1Instr, src1Assembly, revInstr1) = translateValue(src1, allocator)
            var (src2Instr, src2Assembly, revInstr2) = translateValue(src2, allocator)
            var revInstr: List[AssInstr] = revInstr1 ++ revInstr2
            src1Assembly match {
                case r: Register => 
                case _: Any => {
                    val (instr, newReg, revInst) = allocator.getNewAccessRegister(src2Assembly match {
                        case r: Register => r
                        case _ => Return
                    })
                    src1Instr = src1Instr ++ instr ++ translateMov(src1Assembly, newReg)
                    src1Assembly = newReg   
                    revInstr = revInstr ++ revInst             
                }
            }
            var (destInstr, destAssembly, revInstrD) = translateValue(dst, allocator)
            val finalInstr: List[AssInstr] = op match {
                case A_Add => {
                    usedFunctions.addOne(Overflow)
                    usedFunctions.addOne(PrintS)
                    List(
                    TernaryAssInstr(Add, None, destAssembly, src1Assembly, src2Assembly),
                    BranchLinked(Overflow, Some(VS)))
                }
                case A_Sub => {
                    usedFunctions.addOne(Overflow)
                    usedFunctions.addOne(PrintS)
                    List(TernaryAssInstr(Sub, None, destAssembly, src1Assembly, src2Assembly),
                    BranchLinked(Overflow, Some(VS)))
                }
                case A_Mul => {
                    usedFunctions.addOne(Overflow)
                    usedFunctions.addOne(PrintS)
                    List(QuaternaryAssInstr(Smull, None, destAssembly, R1, src1Assembly, src2Assembly),
                    TernaryAssInstr(Cmp, None, R1, destAssembly, ASR(31)),
                    BranchLinked(Overflow, Some(NE)))
                }
                case A_Div => {
                    val (saveRegs, restoreRegs) = allocator.saveArgs(List(R1))
                    usedFunctions.addOne(DivZero)
                    usedFunctions.addOne(PrintS)
                    saveRegs ++ List(BinaryAssInstr(Mov, None, Return, src1Assembly),
                    BinaryAssInstr(Mov, None, R1, src2Assembly),
                    BinaryAssInstr(Cmp, None, R1, Imm(0)),
                    BranchLinked(DivZero, Some(EQ)),
                    BranchLinked(DivMod, None),
                    BinaryAssInstr(Mov, None, destAssembly, Return)) ++ restoreRegs
                }
                case A_Mod => {
                    val (saveRegs, restoreRegs) = allocator.saveArgs(List(R1))
                    usedFunctions.addOne(DivZero)
                    usedFunctions.addOne(PrintS)
                    saveRegs ++ List(BinaryAssInstr(Mov, None, Return, src1Assembly),
                    BinaryAssInstr(Mov, None, R1, src2Assembly),
                    BinaryAssInstr(Cmp, None, R1, Imm(0)),
                    BranchLinked(DivZero, Some(EQ)),
                    BranchLinked(DivMod, None),
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
            var (srcInstr, srcAssembly, revInstrSRC) = translateValue(src, allocator)
            val (destInstr, destAssembly, revInstrDST) = translateValue(dst, allocator)
            var reversInstr: List[AssInstr] = Nil
            srcAssembly match {
                case r: Register => 
                case _: Any => {
                    val (instr, newReg, revInstr) = allocator.getNewAccessRegister(destAssembly match {
                        case r: Register => r
                        case _: Any => Return
                    })
                    srcInstr = srcInstr ++ instr ++ translateMov(srcAssembly, newReg)
                    srcAssembly = newReg   
                    reversInstr = revInstrSRC ++ revInstrDST ++ revInstr             
                }
            }
            val finalInstrs = op match {
                case A_Not => List(TernaryAssInstr(NE, None, destAssembly, srcAssembly, Imm(1)))
                case A_Neg => {
                    usedFunctions.addOne(Overflow)
                    usedFunctions.addOne(PrintS)
                    List(TernaryAssInstr(RightSub, None, destAssembly, srcAssembly, Imm(0)),
                    BranchLinked(Overflow, Some(VS)))
                }
                case A_Len => translateMov(Offset(srcAssembly, Imm(-4)), destAssembly, allocator)
                case A_Chr => translateMov(srcAssembly, destAssembly, allocator)
                case A_Ord => translateMov(srcAssembly, destAssembly, allocator)
                case A_ArrayCreate => translateMov(srcAssembly, Return, allocator) ++ List(BranchLinked(Malloc, None)) ++ translateMov(Return, destAssembly, allocator)
                case A_Assign => translateMov(srcAssembly, destAssembly, allocator)
                case A_Mov => translateMov(srcAssembly, destAssembly, allocator)
            }
            srcInstr ++ destInstr ++ finalInstrs
        }
        case InbuiltFunction(op, src) => op match {
            case A_PrintI => {
                usedFunctions.addOne(PrintI)
                val (srcInstr, srcOp, rev) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+
                BranchLinked(PrintI, None)
            }
            case A_PrintB => {
                usedFunctions.addOne(PrintB)
                val (srcInstr, srcOp, rev) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+
                BranchLinked(PrintB, None)
            }
            case A_PrintC => {
                usedFunctions.addOne(PrintC)
                val (srcInstr, srcOp, rev) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+
                BranchLinked(PrintC, None)
            }
            case A_PrintS => {
                usedFunctions.addOne(PrintS)
                val (srcInstr, srcOp, rev) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+ BranchLinked(PrintS, None)
            }
            case A_PrintA => {
                usedFunctions.addOne(PrintA)
                val (srcInstr, srcOp, rev) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+
                BranchLinked(PrintA, None)
            }
            case A_Println => {
                usedFunctions.addOne(PrintLn)
                List(BranchLinked(PrintLn, None))
            }
            case A_ArrayCreate => Nil
            case A_Exit => {   
                val (srcInstr, srcOp, rev) = translateValue(src, allocator)
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
                val (srcInstr, srcOp, rev) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+
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
                srcInstr ++ translateMov(srcOp, Return, allocator) :+
                BranchLinked(ReadI, None)
            }
            case A_ReadC => {
                usedFunctions.addOne(ReadC)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return, allocator) :+
                BranchLinked(ReadC, None)
            }
            case A_Return => {
                val (srcInstr, srcOp, rev) = translateValue(src, allocator)
                srcInstr ++ translateMov(srcOp, Return) :+ BranchUnconditional("0f")
            }
        }
        case FunctionCall(name, args, dst) => {
            var instr: List[AssInstr] = Nil
            var count = 0
            for (arg <- args) {
                val (argInstr, argOp, rev) = translateValue(arg, allocator)
                if (count < 4) {
                    val reg = argumentRegisters(count)
                    instr = instr ++ (argInstr ++ translateMov(argOp, reg, allocator))
                } else {
                    instr = instr ++ (argInstr :+ UnaryAssInstr(Push, None, argOp))
                }
                count = count + 1
            }
            val (dstInstr, dstOp, rev) = translateValue(dst, allocator)
            instr ++ (CallFunction(name) +: dstInstr) ++ translateMov(Return, dstOp)
        }
        case IfInstruction(condition, ifInstructions, elseInstructions) => {
            val conditionalInstr = condition.conditions.map(i => translateInstruction(i, allocator)).flatten
            val (assInstr, assOp, rev) = translateValue(condition.value, allocator)
            val elseLabel = generateLabel(labelCount)
            labelCount = labelCount + 1
            val endLabel = generateLabel(labelCount)
            labelCount = labelCount + 1
            conditionalInstr ++ assInstr ++ (BinaryAssInstr(Cmp, None, assOp, Imm(1)) +: BranchNe(elseLabel) +: ifInstructions.map(i => translateInstruction(i, allocator)).flatten :+ BranchUnconditional(endLabel)) ++ 
            (NewLabel(elseLabel) +: elseInstructions.map(i => translateInstruction(i, allocator)).flatten :+ NewLabel(endLabel))
        }
        case WhileInstruction(condition, body) => {
            //println(condition.conditions)
            val (assInstr, assOp, rev) = translateValue(condition.value, allocator)
            val condInstr = condition.conditions.map(i => translateInstruction(i, allocator)).flatten
            val condLabel = generateLabel(labelCount)
            labelCount = labelCount + 1
            val endLabel = generateLabel(labelCount)
            labelCount = labelCount + 1
            val bodyInstr = body.map(i => translateInstruction(i, allocator)).flatten

            println(s"cond instruction: $condInstr,\n bodyInstr: $bodyInstr,\n ass intruction: $assInstr,\n ass op: $assOp")

            (assInstr ++ (NewLabel(condLabel) +: condInstr) ++ (assInstr :+ BinaryAssInstr(Cmp, None, assOp, Imm(1)) :+ BranchNe(endLabel)) ++ bodyInstr ++ List(BranchUnconditional(condLabel), NewLabel(endLabel)))
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
