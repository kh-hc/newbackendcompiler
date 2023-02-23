package wacc

class AssemblyTranslator {
    import assemblyCode._
    import assemblyAbstractStructure._
    import scala.collection.mutable.ListBuffer

    val instructions = new ListBuffer[Block]()

    val usedFunctions = new ListBuffer[AssemblyIOperator]()

    def buildAssembly() = {
        // Builds the assembly program, making sure that all boilerplate
        // included functions and tags are correctly formatted
    }

    def translate(program: Program): AssProg = {
        return AssProg(List(Block(Label("main"), Nil)))
    }

    def translateMain(instructions: List[Instruction]) = {

    }

    def translateFunction(function: Function) = {

    }

    // TODO: Deal with arrays, pairs and strings properly
    def translateValue(value: Value, allocator: RegisterAllocator): (List[AssInstr], Operand) = value match {
        case Stored(id) => allocator.getRegister(id)
        case Immediate(x) => (Nil, Imm(x))
        case ArrayAccess(pos, Stored(id)) => {
            //val accessInstructions = List.empty[AssInstr]
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
                    // TODO: Add a saveargs function to the register allocator to
                    // save R0 and R1 before we do this...
                    List(BinaryAssInstr(Mov, None, R0, src1Assembly),
                    BinaryAssInstr(Mov, None, R1, src2Assembly),
                    BranchLinked("__aeabi_idivmod"),
                    BinaryAssInstr(Mov, None, destAssembly, R0))
                    // branch with link to __aeabi_idivmod
                }
                case A_Mod => {
                    // TODO: Add a saveargs function to the register allocator to
                    // save R0 and R1 before we do this...
                    List(BinaryAssInstr(Mov, None, R0, src1Assembly),
                    BinaryAssInstr(Mov, None, R1, src2Assembly),
                    BranchLinked("__aeabi_idivmod"),
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
            }
            srcInstr ++ destInstr ++ finalInstrs
        }
        case InbuiltFunction(op, src) => op match {
            case A_Print => Nil
            case A_Println => Nil
            // We will need to define a separate object containing a map from
            // AssemblyOperators to the functions and their definitions
             
        }
        case FunctionCall(name, args, dst) => Nil
        case IfInstruction(condition, ifInstructions, elseInstructions) => Nil
        case WhileInstruction(condition, body) => Nil
    }
}
