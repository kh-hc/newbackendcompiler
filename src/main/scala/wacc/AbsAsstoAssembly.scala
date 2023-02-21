package wacc

class AssemblyTranslator {
    import assemblyCode._
    import assemblyAbstractStructure._

    val instructions = new ListBuffer[Blocks]()

    val usedFunctions = new ListBuffer[AssemblyIOperator]()

    def buildAssembly() = {
        // Builds the assembly program, making sure that all boilerplate
        // included functions and tags are correctly formatted
    }

    def translate(program: Program): AssProg = {
        return AssProg(List(Block("main", Nil)))
    }

    def translateMain(instructions: List[Instruction]) = {

    }

    def translateFunction(function: Function) = {

    }

    def translateInstruction(instruction: Instruction, allocator: RegisterAllocator): List[AssInstr] = instruction match{
        case BinaryOperation(op, src1, src2, dst) => op match {
            case A_Add => {
                
            }
            case A_Sub => {

            }
            case A_Mul => {

            }
            case A_Div => {

            }
            case A_Mod => {

            }
            case A_And => {

            }
            case A_Or => {

            }
            case A_GT => {

            }
            case A_GTE => {

            }
            case A_LT => {

            }
            case A_LTE => {

            }
            case A_EQ => {

            }
            case A_NEQ => {

            }
        }
        case UnaryOperation(op, src, dst) => op match {
            case A_Not => {

            }
            case A_Neg => {

            }
            case A_Len => {

            }
            case A_Chr => {

            }
            case A_Ord => {

            }
        }
        case InbuiltFunction(op, src, dst) => op match{
            // We will need to define a separate object containing a map from
            // AssemblyOperators to the functions and their definitions
        }
        case FunctionCall(name, args, dst) => {

        }
    }
}
