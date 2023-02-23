package wacc

import org.scalatest.flatspec.AnyFlatSpec
import wacc.abstractSyntaxTree._
import assemblyAbstractStructure._
import java.io.File

class IntermediaryCodeTestSuite extends AnyFlatSpec {
    
    // Create a translator for the test suite to use
    val translator = new AbstractTranslator()

    // Used for some tests - the root path
    val validRootPath = "src/test/scala/wacc/test_cases/valid/"

    ("A simple skip program") should "have intermediary code correctly produced by our translator" in {
        // Create a simple WACC program containing a single skip instruction
        val skip = WACCprogram(Nil, SkipStat)(0, 0)
        // Translate the skip instruction
        val intermediateCode = translator.translate(skip)
        // Define what we expect as output
        val expectedCode = Program(Nil, Nil)
        assert(intermediateCode == expectedCode)
    }

    ("basic/skip/skip.wacc") should "have intermediary code correctly produced by our translator" in {
        val testFile = validRootPath + "basic/skip/skip.wacc"
        // Get the intermediate code
        val intermediateCode = getIntermediateCode(testFile)
        val expectedCode = Program(Nil, Nil)
        assert(intermediateCode == expectedCode)
    }

    // ("basic/exit/exit-1.wacc") should "have intermediary code correctly produced by our translator" in {
    //     val testFile = validRootPath + "basic/exit/exit-1.wacc"
    //     val intermediateCode = getIntermediateCode(testFile)
    //     println("Intermediate code: ", intermediateCode)
    //     val expectedCode = Program(Nil, Nil) 
    //     assert(intermediateCode == expectedCode)
    // }

    def getIntermediateCode(filePath : String) : Program = {
        // Get the intermediate code
        val ast = parser.parse(new File(filePath)).get
        return translator.translate(ast)
    }
}