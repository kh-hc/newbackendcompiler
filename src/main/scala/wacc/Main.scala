package wacc

import parser.parse
import parsley.{Success, Failure}
import java.io.File

object Main {
    def main(args: Array[String]): Unit = {
        val myFile = new File(args.head)

        parse(myFile) match {
            case Success(x) => sys.exit(0)
            case Failure(x) => sys.exit(100)
        }
    }
}
