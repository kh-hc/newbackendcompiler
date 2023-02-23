package wacc



class RegisterAllocator() {
    import assemblyCode._
    import scala.collection.mutable.Map
    import scala.collection.mutable.ListBuffer
    import scala.collection.mutable.Stack
    import scala.collection.mutable.Queue
    import Storage._

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
                val (instructions, register) = getFreeRegister()
                storage.addOne((name, Reg(register)))
                return (instructions, register)
            }
        }
        case None => {
            val (instructions, register) = getFreeRegister()
            store(name, register)
            return (instructions, register)
        }
    }

    private def getFreeRegister(): (List[AssInstr], Register) = {
        val freeingInstructions = new ListBuffer[AssInstr]
        if (availableRegisters.isEmpty) {
            // If there are no available registers, store a value on the stack
            val registerToFree = usedRegisters.dequeue()
            val variableToStore = registerMap.get(registerToFree)
            stackSize = stackSize + 1
            freeingInstructions += BinaryAssInstr(Str, Option(N), Offset(FP, Imm(4 * stackSize)), registerToFree)
            storage(variableToStore.get) = Stored(stackSize)
        }
        return (freeingInstructions.toList, availableRegisters.pop())
    }

    private def store(name: String, register: Register) = {
        // Assuming the old value in the register has been stored already
        registerMap(register) = name
        storage(name) = Reg(register)
    }
}

object Storage {
    import assemblyCode._
    sealed trait Storage
    case class Reg(reg: Register) extends Storage
    case class Stored(offset: Int) extends Storage
}