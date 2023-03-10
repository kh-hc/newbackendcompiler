package wacc

import org.scalatest.flatspec.AnyFlatSpec
import java.io.File
import parsley.{Success, Failure}
import wacc.parser._
import wacc.PeepholeOptimisation._
import wacc.CodeGenerator._
// import scala.io.Source

class PeepholeOptimisationTests extends AnyFlatSpec {

    val validRootPath = "src/test/scala/wacc/test_cases/valid/"

    test("basic/exit", "exit-1")
    test("if", "if1")
    test("while", "min")
    test("variables", "charDeclaration")
    test("expressions", "andExpr")
    test("sequence", "intLeadingZeros")
    test("array", "arrayIndexMayBeArrayIndex")
    test("function/nested_functions", "fibonacciFullRec")
    test("advanced", "binarySortTree")
    test("advanced", "hashTable")
    test("advanced", "ticTacToe")

    def test(folder : String, fileName : String) {
        (s"valid/$folder/$fileName") should "have correct optimised code produced by the peephole optimiser" in {
            val test = validRootPath + folder + "/" + fileName + ".wacc"
            compileAndOptimise(test)
        }
    }

    def compileAndOptimise (fileName : String) = {
        val file = new File (fileName)
        parse(file) match {
            case Success(x) => {
                // If the file is succesfully parsed with no errors, then we create a semantic analyzer
                val sa = new SemanticAnalyzer(fileName)
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

                    // Peephole Optimisation
                    val (assemblyOptimised, funcsOptimised) = peepholeOptimise(assembly, funcs)

                    // Create the assembly for the version...
                    // with peephole optimisations
                    val optimisedFileName = fileName.slice(0, fileName.length - 5) + "Optimised"
                    buildAssembly(assemblyOptimised, optimisedFileName, inbuilts.toSet, funcsOptimised, stringLabelMap.toMap)
                    // without peephole optimisations
                    buildAssembly(assembly, fileName, inbuilts.toSet, funcs, stringLabelMap.toMap)

                }
            }
            case Failure(x) => {
                println(x)
                sys.exit(100)
            }
        }
    }
    
}
