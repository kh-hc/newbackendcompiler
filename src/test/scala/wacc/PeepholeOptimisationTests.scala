package wacc

import org.scalatest.flatspec.AnyFlatSpec
import java.io.File
import parsley.{Success, Failure}
import wacc.parser._
import wacc.PeepholeOptimisation._
import wacc.CodeGenerator._

class PeepholeOptimisationTests extends AnyFlatSpec {

    val validRootPath = "src/test/scala/wacc/test_cases/valid/"

    ("valid/advanced/binarySortTree") should "have correct optimised code produced by the peephole optimiser" in {
        val test = validRootPath + "advanced/binarySortTree.wacc"
        compileAndOptimise(test)
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
                    buildAssembly(assemblyOptimised, fileName + "Optimised", inbuilts.toSet, funcsOptimised, stringLabelMap.toMap)
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

    def printPrettily (list : List[String]) {
        for (item <- list) {
            println(item)
        }
    }

}
