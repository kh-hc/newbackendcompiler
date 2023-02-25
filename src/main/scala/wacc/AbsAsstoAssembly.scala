package wacc

class AssemblyTranslator {
    import assemblyCode._
    import assemblyAbstractStructure._
    import scala.collection.mutable.Set

    val usedFunctions = Set.empty[InBuilt]

    def translate(program: Program): (AssProg, Set[InBuilt]) = {
        val main = translateMain(program.main)
        return (AssProg(List(main)), usedFunctions)
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
        case StringLiteral(value) => return (Nil, Label(value))
        case Null => return (Nil, Imm(0))
    }

    def translateInstruction(instruction: Instruction, allocator: RegisterAllocator): List[AssInstr] = instruction match{
        case BinaryOperation(op, src1, src2, dst) => {
            val (src1Instr, src1Assembly) = translateValue(src1, allocator)
            val (src2Instr, src2Assembly) = translateValue(src2, allocator)
            val (destInstr, destAssembly) = translateValue(dst, allocator)
            val finalInstr: List[AssInstr] = op match {
                case A_Add => List(TernaryAssInstr(Add, None, destAssembly, src1Assembly, src2Assembly))
                case A_Sub => List(TernaryAssInstr(Sub, None, destAssembly, src1Assembly, src2Assembly))
                case A_Mul => List(TernaryAssInstr(Mul, None, destAssembly, src1Assembly, src2Assembly))
                case A_Div => {
                    val saveRegs = allocator.saveArgs(List(R1))
                    // TODO: Add a saveargs function to the register allocator to
                    // save Return and R1 before we do this...
                    saveRegs ++ List(BinaryAssInstr(Mov, None, Return, src1Assembly),
                    BinaryAssInstr(Mov, None, R1, src2Assembly),
                    BranchLinked(DivMod),
                    BinaryAssInstr(Mov, None, destAssembly, Return))
                    // branch with link to __aeabi_idivmod
                }
                case A_Mod => {
                    val saveRegs = allocator.saveArgs(List(R1))
                    // save Return and R1 before we do this...
                    saveRegs ++ List(BinaryAssInstr(Mov, None, Return, src1Assembly),
                    BinaryAssInstr(Mov, None, R1, src2Assembly),
                    BranchLinked(DivMod),
                    BinaryAssInstr(Mov, None, destAssembly, R1))
                    // branch with link to __aeabi_idivmod
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
            val (srcInstr, srcAssembly) = translateValue(src, allocator)
            val (destInstr, destAssembly) = translateValue(dst, allocator)
            val finalInstrs = op match {
                case A_Not => List(TernaryAssInstr(NE, None, destAssembly, Imm(1), srcAssembly))
                case A_Neg => List(TernaryAssInstr(Sub, None, destAssembly, Imm(0), srcAssembly))
                case A_Len => List(BinaryAssInstr(Mov, None, destAssembly, Offset(srcAssembly, Imm(-4))))
                case A_Chr => List(BinaryAssInstr(Mov, None, destAssembly, srcAssembly))
                case A_Ord => List(BinaryAssInstr(Mov, None, destAssembly, srcAssembly))
                case A_ArrayCreate => Nil
                case A_Assign => List(BinaryAssInstr(Mov, None, destAssembly, srcAssembly))
                case A_Mov => List(BinaryAssInstr(Mov, None, destAssembly, srcAssembly))
            }
            srcInstr ++ destInstr ++ finalInstrs
        }
        case InbuiltFunction(op, src) => op match {
            case A_PrintI => {
                usedFunctions.addOne(PrintI)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ List(BinaryAssInstr(Mov, None, Return, srcOp),
                BranchLinked(PrintI))
            }
            case A_PrintB => {
                usedFunctions.addOne(PrintB)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ List(BinaryAssInstr(Mov, None, Return, srcOp),
                BranchLinked(PrintB))
            }
            case A_PrintC => {
                usedFunctions.addOne(PrintC)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ List(BinaryAssInstr(Mov, None, Return, srcOp),
                BranchLinked(PrintC))
            }
            case A_PrintS => {
                usedFunctions.addOne(PrintS)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ List(BinaryAssInstr(Mov, None, Return, srcOp),
                BranchLinked(PrintS))
            }
            case A_PrintA => {
                usedFunctions.addOne(PrintA)
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ List(BinaryAssInstr(Mov, None, Return, srcOp),
                BranchLinked(PrintA))
            }
            case A_Println => {
                usedFunctions.addOne(PrintLn)
                List(BranchLinked(PrintLn))
            }
            case A_ArrayCreate => Nil
            case A_Exit => {    
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ List(BinaryAssInstr(Mov, None, Return, srcOp),
                BranchLinked(Exit))
            }
            case A_Free => {    
                val (srcInstr, srcOp) = translateValue(src, allocator)
                srcInstr ++ List(BinaryAssInstr(Mov, None, Return, srcOp),
                BranchLinked(Free))
            }
            case A_Len => Nil
            case A_PairCreate => Nil
            case A_Read => Nil
            case A_Return => Nil

            // We will need to define a separate object containing a map from
            // AssemblyOperators to the functions and their definitions
             
        }
        case FunctionCall(name, args, dst) => Nil
        case IfInstruction(condition, ifInstructions, elseInstructions) => Nil
        case WhileInstruction(condition, body) => Nil
    }
}
