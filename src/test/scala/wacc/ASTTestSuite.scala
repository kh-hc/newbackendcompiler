package wacc
import org.scalatest.flatspec.AnyFlatSpec
import java.io.File
import scala.io.Source

class WaccTestSuite extends AnyFlatSpec {
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

  // ("function/simple_functions/asciiTable.wacc") should "be correctly parsed by our parser" in {
  //   val testFile = new File(validRootPath + "function/simple_functions/asciiTable.wacc")
  //   val formattedTest = formatTestFile(testFile)
  //   val formattedParsedProgram = formatParserProgram(testFile)

  //   println("formattedParsedProgram: " + formattedParsedProgram)
  //   println("formattedTest:         " + formattedTest)

  //   assert(formattedTest == formattedParsedProgram)
  // }

  ("if/if1.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "if/if1.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  // ("IO/print/print-backspace.wacc") should "be correctly parsed by our parser" in {
  //   val testFile = new File(validRootPath + "IO/print/print-backspace.wacc")
  //   val formattedTest = formatTestFile(testFile)
  //   val formattedParsedProgram = formatParserProgram(testFile)

  //   println("formattedParsedProgram: " + formattedParsedProgram)
  //   println("formattedTest:         " + formattedTest)

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
  //   println("formattedParsedProgram: " + formattedParsedProgram)
  //   println("formattedTest:         " + formattedTest)
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

  // Gets all text from a file without lines
  def getTextFromFile(file : File) : String = {
    val lines = Source.fromFile(file).getLines()
    var formattedLines = ""
    for (line <- lines) {
      val lineWithoutWhitespace = discardWhitespace(line)
      val len = lineWithoutWhitespace.length
      if (len > 0) {
        // for (j <- 0 to len - 1) {
        //   if (lineWithoutWhitespace.charAt(j) == '#') {
        //     // println(lineWithoutWhitespace + " j: " + j + lineWithoutWhitespace.slice(0, j))
        //     val lineWithoutComments = lineWithoutWhitespace.slice(0, j)
        //     formattedLines = formattedLines + lineWithoutComments
        //   } else {
        //     formattedLines = formattedLines + lineWithoutWhitespace
        //   }
        // }
        if (lineWithoutWhitespace.charAt(0) != '#') {
          formattedLines = formattedLines + line
        }
      }
    }
    return formattedLines
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
}