package wacc

class IntermediaryTranslator {
    import scala.collection.mutable.ListBuffer
    import abstractSyntaxTree._
    import IntermediaryCompileStructure._
    import SymbolTypes._

    var intermediateCounter: Int = 0

    def getNewIntermediate(tiepe: IntermediateType): IntermediateValue = {
        intermediateCounter = intermediateCounter + 1
        IntermediateValue(intermediateCounter, tiepe)
    }
    
    def translate(prog: WACCprogram) = {
        val listBuffer: ListBuffer[Instr] = new ListBuffer[Instr]()
        translateStatement(prog.stat, listBuffer)
        
        Program(listBuffer.toList, prog.funcs.map(translateFunction))
    }

    def translateFunction(func: FunctionUnit): WaccFunction = {
        val listBuffer: ListBuffer[Instr] = new ListBuffer[Instr]()
        translateStatement(func.body, listBuffer) 
        WaccFunction(translateFunctionName(func.id), listBuffer.toList, translateParamList(func.params, func.symbolTable.get))
    }
    
    def translateFunctionName(id: Identifier): String = s"wacc_f_${id.id}"
    
    def translateParamList(paramlist: ParamList, symbolTable: SymbolTable): List[Stored] = {
        paramlist.paramlist.map(p => symbolTable.lookupRecursiveID(p.id.id)).map({case (id, t) => Stored(id, translateType(t))})
    }

    def translateType(t: SymbolType): IntermediateType = t match {
        case IntSymbol => IntType
        case BoolSymbol => BoolType
        case CharSymbol => CharType
        case StringSymbol => StringType
        case a: SymbolType => PointerType
    }

    // Returns the size of each type in bytes
    def typeToSize(t: SymbolType): Int = t match {
        case CharSymbol => 1
        case _ => 4
    }

    def translateExpression(expr: Expr, lb: ListBuffer[Instr]): BaseValue = expr match {
        case Add(l, r) => translateBinaryExp(l, r, lb, IntType, A_Add)
        case Sub(l, r) => translateBinaryExp(l, r, lb, IntType, A_Sub)
        case Div(l, r) => translateBinaryExp(l, r, lb, IntType, A_Div)
        case Mod(l, r) => translateBinaryExp(l, r, lb, IntType, A_Mod)
        case Mul(l, r) => translateBinaryExp(l, r, lb, IntType, A_Mul)
        case Equal(l, r) => translateBinaryExp(l, r, lb, BoolType, A_EQ)
        case NotEqual(l, r) => translateBinaryExp(l, r, lb, BoolType, A_NEQ)
        case GreaterOrEqualThan(l, r) => translateBinaryExp(l, r, lb, BoolType, A_GTE)
        case GreaterThan(l, r) => translateBinaryExp(l, r, lb, BoolType, A_GT)
        case LessOrEqualThan(l, r) => translateBinaryExp(l, r, lb, BoolType, A_LTE)
        case LessThan(l, r) => translateBinaryExp(l, r, lb, BoolType, A_LT)
        case And(l, r) => translateBinaryExp(l, r, lb, BoolType, A_And)
        case Or(l, r) => translateBinaryExp(l, r, lb, BoolType, A_Or)
        case NotOp(e) => translateUnaryExp(e, lb, BoolType, A_Not)
        case NegateOp(e) => translateUnaryExp(e, lb, IntType, A_Neg)
        case ChrOp(e) => translateUnaryExp(e, lb, CharType, A_Chr)
        case OrdOp(e) => translateUnaryExp(e, lb, IntType, A_Ord)
        case LenOp(e) => translateUnaryExp(e, lb, IntType, A_Len)
        case ParenExpr(e) => translateExpression(e, lb)
        case ArrayElem(id, posList) => {
            val (arrayId, arrayType) = expr.symbolTable.get.lookupRecursiveID(id.id)
            var access: BaseValue = Stored(arrayId, PointerType)           
            var derefCount = 1
            // If we are accessing a nested array, update the access positions
            for (pos <- posList.dropRight(1)){
                val layerType = derefType(arrayType, derefCount)
                derefCount = derefCount + 1
                val dereference = getNewIntermediate(PointerType)
                val position = translateExpression(pos, lb)
                lb += BinaryOperation(A_Mul, position, Immediate(typeToSize(layerType)), position)
                lb += UnaryOperation(A_Mov, Access(access, position), dereference)
                access = dereference
            }
            access
        }
        case CharExpr(c) => Immediate(c.toInt)
        case IntExpr(i) => Immediate(i)
        case BoolExpr(b) => b match {
            case true => Immediate(1)
            case false => Immediate(0)
        }
        case StrExpr(s) => StringLiteral(s)
        case PairLiteral => getNewIntermediate(PointerType)
        case Identifier(id) => {
            val (name, t) = expr.symbolTable.get.lookupRecursiveID(id)
            Stored(name, translateType(t))
        }
    }

