package wacc

class RegisterAllocator() {
    import assemblyIR._
    import scala.collection.mutable.{Map, ListBuffer, Stack, Queue, Set}
    import Storage._

    var stackSize: Int = 0
    var storage = Map.empty[String, Storage]
    var stackMap = Map.empty[String, Stored]
    var registerMap = Map.empty[Register, String]

    val accessRegisters = Set[Register]()

    val availableRegisters = Stack[Register]()
    availableRegisters.pushAll(generalRegisters)
    val usedRegisters = Queue[Register]()
    val usedEverRegisters = Set[Register]()
    val reserveStack = Stack[Register]()

    // Note that this is heavily unoptimized
    def getRegister(name: String): (List[AssInstr], Register) = {
      val (instrs, reg) = getReg(name)
      reserveStack.push(reg)
      (instrs, reg)
    }
    
    def clearReserve() = {
      reserveStack.popAll()
    }

    def getReg(name: String): (List[AssInstr], Register) = storage.get(name) match{
      case Some(s) => s match {
            case Reg(r) => {
                (Nil, r)
            }
            case Stored(offset) => {
                val (instructions, register) = getFreeRegister()
                (instructions ++ load(name, register, offset), register)
            }
        }
        case None => {
            val (instructions, register) = getFreeRegister()
            store(name, register)
            (instructions, register)
        }
    }

    // Gets registers for nested array/pair accesses
    // Assumes that there are more than two registers available
    def getNewAccessRegister(accessLocation: Register): (List[AssInstr], Register) = {
        if (availableRegisters.isEmpty) {
            if (usedRegisters.front == accessLocation){
                usedRegisters.enqueue(usedRegisters.dequeue())
            }
        }
        getFreeRegister()
    }

    private def getFreeRegister(): (List[AssInstr], Register) = {
        val freeingInstructions = new ListBuffer[AssInstr]
        if (availableRegisters.isEmpty) {
            // If there are no available registers, store a value on the stack
            val registerToFree = usedRegisters.dequeue()
            freeingInstructions.appendAll(addValueToStack(registerToFree))
        }
        val reg = availableRegisters.pop()
        usedEverRegisters.add(reg)
        usedRegisters.enqueue(reg)
        return (freeingInstructions.toList, reg)
    }

    def addValueToStack(registerToFree: Register): List[AssInstr] = {
        val freeingInstructions = new ListBuffer[AssInstr]
        if (registerMap.contains(registerToFree)) {
            val variableToStore = registerMap.get(registerToFree)
            registerMap.remove(registerToFree)
            stackMap.get(variableToStore.get) match {
                case Some(Stored(x)) =>{
                    freeingInstructions += BinaryAssInstr(Str(Word), None, registerToFree, Offset(FP, Imm(-(4 * x)), Word))
                    storage(variableToStore.get) = Stored(x)
                }
                case None =>{
                    stackSize += 1
                    freeingInstructions += BinaryAssInstr(Str(Word), None, registerToFree, Offset(FP, Imm(-(4 * stackSize)), Word))
                    stackMap(variableToStore.get) = Stored(stackSize)
                    storage(variableToStore.get) = Stored(stackSize)
                }
            }
        }
        availableRegisters.push(registerToFree)
        usedRegisters.removeFirst(p => p == registerToFree)
        freeingInstructions.toList
    }

    private def store(name: String, register: Register) = {
        // Assuming the old value in the register has been stored already
        registerMap(register) = name
        storage(name) = Reg(register)
    }

    private def load(name: String, register: Register, offset: Int): List[AssInstr] = {
        store(name, register)
        List(BinaryAssInstr(Ldr(Word), None, register, Offset(FP, Imm(-(4 * offset)), Word)))
    }

    def getState(): Map[Register, String] = registerMap.clone()

