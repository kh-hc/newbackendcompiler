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

  ("function/simple_functions/asciiTable.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "function/simple_functions/asciiTable.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("if/if1.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "if/if1.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("IO/print/print-backspace.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "IO/print/print-backspace.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("IO/read/echoBigInt.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "IO/read/echoBigInt.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("IO/IOLoop.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "IO/IOLoop.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("pairs/checkRefPair.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "pairs/checkRefPair.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("runtimeErr/arrayOutOfBounds/arrayOutOfBounds.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "runtimeErr/arrayOutOfBounds/arrayOutOfBounds.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("runtimeErr/divideByZero/divZero.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "runtimeErr/divideByZero/divZero.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("runtimeErr/integerOverflow/intJustOverflow.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "runtimeErr/integerOverflow/intJustOverflow.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("runtimeErr/nullDereference/freeNull.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "runtimeErr/nullDereference/freeNull.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("scope/ifNested1.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "scope/ifNested1.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("sequence/charAssignment.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "sequence/charAssignment.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("variables/capCharDeclaration.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "variables/capCharDeclaration.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ("while/min.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "while/min.wacc")
    val formattedTest = formatTestFile(testFile)
    val formattedParsedProgram = formatParserProgram(testFile)
    assert(formattedTest == formattedParsedProgram)
  }

  ////////////// Helper functions

  def discardWhitespace(text : String) : String = {
    text.replace("\n", "").replace("\b", "").replace("\\t", "")
        .replace("\\n", "").replace("\\b", "").replace("\t", "")
        .replace(" ", "").replace("\\", "")
  }

  // Gets all text from a file without lines
  def getTextFromFile(file : File) : String = {
    val lines = Source.fromFile(file).getLines()
    var formattedLines = ""
    for (line <- lines) {
      val lineWithoutWhitespace = discardWhitespace(line)
      val len = lineWithoutWhitespace.length
      if (len > 0) {
        if (lineWithoutWhitespace.charAt(0) != '#') {
          if (!lineWithoutWhitespace.contains('#')) {
            formattedLines = formattedLines + line
          } else {
            for (i <- 0 to line.length - 1) {
              val char = line.charAt(i)
              if (char == '#') {
                formattedLines = formattedLines + line.slice(0, i)
              }
            }
          }
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