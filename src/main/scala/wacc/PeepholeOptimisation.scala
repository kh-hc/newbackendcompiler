package wacc

import assemblyCode._

object PeepholeOptimisation {

    /*
    Applies peephole optimisation to the intermediary assembly code produced
    by our AbsAssToAssmebly translator
    */

    def peepholeOptimise (intermediaryAssembly : (AssProg, List[Block])) : (AssProg, List[Block]) = {
        val assembly = intermediaryAssembly._1
        val funcs = intermediaryAssembly._2
        
        // AssProg is a List[Block] by defintion, so can type cast
        val optimisedAssembly = optimise(assembly.blocks)
        val optimisedFuncs = optimise(funcs)

        return (new AssProg(optimisedAssembly), optimisedFuncs)
    }

    /*
    Iterates over the List[Block] and optimises each block
    */
    def optimise (intermediaryAssembly : List[Block]) : List[Block] = {
        var optimisedBlocks = List[Block]()
        for (block <- intermediaryAssembly) {
            val optimisedInstr = optimiseBlock(block.instrs)
            val optimisedBlock = new Block(block.label, optimisedInstr)
            optimisedBlocks = optimisedBlocks :+ optimisedBlock
        }
        return optimisedBlocks
    }
    
    /*
    Actual function applying peephole optimisation on a Block of instructions
    */
    def optimiseBlock (instructions : List[AssInstr]) : List[AssInstr] = {
        var optimisedInstructions = List[AssInstr]()
        // var ignoreNextInstr = false

        var count = 0
        // Don't check the last instruction, as we check the current instruction with
        // respect to the instructions after it
        while (count != (instructions.length - 2)) {
            val currInstr = instructions(count)
            val nextInstr = instructions(count + 1)
            (currInstr, nextInstr) match {
                case (BinaryAssInstr(Mov, condCurr, op1Curr, op2Curr),
                    BinaryAssInstr(Mov, condNext, op1Next, op2Next)) => {
                    // Discard instructions of the form Mov Rn Rn
                    if (op1Curr != op2Curr) {
                        // When we have the following, discard the second instruction:
                        // Mov Rn Rm
                        // Mov Rm Rn    OR   Mov Rn Rm
                        if ((op1Curr == op1Next && op2Curr == op2Next)
                            || op1Curr == op2Next && op2Curr == op1Next) {
                            optimisedInstructions = optimisedInstructions :+ currInstr
                            count = count + 1
                            println(s"CurrInstr: $currInstr \nRemoving $nextInstr\n")
                        }
                        else {
                            optimisedInstructions = optimisedInstructions :+ currInstr
                        }
                    }
                }
                case default => optimisedInstructions = optimisedInstructions :+ currInstr
            }
            count = count + 1
        }
        return optimisedInstructions
    }
}