package wacc

import parser.parse
import parsley.{Success, Failure}
import java.io.File

object Main {
    def main(args: Array[String]): Unit = {
        val myFile = new File(args.head)
        try{
            parse(myFile) match {
                case Success(x) => {
                    val sa = new SemanticAnalyzer(args.head)
                    sa.analyzeProgram(x)
                    if (sa.isErrors()){
                        sa.getErrors().map(e =>  println(e))
                        sys.exit(200)
                    } else {
                        sys.exit(0)
                    }
                }
                case Failure(x) => {
                    println(x)
                    sys.exit(100)
                }
            }
        } catch {
            case e: Exception => println("Fatal error: file could not be read.")
        }
    }
}
