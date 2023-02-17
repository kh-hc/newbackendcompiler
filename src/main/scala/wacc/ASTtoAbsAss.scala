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
        case AssignStat(t, id, value) => {
            val (rightIntermediate, instrR) = translateRvalue(value, stat.symbolTable.get)
            return instrR ++ List(UnaryOperation(Assign, rightIntermediate, Stored(stat.symbolTable.get.lookupRecursiveId(id.id))))
        }
        case ReassignStat(left, right) => {
            val (leftIntermediate, instrL) = translateLvalue(left, stat.symbolTable.get)
            val (rightIntermediate, instrR) = translateRvalue(right, stat.symbolTable.get)
            return instrL ++ instrR ++ List(UnaryOperation(Assign, rightIntermediate, leftIntermediate))
        }
        case ReadStat(value) => {
            val (dest, instr) = translateLvalue(value, stat.symbolTable.get)
            return instr ++ List(InbuiltFunction(Read, dest))
        }
        case FreeStat(expr) => {
            val intermediate = getNewIntermediate
            return translateExp(expr, intermediate, stat.symbolTable.get) ++ List(InbuiltFunction(Free, intermediate))
        }
        case ReturnStat(expr) => {
            val intermediate = getNewIntermediate
            return translateExp(expr, intermediate, stat.symbolTable.get) ++ List(InbuiltFunction(Return, intermediate))
        }
        case ExitStat(expr) => {
            val intermediate = getNewIntermediate
            return translateExp(expr, intermediate, stat.symbolTable.get) ++ List(InbuiltFunction(Exit, intermediate))
        }
        case PrintStat(expr) => {
            val intermediate = getNewIntermediate
            return translateExp(expr, intermediate, stat.symbolTable.get) ++ List(InbuiltFunction(Print, intermediate))
        }
        case PrintlnStat(expr) => {
            val intermediate = getNewIntermediate
            return translateExp(expr, intermediate, stat.symbolTable.get) ++ List(InbuiltFunction(Println, intermediate))
        }
        case IfStat(cond, ifStat, elseStat) => {
            val intermediate = getNewIntermediate
            val conditions = translateExp(cond, intermediate, stat.symbolTable.get)
            return List(IfInstruction(Conditional(intermediate, conditions), translateStat(ifStat), translateStat(elseStat)))
        }
        case WhileStat(cond, body) =>  {
            val intermediate = getNewIntermediate
            val conditions = translateExp(cond, intermediate, stat.symbolTable.get)
            return List(WhileInstruction(Conditional(intermediate, conditions), translateStat(body)))
        }
        case ScopeStat(body) => translateStat(body)
        case SeqStat(statements) => statements.map(translateStat).flatten
    }

    def translateRvalue(value: Rvalue, st: SymbolTable): (Value, List[Instruction]) = value match {
        case ArrayLiteral(value) => {
            val array = getNewIntermediate
            // Create array, go through indices and add the translated values
            return (array, List.empty)
        }
        case NewPair(exprLeft, exprRight) => {
            val pair = getNewIntermediate
            // Create pair, add values to fst and snd
            return (pair, List.empty)
        }
        case Call(id, args) => {
            val returnVal = getNewIntermediate
            // Translate all args, use call
            return (returnVal, List.empty)
        }
        case lvalue: Lvalue => translateLvalue(lvalue, st)
        case expr: Expr => {
            val intermediate = getNewIntermediate
            return (intermediate, translateExp(expr, intermediate, st))
        }
    }

    def translateLvalue(value: Lvalue, st: SymbolTable): (Value, List[Instruction]) = value match {
        case PairElemFst(pairToDeref) => {
            val (pair, instr) = translateLvalue(pairToDeref, st)
            return (PairAccess(Snd, pair), instr)
        }
        case PairElemSnd(pairToDeref) => {
            val (pair, instr) = translateLvalue(pairToDeref, st)
            return (PairAccess(Snd, pair), instr)
        }
        case Identifier(id) => (Stored(st.lookupRecursiveId(id)), List.empty)
        case ArrayElem(id, position) => {
            var positions: List[Value] = List.empty
            var instructions: List[Instruction] = List.empty
            for (pos <- position) {
                val inter = getNewIntermediate
                positions = positions :+ inter
                instructions = instructions ::: translateExp(pos, inter, st) 
            }
            return (ArrayAccess(positions, Stored(st.lookupRecursiveId(id.id))), instructions)
        }
    }

    def translateExp(ast: Expr, dest: Stored, st: SymbolTable): List[Instruction] = {
        return List.empty
    }
}