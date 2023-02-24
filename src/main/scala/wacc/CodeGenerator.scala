package wacc

object CodeGenerator{
    import java.io.{BufferedWriter, FileWriter, File}
    import assemblyCode._

    val opcodeMap = Map[Opcode, String](
        Add -> "add",
        Mov -> "mov",
        Ldr -> "ldr",
        Str -> "str",
        Push -> "push",
        Pop -> "pop",
        Sub -> "sub",
        Cmp -> "cmp",
        Mul -> "mul",
        And -> "and",
        Or -> "or",
        // TODO: Update or remove to be correct
        EQ -> "cmp",
        NE -> "cmp",
        GE -> "cmp",
        LT -> "cmp",
        GT -> "cmp",
        LE -> "cmp"
    )

    val registerMap = Map[Register, String](
        R0 -> "r0",
        R1 -> "r1",
        R2 -> "r2",
        R3 -> "r3",
        R4 -> "r4",
        R5 -> "r5",
        R6 -> "r6",
        R7 -> "r7",
        R8 -> "r8",
        R9 -> "r9",
        R10 -> "r10",
        FP -> "fp",
        IPC -> "r12",
        SP -> "sp",
        LR -> "lr",
        PC -> "pc"
    )
    
    def buildAssembly(program: AssProg, waccName: String) = {
        val outputFile = new File(newFileName(waccName))
        val writer = new BufferedWriter(new FileWriter(outputFile))
        writer.append(assemblyToString(program))
        writer.close()
    }

    private def newFileName(fileName: String): String = fileName.dropRight(5).split("/").last + ".s"

    def assemblyToString(program: AssProg): StringBuilder = {
        val assembly = new StringBuilder()
        assembly.append(".data\n")
        assembly.append(".text\n")
        assembly.append(".global main\n")
        program.blocks.map(b => assembly.append(blockToString(b)))
        return assembly
    }

    def blockToString(block: Block): StringBuilder = {
        val blockSB = new StringBuilder()
        if (!block.label.label.equals("main")) {
            blockSB.append("main:\n")
        } else {
            // TODO: ensure function names are consistent
            blockSB.append(s"wacc_${block.label.label}:\n")
        }
        block.instrs.map(i => {
            blockSB.append(instructionToString(i))
            blockSB.append("\n")})
        return blockSB
    }

    def instructionToString(instr: AssInstr): StringBuilder = {
        val instructionBuilder = new StringBuilder()
        instr match {
            case QuaternaryAssInstr(op, cond, op1, op2, op3, op4) => {
                instructionBuilder.append(opcodeMap(op) + " ")
                instructionBuilder.append(operandToString(op1) + " ")
                instructionBuilder.append(operandToString(op2) + " ")
                instructionBuilder.append(operandToString(op3) + " ")
                instructionBuilder.append(operandToString(op4) + " ")
            }
            case TernaryAssInstr(op, cond, op1, op2, op3) => {
                instructionBuilder.append(opcodeMap(op) + " ")
                instructionBuilder.append(operandToString(op1) + " ")
                instructionBuilder.append(operandToString(op2) + " ")
                instructionBuilder.append(operandToString(op3) + " ")
            }
            case BinaryAssInstr(op, cond, op1, op2) => {
                instructionBuilder.append(opcodeMap(op) + " ")
                instructionBuilder.append(operandToString(op1) + " ")
                instructionBuilder.append(operandToString(op2) + " ")
            }
            case UnaryAssInstr(op, cond, op1) => {
                instructionBuilder.append(opcodeMap(op) + " ")
                instructionBuilder.append(operandToString(op1) + " ")
            }
            case BranchLinked(function) => instructionBuilder.append(s"bl wacc_$function")
            case MultiAssInstr(op, operands) => {
                instructionBuilder.append(opcodeMap(op) + " ")
                operands.map(o => instructionBuilder.append(operandToString(o) + " "))
            }
        }
        return instructionBuilder
    }

    def operandToString(operand: Operand): String = operand match{
        case r: Register => registerMap(r)
        case Label(label) => label
        case Offset(reg, offset) => s"[${operandToString(reg)}, ${operandToString(offset)}]"
        case Imm(x) => s"#${x.toString()}"
    }
}