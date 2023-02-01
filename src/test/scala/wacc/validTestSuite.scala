// import org.scalatest.flatspec.AnyFlatSpec
// import scala.sys.process._
// import java.io.File

// class ValidProgram extends AnyFlatSpec {

//   // Get the root path, being the valid directory
//   val rootPath = "src/test/scala/wacc/test_cases/valid/"

//   // Extract all the files from the subdirectories (and their subdirectories)
//   val testFiles = getAllFiles(rootPath)

//   for (file <- testFiles) {
//     test(file)
//   }
  
  
//   // Returns the contents of a directory as a List[String]
//   def getDirectoryContents (path : String) : List[String] = {
//     val filePath = new File(path)
//     filePath.listFiles
//             .map(_.getName)
//             .toList
//   }

//   // Because the Java isFile() function doesn't seem to work for .wacc files...
//   // We know there are only .wacc files in the directory, so this function works
//   def isAFile (fileName : String) : Boolean = {
//     if (fileName.length < 5) {
//       return false
//     } else {
//       return fileName.substring(fileName.length() - 5) == ".wacc"
//     }    
//   }

//   def getAllFiles (path : String) : Array[String] = {
//     // Initialise an array, to which we add all .wacc files found
//     var files = Array[String]()// Array[String] = new Array()

//     // Get all subdirectories: array, basic, expressions, etc.
//     val subdirectories = getDirectoryContents(path)
//     for (subdirectory <- subdirectories) {
//       // Get all the files and subdirectories for each subdirectory
//       val subs = getDirectoryContents(path + subdirectory)
//       for (file <- subs) {
//         // If it's a file, add to the array of files
//         if (isAFile(file)) {
//           files = files :+ file
//         } else {
//           // If it's not a file then it's a directory - get all the files in the
//           // directory and append to the array of files
//           // Note that by observation, there are no further directories from
//           // this point
//           val finalFiles = getDirectoryContents(path + subdirectory + "/" + file)
//           for (f <- finalFiles) {
//             files = files :+ f
//           }
//         }
//       }
//     }
//     return files
//   }


//   // Tests our parser works on a certain input file
//   // Return true if the test passed, false otherwise
//   def test (filePath : String) : Unit = {
//     ("Valid program " + filePath) should "return an exit code of 0" in {
//     val exitCode = Seq("./compile", filePath).!
//     // println("EXIT CODE: ", exitCode)
//     assert(exitCode == 0)
//     }
//   }

// }