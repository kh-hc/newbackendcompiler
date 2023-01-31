
import org.scalatest.flatspec.AnyFlatSpec
import scala.sys.process._
import java.io.File

class WaccTestSuite extends AnyFlatSpec {

  // Get the root path, being the valid directory
  val rootPath = "src/test/scala/wacc/test_cases/"

  println("Initializing valid program test cases")
  testDirectory(s"$rootPath/valid")

  println("Initializing invalid program test cases (syntax)")
  testDirectory(s"$rootPath/invalid/syntaxErr")

  println("Initializing invalid program test cases (semantics)")
  testDirectory(s"$rootPath/invalid/semanticErr")  

  def testDirectory(directoryPath: String, exitCode: Int) : Unit = {
    val subdirectories = getDirectoryContents(directoryPath)
    for (subdirectory <- subdirectories) {
      val path = rootPath + subdirectory
      val testFiles = getDirectoryContents(path)
      // Loop through the test files and check our parser works
      for (file <- testFiles) {
          filePath = path + file
          (s"Program '$filePath' ") should s"return an exit code of $exitCode" in {
              assert(run(filePath) == exitCode)
          }
      }
    }
  }
  
  // Returns the contents of a directory as a List[String]
  def getDirectoryContents (path : String) : List[String] = {
    val filePath = new File(path)
    filePath.listFiles
            .map(_.getName)
            .toList
  }

  def run (filePath: String) : Int = {
    s"./compile $filePath > $filePath.log".!
  }
}