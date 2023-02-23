package wacc

import org.scalatest.flatspec.AnyFlatSpec
import wacc.abstractSyntaxTree._
import assemblyAbstractStructure._
import java.io.File

class IntermediaryCodeTestSuite extends AnyFlatSpec {

    // Used for some tests - the root path
    val validRootPath = "src/test/scala/wacc/test_cases/valid/"

    ("A simple skip program") should "have intermediary code correctly produced by our translator" in {
        // Create a translator
        val translator = new AbstractTranslator()
        // Create a simple WACC program containing a single skip instruction
        val skip = WACCprogram(Nil, SkipStat)(0, 0)
        // Translate the skip instruction
        val intermediaryCode = translator.translate(skip)
        // Define what we expect as output
        val expectedCode = Program(Nil, Nil)
        assert(intermediaryCode == expectedCode)
    }

    ("basic/skip/skip.wacc") should "have intermediary code correctly produced by our translator" in {
        val testFile = validRootPath + "basic/skip/skip.wacc"
        // Get the intermediary code
        val intermediaryCode = getintermediaryCode(testFile)
        val expectedCode = Program(Nil, Nil)
        assert(intermediaryCode == expectedCode)
    }

    ("basic/skip/comment.wacc") should "be correctly parsed by our parser" in {
        val testFile = validRootPath + "basic/skip/comment.wacc"
        val intermediaryCode = getintermediaryCode(testFile)
        val expectedCode = Program(Nil, Nil)
        assert(intermediaryCode == expectedCode)
    }

    ("basic/exit/exit-1.wacc") should "have intermediary code correctly produced by our translator" in {
        val testFile = validRootPath + "basic/exit/exit-1.wacc"
        val intermediaryCode = getintermediaryCode(testFile)
        val expectedCode = Program(List(UnaryOperation(A_Assign, Immediate(-1), Stored("1")), InbuiltFunction(A_Exit, Stored("1"))), List())
        assert(intermediaryCode == expectedCode)
    }

    ("expressions/divExpr.wacc") should "have intermediary code correctly produced by our translator" in {
        val testFile = validRootPath + "expressions/divExpr.wacc"
        val intermediaryCode = getintermediaryCode(testFile)
        println("intermediary code: ", intermediaryCode)

        // Expected code for main
        var expectedMain = List[Instruction]()
        // int x = 5
        expectedMain = expectedMain ++ List(UnaryOperation(A_Assign, Immediate(5), Stored("1")),
                                        UnaryOperation(A_Assign, Stored("1"), Stored("x0")))
        // int y = 3
        expectedMain = expectedMain ++ List(UnaryOperation(A_Assign, Immediate(3), Stored("3")),
                                        UnaryOperation(A_Assign,Stored("3"),Stored("y0")))
        // x / y
        expectedMain = expectedMain ++ List(UnaryOperation(A_Assign, Stored("x0"), Stored("5")),
                                        UnaryOperation(A_Assign, Stored("y0"), Stored("6")),
                                        BinaryOperation(A_Div, Stored("5"), Stored("6"), Stored("5")))
        // println x / y
        expectedMain = expectedMain ++ List(InbuiltFunction(A_Println, Stored("5")))
        
        val expectedCode = Program(expectedMain, Nil)
        assert(intermediaryCode == expectedCode)
    }

    // ("IO/print/printChar.wacc") should "have intermediary code correctly produced by our translator" in {
    //     val testFile = validRootPath + "IO/print/printChar.wacc"
    //     val intermediaryCode = getintermediaryCode(testFile)
    //     println("intermediary code: ", intermediaryCode)
    //     val expectedCode = Program(Nil, List())
    //     assert(intermediaryCode == expectedCode)
    // }

    // ("expressions/andExpr.wacc") should "be correctly parsed by our parser" in {
    //     val testFile = validRootPath + "expressions/andExpr.wacc"
    //     val intermediaryCode = getintermediaryCode(testFile)
    //     val expectedCode = Program(Nil, Nil)
    //     assert(intermediaryCode == expectedCode)
    // }

    // ("sequence/basicSeq.wacc") should "have intermediary code correctly produced by our translator" in {
    //     val testFile = validRootPath + "sequence/basicSeq.wacc"
    //     val intermediaryCode = getintermediaryCode(testFile)
    //     val expectedCode = Program(Nil, Nil)
    //     assert(intermediaryCode == expectedCode)
    // }

    // ("variables/boolDeclaration.wacc") should "be correctly parsed by our parser" in {
    //     val testFile = validRootPath + "variables/boolDeclaration.wacc"
    //     val intermediaryCode = getintermediaryCode(testFile)
    //     var expectedMain = List[Instruction]()

    //     expectedMain = expectedMain ++ 

    //     val expectedCode = Program(expectedMain, Nil)
    //     assert(intermediaryCode == expectedCode)
    // }

//    ("while/fibonacciFullIt.wacc") should "have intermediary code correctly produced by our translator" in {
//         val testFile = validRootPath + "while/fibonacciFullIt.wacc"
//         val conditions = translateExp(cond, intermediate, stat.symbolTable.get)
//         val intermediaryCode = getintermediaryCode(testFile)
//         println("intermediary code: ", intermediaryCode)
//         val expectedCode = Program(List(WhileInstruction(Conditional(intermediate, conditions), translateStat(body)))) 
//         // List(WhileInstruction(Conditional(intermediate, conditions), translateStat(body)))
//         assert(intermediaryCode == expectedCode)
//     }

    def getintermediaryCode(filePath : String) : Program = {
        // Get the intermediary code
        val ast = parser.parse(new File(filePath)).get
        // println(ast)
        val sa = new SemanticAnalyzer("test suite")
        sa.analyzeProgram(ast)
        // Create a translator
        val translator = new AbstractTranslator()
        // Translate the ast into intermediary code
        val translation = translator.translate(ast)
        // println(translation)
        // println("\n\n\n")
        return translation
    }
}