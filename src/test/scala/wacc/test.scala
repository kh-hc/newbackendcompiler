import org.scalatest.flatspec.AnyFlatSpec
import scala.sys.process._

/*
To run the test suite, run "sbt test" in the main directory

Note that some tests will fail, until enough of the WACC compiler is implemented
such that the correct error codes are returned - in the skeleton version of the
project, the exit code 0 is always returned
*/

class ValidProgram extends AnyFlatSpec {

  "Valid program valid/if/if1.wacc" should "return an exit code of 0" in {
    val exitCode = Seq("./compile", "src/test/scala/wacc/test_cases/valid/if/if1.wacc").!
    // println("EXIT CODE: ", exitCode)
    assert(exitCode == 0)
  }

  "Invalid program printTypeErr01 with a syntax error" should "return an exit code of 100" in {
    val exitCode = Seq("./compile",
      "src/test/scala/wacc/test_cases/invalid/syntaxErr/expressions/missingOperand1.wacc").!
    assert(exitCode == 100)
  }

  "Invalid program printTypeErr01 with a semantic error" should "return an exit code of 200" in {
    val exitCode = Seq("./compile",
      "src/test/scala/wacc/test_cases/invalid/semanticErr/print/printTypeErr01.wacc").!
    assert(exitCode == 200)
  }

}