// package wacc

// class RegisterAllocator(){
//     import Assembly._
//     var stackSize: Int = 0
//     val storage = Map.empty[String, Storage]

//     val availableRegisters = Stack[Register]()
//     availableRegisters.pushAll(generalRegisters)

//     def getRegister(name: String): (List[AssInstr], Register) = storage.get(name) match{
//         case Some(store) => store match{
//             case Reg(r) => {
//                 return (Nil, r)
//             }
//             case Stored(offset) => {
//                 // Reload the value to a register
//             }
//         }
//         case None => {
//             // Get a new register
//         }
//     }

//     private def getFreeRegister()
// }

// object Storage {
//     sealed trait Storage
//     case class Reg(reg: Register) extends Storage
//     case class Stored(offset: Int) extends Storage
// }
