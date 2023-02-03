
import org.scalatest.flatspec.AnyFlatSpec
import scala.sys.process._
import java.io.File

class WaccTestSuite extends AnyFlatSpec {

  // Get the root path, being the valid directory
  val rootPath = "src/test/scala/wacc/test_cases/"

  println("Initializing valid program test cases")
  testDirectory(rootPath + "valid/", 0)

  println("Initializing invalid program test cases (syntax)")
  testDirectory(rootPath + "invalid/syntaxErr/", 100)

  println("Initializing invalid program test cases (semantics)")
  testDirectory(rootPath + "invalid/semanticErr/", 200)  

  def testDirectory(directoryPath: String, exitCode: Int) : Unit = {
    // Extract all the files from the subdirectories (and their subdirectories)
    val testFiles = getAllFiles(directoryPath)
    val filesTested = 0
    val filesPassed = 0
    // Loop through the test files and check our parser works
    for (file <- testFiles) {
        val filePath = directoryPath + file
        (s"Program '$filePath' ") should s"return an exit code of $exitCode" in {
            val testCorrect = run(filePath) == exitCode
            assert(testCorrect)
        }
        if (testCorrect) {
          filesPassed += 1
        }
        filesTested += 1
    }

    println(s"\n\n$filesPassed/$filesPassed tests passed\n\n")
  }
  
  // Returns the contents of a directory as a List[String]
  def getDirectoryContents (path : String) : List[String] = {
    val filePath = new File(path)
    filePath.listFiles
            .map(_.getName)
            .toList
  }

  
  // Because the Java isFile() function doesn't seem to work for .wacc files...
  // We know there are only .wacc files in the directory, so this function works
  def isAFile (fileName : String) : Boolean = {
    if (fileName.length < 5) {
      return false
    } else {
      return fileName.substring(fileName.length() - 5) == ".wacc"
    }    
  }

  
  def getAllFiles (path : String) : Array[String] = {
    // Initialise an array, to which we add all .wacc files found
    var files = Array[String]()// Array[String] = new Array()

    // Get all subdirectories: array, basic, expressions, etc.
    val subdirectories = getDirectoryContents(path)
    for (subdirectory <- subdirectories) {
      // Get all the files and subdirectories for each subdirectory
      val subs = getDirectoryContents(path + subdirectory)
      for (file <- subs) {
        // If it's a file, add to the array of files
        if (isAFile(file)) {
          files = files :+ s"$subdirectory/$file"
        } else {
          // Deals with one layer of nesting
          val finalFiles = getDirectoryContents(s"$path$subdirectory/$file")
          for (f <- finalFiles) {
            files = files :+ s"$subdirectory/$file/$f"
          }
        }
      }
    }
    return files
  }

  def run (filePath: String) : Int = {
    s"./compile $filePath > $filePath.log".!
  }
}