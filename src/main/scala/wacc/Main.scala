package wacc

import parser.parse
import parsley.{Success, Failure}
import java.io.File

object Main {
    def main(args: Array[String]): Unit = {
        println("Hello WACC_46!")

        val myFile = new File(args.head)

        parse(myFile) match {
            case Success(x) => println(s"${args.head} = $x")
            case Failure(msg) => println(msg)
        }
    }
}
