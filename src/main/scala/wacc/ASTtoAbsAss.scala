package wacc

class AbstractTranslator {
    import assemblyAbstractStructure._
    import abstractSyntaxTree._
    
    var intermediateCounter: Int = 0

    def getNewIntermediate: Stored = {
        intermediateCounter = intermediateCounter + 1
        return Stored(intermediateCounter.toString)    
    }
    
    def translate(ast: WACCprogram): Program = {
        val functions = ast.funcs.map(f => translateFunction(f))
        val body = translateMain(ast.stat)
        return Program(body, functions)
    }

    def translateFunction(func: FunctionUnit): Function
        = Function(translateStat(func.body), func.params.paramlist.map(p => Stored(func.symbolTable.get.lookupRecursiveId(p.id.id))))

    def translateMain(stat: StatementUnit): Function = {
        return Function(translateStat(stat), List.empty)
    }

    def translateStat(stat: StatementUnit): List[Instruction] = stat match {
        case SkipStat => List.empty
        case AssignStat(t, id, value) => 
        case ReassignStat(left, right) => {
            val (leftIntermediate, instrL) = translateLvalue(left)
            val (rightIntermediate, instrR) = translateRvalue(right)
        }
        case ReadStat(value) => {
            val (dest, instr) = translateLvalue(value)
            return instr ++ List(InbuiltFunction(Read, dest))
        }
        case FreeStat(expr) => {
            val intermediate = getNewIntermediate
            return translateExp(expr, intermediate) ++ List(InbuiltFunction(Free, intermediate))
        }
        case ReturnStat(expr) => {
            val intermediate = getNewIntermediate
            return translateExp(expr, intermediate) ++ List(InbuiltFunction(Return, intermediate))
        }
        case ExitStat(expr) => {
            val intermediate = getNewIntermediate
            return translateExp(expr, intermediate) ++ List(InbuiltFunction(Exit, intermediate))
        }
        case PrintStat(expr) => {
            val intermediate = getNewIntermediate
            return translateExp(expr, intermediate) ++ List(InbuiltFunction(Print, intermediate))
        }
        case PrintlnStat(expr) => {
            val intermediate = getNewIntermediate
            return translateExp(expr, intermediate) ++ List(InbuiltFunction(Println, intermediate))
        }
        case IfStat(cond, ifStat, elseStat) => 
        case WhileStat(cond, body) => 
        case ScopeStat(body) => translateStat(body)
        case SeqStat(statements) => statements.map(translateStat).flatten
    }

    def translateLvalue(value: Lvalue): (Value, List[Instruction]) = value match {
        case PairElemFst(pair) => 
        case PairElemSnd(pair) => 
        case Identifier(id) => 
        case ArrayElem(id, position) => 
    }

    def translateExp(ast: Expr, dest: Stored): List[Instruction] = {
        return List.empty
    }
}