package wacc

import org.scalatest.flatspec.AnyFlatSpec
import java.io.File
import scala.io.Source
import scala.sys.process._

/*
System test suite, which tests the whole compiler by checking its output is correct
We test on valid programs which print statements
*/

class SystemTestSuite extends AnyFlatSpec {

    // Used for some tests - the root path
    val validRootPath = "src/test/scala/wacc/test_cases/valid/"

    // Get all files in the valid root path which contain a print or println statement
    val testFiles = getAllFiles(validRootPath)
    testFiles.keys.foreach { test =>
        runTest(test, testFiles(test))
    }

    def runTest(fileName : String, expectedOutput : String) {
        val filePath = validRootPath + fileName
        // Get the output assembly code from our compiler - stores in emulatorFiles/assemblyCode
        s"./compile $filePath > $filePath.log".! // val exitCode = 

        // The compiler saves the assembly code with the same file name, but .s instead of .wacc
        val assemblyFileName: String = fileName.dropRight(5).split("/").last
        val assemblyCode = s"$assemblyFileName.s"
        val assemblyOutput = s"$assemblyFileName.o"

        // Put it through the gcc cross-compiler - doesn't have an extenstion so store in fileName,
        // which is the same as the file path
        val compilerScriptCommand = "arm-linux-gnueabi-gcc -o " + assemblyOutput +
                                    " -mcpu=arm1176jzf-s -mtune=arm1176jzf-s " + assemblyCode
        
        compilerScriptCommand.!

        // Run the emulator
        val emulatorScriptCommand = "qemu-arm -L /usr/arm-linux-gnueabi/ " + fileName
        val actualOutput = emulatorScriptCommand.!

        (filePath) should "be run with our compiler and have the correct output produced" in {
            assert(actualOutput == expectedOutput)
        }
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

    def getAllFiles (path : String) : Map[String, String] = {
        // Initialise an array, to which we add all .wacc files found
        // var files = Array[String]()
        // Maps files to their expected outputs
        var files = Map[String, String]()

        // Get all subdirectories: array, basic, expressions, etc.
        val subdirectories = getDirectoryContents(path)
        for (subdirectory <- subdirectories) {
            // Get all the files and subdirectories for each subdirectory
            val subs = getDirectoryContents(path + subdirectory)
            for (file <- subs) {
                val filePath = path + subdirectory + "/" + file
                // If it's a file which contains a print statement, add to the array of files
                if (isAFile(file)) {
                    if (containsPrintStatement(filePath)) {
                        files = files + (s"$subdirectory/$file" -> expectedOutput(filePath))
                    }
                } else {
                    // Deals with one layer of nesting
                    val finalFiles = getDirectoryContents(s"$path$subdirectory/$file")
                    for (f <- finalFiles) {
                        val fullFilePath = filePath + "/" + f
                        if (containsPrintStatement(fullFilePath)) {
                            files = files + (s"$subdirectory/$file/$f" -> expectedOutput(fullFilePath))
                        }
                    }
                }
            }
        }
        return files
    }

    // Checks if the file contains a print or println statement
    def containsPrintStatement(file : String) : Boolean = {
        // Get the lines from the file
        var returnVal = false
        val lines = Source.fromFile(new File(file)).getLines()
        for (line <- lines) {
            returnVal ||= (line contains "print")
        }
        return returnVal
    }

    def expectedOutput(file : String) : String = {
        val lines = Source.fromFile(new File(file)).getLines()
        while (lines.hasNext) {
            val line = lines.next()
            if (line contains "Output") {
                val outputLine = lines.next()
                return outputLine.slice(2, outputLine.length())
            }
        }
        return ""
    }
}
