import org.scalatest.flatspec.AnyFlatSpec
import scala.sys.process._
import java.io.File

class ValidProgram extends AnyFlatSpec {

  // Get the root path, being the valid directory
  val rootPath = "src/test/scala/wacc/test_cases/valid/"
  // Get all the subdirectories in the valid folder
  val subdirectories = getDirectoryContents(rootPath)
  // Loop through the subdirectories and test each example within
  for (subdirectory <- subdirectories) {
    val path = rootPath + subdirectory
    val testFiles = getDirectoryContents(path)
    // Loop through the test files and check our parser works
    for (file <- testFiles) {
        test(path + file)
    }
  }
  
  // Returns the contents of a directory as a List[String]
  def getDirectoryContents (path : String) : List[String] = {
    val filePath = new File(path)
    filePath.listFiles
            .map(_.getName)
            .toList
  }

  // Tests our parser works on a certain input file
  // Return true if the test passed, false otherwise
  def test (filePath : String) : Unit = {
    ("Valid program " + filePath) should "return an exit code of 0" in {
    val exitCode = Seq("./compile", filePath).!
    // println("EXIT CODE: ", exitCode)
    assert(exitCode == 0)
    }
  }

}