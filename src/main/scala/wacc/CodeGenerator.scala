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

    val inbuiltNameMap = Map[InBuilt, String](
        PrintI -> "_printi",
        PrintB -> "_printb",
        PrintC -> "_printc",
        PrintS -> "_prints",
        PrintA -> "_printp",
        PrintLn -> "_println"
    )

    val registerMap = Map[Register, String](
        Return -> "r0",
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

    val inbuiltMap = Map[InBuilt, String](
        PrintI -> """.data
    .word 2
.L._printi_str0:		
    .asciz "%d"
.text
_printi:
    push {lr}
    mov r1, r0
    ldr r0, =.L._printi_str0
    bl printf
    mov r0, #0
    bl fflush
    pop {pc}""",
        PrintB -> """.data
    .word 5
.L._printb_str0:
    .asciz "false"
    .word 4
.L._printb_str1:
    .asciz "true"
    .word 4
.L._printb_str2:
    .asciz "%.*s"
.text
_printb:
    push {lr}
    cmp r0, #0
    bne .L_printb0
    ldr r2, =.L._printb_str0
    b .L_printb1
.L_printb0:
    ldr r2, =.L._printb_str1
.L_printb1:
    ldr r1, [r2, #-4]
    ldr r0, =.L._printb_str2
    bl printf
    mov r0, #0
    bl fflush
    pop {pc}""",
        PrintC -> """.data
    .word 2
.L._printc_str0:
	.asciz "%c"
.text
_printc:
	push {lr}
	mov r1, r0
	ldr r0, =.L._printc_str0
	bl printf
	mov r0, #0
	bl fflush
	pop {pc}""",
        PrintS ->""".data
    .word 4
.L._prints_str0:
    .asciz "%.*s"
.text
_prints:
	push {lr}
	mov r2, r0
	ldr r1, [r0, #-4]
	ldr r0, =.L._prints_str0
	bl printf
	mov r0, #0
	bl fflush
	pop {pc}""",
        PrintA -> """.data
    .word 2
.L._printp_str0:
	.asciz "%p"
.text
_printp:
	push {lr}
	mov r1, r0
	ldr r0, =.L._printp_str0
	bl printf
	mov r0, #0
	bl fflush
	pop {pc}""",
        PrintLn -> """.data
    .word 0
.L._println_str0:
	.asciz ""
.text
_println:
	push {lr}
	ldr r0, =.L._println_str0
	bl puts
	mov r0, #0
	bl fflush
	pop {pc}""")
    
    def buildAssembly(program: AssProg, waccName: String, usedInbuilts: Set[InBuilt]) = {
        val outputFile = new File(newFileName(waccName))
        val writer = new BufferedWriter(new FileWriter(outputFile))
        writer.append(assemblyToString(program))
        usedInbuilts.map(inbuilt => writer.append("\n" + inbuiltMap(inbuilt)))
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
        if (block.label.label == ("main")) {
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
                instructionBuilder.append(operandToString(op1) + ", ")
                instructionBuilder.append(operandToString(op2) + ", ")
                instructionBuilder.append(operandToString(op3) + ", ")
                instructionBuilder.append(operandToString(op4))
            }
            case TernaryAssInstr(op, cond, op1, op2, op3) => {
                instructionBuilder.append(opcodeMap(op) + " ")
                instructionBuilder.append(operandToString(op1) + ", ")
                instructionBuilder.append(operandToString(op2) + ", ")
                instructionBuilder.append(operandToString(op3))
            }
            case BinaryAssInstr(op, cond, op1, op2) => {
                instructionBuilder.append(opcodeMap(op) + " ")
                instructionBuilder.append(operandToString(op1) + ", ")
                instructionBuilder.append(operandToString(op2))
            }
            case UnaryAssInstr(op, cond, op1) => {
                instructionBuilder.append(opcodeMap(op) + " ")
                if (op == Push || op == Pop){
                    instructionBuilder.append("{" + operandToString(op1) + "}")
                } else {
                    instructionBuilder.append(operandToString(op1))
                }
            }
            case BranchLinked(function) => {
                instructionBuilder.append("bl " + inbuiltNameMap(function))
            }
            case MultiAssInstr(op, operands) => {
                instructionBuilder.append(opcodeMap(op) + " ")
                instructionBuilder.append(operands.head)
                operands.tail.map(o => instructionBuilder.append(", " + operandToString(o)))
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