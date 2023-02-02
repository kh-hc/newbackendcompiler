package wacc

import parser.parse
import parsley.{Success, Failure}

object Main {
    def main(args: Array[String]): Unit = {
        println("Hello WACC_46!")

        parse(args.head) match {
            case Success(x) => println(s"${args.head} = $x")
            case Failure(msg) => println(msg)
        }
    }
}
