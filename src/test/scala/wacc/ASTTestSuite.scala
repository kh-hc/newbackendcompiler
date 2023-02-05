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

  // advanced subdirectory
  ("./advanced/binarySortTree.wacc") should "be correctly parsed by our parser" in {
    val testFile = new File(validRootPath + "advanced/binarySortTree.wacc")

    // Format the test file for comparison
    val formattedTest = formatTestFile(testFile)

    // Parse the test file and format it for comparison
    val formattedParsedProgram = formatParserProgram(testFile)

    // println("formattedParsedProgram: " + formattedParsedProgram)
    // println("\nformattedTest         : " + formattedTest)
    // println("\n\n" + PrettyPrinters.prettyPrintStatement(statement) + "\n" + statement)

    // Check that the parser works by comparing it to the test file
    assert(formattedTest == formattedParsedProgram)
  }

  def discardWhitespace(text : String) : String = {
    text.replace(" ", "")
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
      //println("\"" + endChar + "\"")
    }
    parsedProgramLines = parsedProgramLines + "end"
    discardWhitespace(parsedProgramLines).replace("\n", "")
  }
}