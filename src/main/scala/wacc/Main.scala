package wacc

import parser.parse
import CodeGenerator.buildAssembly
import PeepholeOptimisation.peepholeOptimise
import parsley.{Success, Failure}
import java.io.File

object Main {
    def main(args: Array[String]): Unit = {
        val myFile = new File(args.head)
        // Try-catch to catch if the parser cannot open the file, or has similar problems
        try{
            // Parse the file and match whether or not there are syntax errors
            parse(myFile) match {
                case Success(x) => {
                    // If the file is succesfully parsed with no errors, then we create a semantic analyzer
                    val sa = new SemanticAnalyzer(args.head)
                    sa.analyzeProgram(x)
                    // Checks the built-in error catcher for the analyzer to see if there are semantic errors
                    if (sa.isErrors()){
                        sa.getErrors().map(e =>  println(e))
                        sys.exit(200)
                    } else {
                        val intermediateTranslator = new AbstractTranslator()
                        val finalTranslator = new AssemblyTranslator()
                        val intermediateTranslation = intermediateTranslator.translate(x)
                        val (assembly, inbuilts, funcs, stringLabelMap) = finalTranslator.translate(intermediateTranslation)
                        if (args.length > 1 && args(1) == "-o") {
                            val (assemblyOptimised, funcsOptimised) = peepholeOptimise(assembly, funcs)
                            buildAssembly(assemblyOptimised, args.head, inbuilts.toSet, funcsOptimised, stringLabelMap.toMap)
                        }
                        else {
                            buildAssembly(assembly, args.head, inbuilts.toSet, funcs, stringLabelMap.toMap)
                        }
                        sys.exit(0)
                    }
                }
                case Failure(x) => {
                    println(x)
                    sys.exit(100)
                }
            }
        } catch {
            case e: Exception => {
                println(e)
                println(e.getCause())
                println(e.getStackTrace().map(println))
            }
        }
    }
}
