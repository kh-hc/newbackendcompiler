package wacc

class RegisterAllocator() {
    import Assembly._
    var stackSize: Int = 0
    var storage = Map.empty[String, Storage]
    var registerMap = Map.empty[Register, String]

    val availableRegisters = Stack[Register]()
    availableRegisters.pushAll(generalRegisters)
    val usedRegisters = Queue[Register]()

    def getRegister(name: String): (List[AssInstr], Register) = storage.get(name) match{
        case Some(store) => store match {
            case Reg(r) => {
                return (Nil, r)
            }
            case Stored(offset) => {
                val (instructions, register) = getFreeRegister
                store(name, register)
                return (instructions, register)
            }
        }
        case None => {
            val (instructions, register) = getFreeRegister
            store(name, register)
            return (instructions, register)
        }
    }

    private def getFreeRegister(): (List[AssInstr], Register) = {
        val freeingInstructions = new ListBuffer[AssInstr]
        if (availableRegisters.empty) {
            // If there are no available registers, store a value on the stack
            val registerToFree = usedRegisters.pop
            val variableToStore = registerMap[registerToFree]
            stackSize = stackSize + 1
            freeingInstructions += BinaryAssInstr(Str, N, Offset(FP, Immediate(4 * stackSize)), registerToFree)
            storage[name] = Stored(stackSize)
        }
        return (freeingInstructions.toList, availableRegisters.pop)
    }

    private def store(name: String, register: Register) = {
        // Assuming the old value in the register has been stored already
        registerMap[register] = name
        storage[name] = Reg(register)
    }
}

object Storage {
    sealed trait Storage
    case class Reg(reg: Register) extends Storage
    case class Stored(offset: Int) extends Storage
}