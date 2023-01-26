import org.scalatest.flatspec.AnyFlatSpec
import scala.sys.process._

class ValidProgram extends AnyFlatSpec {

  "Valid program valid/if/if1.wacc" should "return an exit code of 0" in {
    val exitCode = Seq("./compile", "src/test/scala/wacc/test_cases/valid/if/if1.wacc").!
    println("EXIT CODE: ", exitCode)
    assert(exitCode == 0)
  }

}