    def reloadState(oldRegMap: Map[Register, String]): List[AssInstr] = {
        val instructions = new ListBuffer[AssInstr]
        for ((reg, name) <- oldRegMap) {
            if (valueContains(registerMap, name)) {
                storage (name) match {
                    case Reg(x) => {
                        if (x != reg) {
                            val regValue = registerMap.getOrElse(reg, "")
                            if (valueContains(oldRegMap, regValue)) {
                                instructions.append(BinaryAssInstr(Mov, None, R1, reg))
                                instructions.append(BinaryAssInstr(Mov, None, reg, x))
                                instructions.append(BinaryAssInstr(Mov, None, x, R1))
                                store(regValue, x)
                            } else {
                                instructions.appendAll(addValueToStack(reg))
                                instructions.append(BinaryAssInstr(Mov, None, reg, x))
                            }
                            store(name, reg)
                        }
                    }
                    // If it's in the register map I'd hope it's not in storage as something other than a register...
                    case _ => Nil
                }
            } else {
                instructions.appendAll(addValueToStack(reg))
                val loadAddr = storage(name) match {
                    case Stored(x) => x
                    case _ => 0
                }
                instructions.appendAll(load(name, reg, loadAddr))
            }
        }
        for ((reg, name) <- registerMap) {
            if (!(oldRegMap contains reg)){
                instructions.appendAll(addValueToStack(reg))
            }
        }
        instructions.toList
    }

    private def valueContains[A](map: Map[_, A], value: A): Boolean = map.values.foldLeft(false)((b, v) => b || v == value)

    def loadArgs(args: List[String]): List[AssInstr] = {
        var count = 0
        val numberOfArgs = args.length
        val retrievalInstrs = new ListBuffer[AssInstr]
        for (arg <- args) {
                if (count < 4) {
                    val reg = argumentRegisters(count)
                    val (instrs, newReg) = getRegister(arg)
                    retrievalInstrs.addAll(instrs)
                    retrievalInstrs += BinaryAssInstr(Mov, None, newReg, reg)
                } else {
                    val (instrs, newReg) = getRegister(arg)
                    retrievalInstrs.addAll(instrs)
                    retrievalInstrs += BinaryAssInstr(Ldr(Word), None, newReg, Offset(FP, Imm((numberOfArgs - count + 1) * 4), Word))
                    storage(arg) = Stored((numberOfArgs - count + 1) * -1)
                }
                count = count + 1
            }
        retrievalInstrs.toList
    }

    def generateBoilerPlate(): (List[AssInstr], List[AssInstr]) = {
        val pushInstr = ListBuffer[AssInstr]()
        pushInstr.append(UnaryAssInstr(Push, None, LR))
        pushInstr.append(UnaryAssInstr(Push, None, FP))
        pushInstr.append(BinaryAssInstr(Mov, None, FP, SP))
        if (stackSize > 0) {
            pushInstr.append(BinaryAssInstr(Ldr(Word), None, IPC, Imm(stackSize * 4)))
            pushInstr.append(TernaryAssInstr(Sub, None, SP, SP, IPC))
        }
        val popInstr = ListBuffer[AssInstr]()
        for (reg <- usedEverRegisters) {
            pushInstr.append(UnaryAssInstr(Push, None, reg))
            popInstr.append(UnaryAssInstr(Pop, None, reg))
        }
        val revPop = popInstr.reverse
        revPop.append(BinaryAssInstr(Mov, None, SP, FP))
        revPop.append(UnaryAssInstr(Pop, None, FP))
        revPop.append(UnaryAssInstr(Pop, None, PC))
        return (pushInstr.toList, revPop.toList)
    }

    def saveArgs(regs: List[Register]): (List[AssInstr], List[AssInstr]) = {
        return (regs.map(r => UnaryAssInstr(Push, None, r)).toList, regs.map(r => UnaryAssInstr(Pop, None, r)).reverse.toList)
    }
}

object Storage {
    import assemblyIR._
    sealed trait Storage
    case class Reg(reg: Register) extends Storage
    case class Stored(offset: Int) extends Storage
}