    def translateBinaryExp(left: Expr, right: Expr, lb: ListBuffer[Instr], tiepe: IntermediateType, operation: AssemblyBOperator): BaseValue = {
        val el = translateExpression(left, lb)
        val er = translateExpression(right, lb)
        val dest = getNewIntermediate(tiepe)
        lb += BinaryOperation(operation, el, er, dest)
        dest
    }

    def translateUnaryExp(e: Expr, lb: ListBuffer[Instr], tiepe: IntermediateType, op: AssemblyUOperator): BaseValue = {
        val edoardo = translateExpression(e, lb)
        val dest = getNewIntermediate(tiepe)
        lb += UnaryOperation(op, edoardo, dest)
        dest
    }

    def translateCondition(expr: Expr): Conditional = {
        expr match {
            case Equal(l, r) => translateCondExp(l, r, A_EQ)
            case NotEqual(l, r) => translateCondExp(l, r, A_NEQ)
            case GreaterOrEqualThan(l, r) => translateCondExp(l, r, A_GTE)
            case GreaterThan(l, r) => translateCondExp(l, r, A_GT)
            case LessOrEqualThan(l, r) => translateCondExp(l, r, A_LTE)
            case LessThan(l, r) => translateCondExp(l, r, A_LT)
            case Or(l, r) => translateCondExp(l, r, A_Or)
            case And(l, r) => translateCondExp(l, r, A_And)
            case NotOp(e) => {
                translateExpression(e, lb)
                Conditional(A_Not, lb.toList)
            }
            case _ => throw new Exception("Invalid condition passed through")
        }
    }

    def translateCondExp(left: Expr, right: Expr, code: Condition) = {
        val lb = new ListBuffer[Instr]
        val cl = translateExpression(left, lb)
        val cr = translateExpression(right, lb)
        lb += UnaryOperation(A_Cmp, cl, cr) 
        Conditional(code, lb.toList)
    }
    
    def translateStatement(st: StatementUnit, l: ListBuffer[Instr]): Unit = {
        st match {
            case SkipStat => 
            case AssignStat(t, id, value) => 
            case ReassignStat(left, right) => 
            case ScopeStat(body) => translateStatement(body, l)
            case ExitStat(value) => 
            case FreeStat(value) => 
            case IfStat(cond, ifBody, elseBody) => {
                val condition = translateCondition(cond)
                val ifBuffer = new ListBuffer[Instr]()
                val elseBuffer = new ListBuffer[Instr]()
                translateStatement(ifBody, ifBuffer)
                translateStatement(elseBody, elseBuffer)
                IfInstruction(condition, ifBuffer.toList, elseBuffer.toList)
            }
            case WhileStat(cond, body) => {
                val condition = translateCondition(cond)
                val bodyBuffer = new ListBuffer[Instr]()
                translateStatement(body, bodyBuffer)
                WhileInstruction(condition, bodyBuffer.toList)
            }
            case PrintStat(expr) => 
            case PrintlnStat(expr) => 
            case ReadStat(value) => 
            case ReturnStat(expr) => 
            case SeqStat(stats) => stats.map(stat => translateStatement(stat, l))
        }
    }

    def translateLValue(lvalue: Lvalue, lb: ListBuffer[Instr]) = lvalue match {
        case p: PairElem => 
        case e: Expr => translateExpression(e, lb)
    }

    def translateRValueInto(rvalue: Rvalue, location: Value, list: ListBuffer[Instr]) = rvalue match {
        case ArrayLiteral(pos) => 
        case Call(id, args) => 
        case p: PairElem => 
        case e: Expr => translateExpression(e, list)
    }
}
