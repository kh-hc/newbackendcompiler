package wacc

import scala.collection.mutable.ListBuffer

class AssemblyTranslator {
    import assemblyCode._
    import assemblyAbstractStructure._

    val instructions = new ListBuffer[Instruction]()

    def translate(program: Program): AssProg = {
        return AssProg(List(Block(Label("main"), Nil)))
    }
}

