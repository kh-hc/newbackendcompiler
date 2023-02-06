package wacc
// import org.scalacheck.Properties
// import scala.sys.process._
import org.scalatest.flatspec.AnyFlatSpec
import java.io.File
import scala.io.Source

// object TestingTheTestSuite extends Properties("PrettyPrinters") {

//   property("prettyPrintFunction")  =>
//     (a+b).startsWith(a)
//   }
  
class WaccTestSuite extends AnyFlatSpec {
  // val testProgram = ast.WACCprogram(List(), ast.SkipStat)
  // ("Test program") should "output \"skip\"" in {
  //   assert(PrettyPrinters.prettyPrintStatement(ast.SkipStat) == "skip")
  // }

  // One test for each subdirectory in the valid folder

  // Get the root path
  val validRootPath = "src/test/scala/wacc/test_cases/valid/"

  ("advanced/binarySortTree.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "advanced/binarySortTree.wacc")

    // Format the test file for comparison
    val formattedTest = formatTestFile(testFile)

    // Parse the test file and format it for comparison
    val formattedParsedProgram = formatParserProgram(testFile)

    // println("formattedParsedProgram: " + formattedParsedProgram)
    // println("\nformattedTest:          " + formattedTest)

    // Check that the parser works by comparing it to the test file
    assert(formattedTest == formattedParsedProgram)
  }

  ("basic/exit/exit-1.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "basic/exit/exit-1.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("basic/skip/comment.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "basic/skip/comment.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("expressions/andExpr.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "expressions/andExpr.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("function/nested_functions/fibonacciFullRec.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "function/nested_functions/fibonacciFullRec.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  // ("function/simple_functions/fibonacciFullRec.wacc") should "be correctly parsed by our parser" in {
  //   val testFile = new File(validRootPath + "function/simple_functions/asciiTable.wacc")
  //   val formattedTest = formatTestFile(testFile)
  //   val formattedParsedProgram = formatParserProgram(testFile)
  //   assert(formattedTest == formattedParsedProgram)
  // }

  ("if/if1.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "if/if1.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  // ("IO/print/hashInProgram.wacc") should "be correctly parsed by our parser" in {
  //   val testFile = new File(validRootPath + "IO/print/hashInProgram.wacc")
  //   val formattedTest = formatTestFile(testFile)
  //   val formattedParsedProgram = formatParserProgram(testFile)
  //   assert(formattedTest == formattedParsedProgram)
  // }

  ("IO/read/echoBigInt.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "IO/read/echoBigInt.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  // ("IO/IOLoop.wacc") should "be correctly parsed by our parser" in {
  //   val testFile = new File(validRootPath + "IO/IOLoop.wacc")
  //   val formattedTest = formatTestFile(testFile)
  //   val formattedParsedProgram = formatParserProgram(testFile)
  //   assert(formattedTest == formattedParsedProgram)
  // }

  // ("pairs/checkRefPair.wacc") should "be correctly parsed by our parser" in {
  //   val testFile = new File(validRootPath + "pairs/checkRefPair.wacc")
  //   val formattedTest = formatTestFile(testFile)
  //   val formattedParsedProgram = formatParserProgram(testFile)
  //   assert(formattedTest == formattedParsedProgram)
  // }


  ////////////// Helper functions

  def discardWhitespace(text : String) : String = {
    text.replace(" ", "").replace("\n", "").replace("\t", "")
  }

  // Gets all text from a file without lines or whitespace
  def getTextFromFile(file : File) : String = {
    val lines = Source.fromFile(file).getLines()
    var formattedLines = ""
    for (line <- lines) {
      val lineWithoutWhitespace = discardWhitespace(line)
      if (lineWithoutWhitespace.length > 0) {
        if (lineWithoutWhitespace.charAt(0) != '#') {
          formattedLines = formattedLines + line
        }
      }
    }
    discardWhitespace(formattedLines)
  }

  // Format the test file for comparison
  def formatTestFile(file : File) : String = {
    val testFileLines = getTextFromFile(file)
    discardWhitespace(testFileLines)
  }

  // Parse the test file and format it for comparison
  def formatParserProgram(file : File) : String = {
    val parsedProgram = parser.parse(file).get
    val functions = parsedProgram.funcs
    val statement = parsedProgram.stat
    
    var parsedProgramLines = "begin"
    for (function <- functions) {
      parsedProgramLines = parsedProgramLines + PrettyPrinters.prettyPrintFunction(function)
    }
    parsedProgramLines = parsedProgramLines + PrettyPrinters.prettyPrintStatement(statement)
    while (parsedProgramLines.charAt(parsedProgramLines.length - 1) == ';') {
      parsedProgramLines = parsedProgramLines.slice(0, parsedProgramLines.length - 2)
    }
    parsedProgramLines = parsedProgramLines + "end"
    discardWhitespace(parsedProgramLines)
  }

  // def parsedProgramIsCorrect(formattedTest : String, formattedParsedProgram : String) = {
  //   if (formattedTest.length >= formattedParsedProgram.length) {
  //     compare(formattedTest, formattedParsedProgram)
  //   } else {
  //     compare(formattedParsedProgram, formattedTest)
  //   }
  // }

  // def compare(stringLonger : String, stringShorter : String) {
  //   for (i <- 0 to stringLonger.length) {
  //     val charLonger = stringLonger.charAt(i)
  //     val charShorter = stringLonger.charAt(i)
  //     while (charLonger == )
  //   }
  // }
}