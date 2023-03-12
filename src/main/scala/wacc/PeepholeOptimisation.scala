package wacc

import assemblyCode._

object PeepholeOptimisation {

    /*
    Applies peephole optimisation to the intermediary assembly code produced
    by our AbsAssToAssembly translator
    */

    def peepholeOptimise (intermediaryAssembly : (AssProg, List[Block])) : (AssProg, List[Block]) = {
        val assembly = intermediaryAssembly._1
        val funcs = intermediaryAssembly._2
        
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

        var count = 0
        val numOfInstr = instructions.length
        // Don't check the last instruction, as we check the current instruction with
        // respect to the instructions after it
        while (count != (numOfInstr - 2)) {
            val currInstr = instructions(count)
            val nextInstr = instructions(count + 1)
            (currInstr, nextInstr) match {
                case (BinaryAssInstr(Mov, condCurr, op1Curr, op2Curr),
                    BinaryAssInstr(Mov, condNext, op1Next, op2Next)) => {
                    val updated = assessOptimality (optimisedInstructions, currInstr, nextInstr,
                                                            op1Curr, op2Curr, op1Next, op2Next, count)
                    optimisedInstructions = updated._1
                    count = updated._2
                }
                case (BinaryAssInstr(Str, condCurr, op1Curr, op2Curr),
                    BinaryAssInstr(Ldr, condNext, op1Next, op2Next)) => {
                    val updated = assessOptimality (optimisedInstructions, currInstr, nextInstr,
                                                            op1Curr, op2Curr, op1Next, op2Next, count)
                    optimisedInstructions = updated._1
                    count = updated._2
                }
                // Removes consecutive pushes from and pops to the same register
                case (UnaryAssInstr(Push, condCurr, opCurr),
                    UnaryAssInstr(Pop, condNext, opNext)) => {
                    if (opCurr == opNext) {
                        count = count + 1
                    }
                }
                case default => optimisedInstructions = optimisedInstructions :+ currInstr
            }
            count = count + 1
        }
        optimisedInstructions = optimisedInstructions :+ instructions(numOfInstr - 2)
        optimisedInstructions = optimisedInstructions :+ instructions(numOfInstr - 1)
        return optimisedInstructions
    }

    def assessOptimality(optimisedInstructionsOld : List[AssInstr], currInstr : AssInstr, nextInstr : AssInstr,
                        op1Curr : Operand, op2Curr : Operand, op1Next : Operand, op2Next : Operand, countOld : Int) : (List[AssInstr], Int) = {
        var optimisedInstructions = optimisedInstructionsOld
        var count = countOld
        // Discard instructions of the form Mov Rn Rn
        if (op1Curr != op2Curr) {
            // When we have the following, discard the second instruction:
            // Mov Rn Rm                  
            // Mov Rn Rm    OR   Mov Rm Rn
            // Also in the case
            // Str Rn Rm
            // Ldr Rn Rm    OR   Ldr Rm Rn
            if ((op1Curr == op1Next && op2Curr == op2Next)
                || op1Curr == op2Next && op2Curr == op1Next) {
                optimisedInstructions = optimisedInstructions :+ currInstr
                count = count + 1
                // println(s"CurrInstr: $currInstr \nRemoving $nextInstr\n")
            }
            else {
                optimisedInstructions = optimisedInstructions :+ currInstr
            }
        }
        return (optimisedInstructions, count)
    }
}
