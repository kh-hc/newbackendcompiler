package wacc

object CodeGenerator{
    import java.io.{BufferedWriter, FileWriter, File}
    import assemblyCode._
    
    def buildAssembly(program: AssProg, waccName: String) = {
        val outputFile = new File(newFileName(waccName))
        val writer = new BufferedWriter(new FileWriter(outputFile))
        writer.append(assemblyToString(program))
        writer.close()
    }

    private def newFileName(fileName: String): String = fileName.dropRight(5).split("/").last + ".s"

    def assemblyToString(program: AssProg): StringBuilder = new StringBuilder().append(""".data
.text
.global main
main:
    push {fp, lr}
    push {r8, r10, r12}
    mov fp, sp
    mov r0, #0
    pop {r8, r10, r12}
    pop {fp, pc}""")
}