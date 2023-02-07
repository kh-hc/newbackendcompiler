package wacc

import parser.parse
import parsley.{Success, Failure}
import SemanticAnalyzer.analyzeProgram
import java.io.File

object Main {
    def main(args: Array[String]): Unit = {
        val myFile = new File(args.head)

        parse(myFile) match {
            case Success(x) => {
                try{
                    analyzeProgram(x)
                    sys.exit(0)
                } finally {
                    sys.exit(200)
                }
            }
            case Failure(x) => sys.exit(100)
        }
    }
}
