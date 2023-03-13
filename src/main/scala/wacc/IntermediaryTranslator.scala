package wacc

import wacc.Archive.AssemblyInstructions

class IntermediaryTranslator {
    import scala.collection.mutable.ListBuffer
    import abstractSyntaxTree._
    import intermediaryCompileStructure._
    import SymbolTypes._

    var intermediateCounter: Int = 0

    val defaultIntSize = 4

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
    
    def translateFunctionName(id: Identifier): String = s"${id.id}"
    
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
        case Mul(l, r) => {
            translateBinaryExp(l, r, lb, IntType, A_Mul)
        }
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
            for (pos <- posList){
                val layerType = derefType(arrayType, derefCount)
                derefCount = derefCount + 1
                val dereference = getNewIntermediate(PointerType)
                val position = translateExpression(pos, lb)
                val posInter = getNewIntermediate(IntType)
                lb += UnaryOperation(A_Mov, position, posInter)
                lb += BinaryOperation(A_Mul, posInter, Immediate(typeToSize(layerType)), posInter)
                lb += UnaryOperation(A_Load, Access(access, posInter, translateType(layerType)), dereference)
                access = dereference
            }
            access
        }
        case CharExpr(c) => Character(c.toInt)
        case IntExpr(i) => Immediate(i)
        case BoolExpr(b) => b match {
            case true => a_true
            case false => a_false
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
        val ex = translateExpression(e, lb)
        val dest = getNewIntermediate(tiepe)
        lb += UnaryOperation(op, ex, dest)
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
            case Or(l, r) => {
                val lb = new ListBuffer[Instr]
                val e = translateExpression(expr, lb)
                lb += UnaryOperation(A_Cmp, e, a_true) 
                Conditional(A_EQ, lb.toList)
            }
            case And(l, r) => {
                val lb = new ListBuffer[Instr]
                val e = translateExpression(expr, lb)
                lb += UnaryOperation(A_Cmp, e, a_true) 
                Conditional(A_EQ, lb.toList)
            }
            case NotOp(e) => {
                val lb = new ListBuffer[Instr]
                val value = translateExpression(e, lb)
                lb += UnaryOperation(A_Cmp, value, a_false)
                Conditional(A_EQ, lb.toList)
            }
            case Identifier(id) => {
                val (name, t) = expr.symbolTable.get.lookupRecursiveID(id)
                val transt = translateType(t)
                transt match {
                    case BoolType => {
                        Conditional(A_EQ, List(UnaryOperation(A_Cmp, Stored(name, transt), a_true)))
                    }
                    case _ => throw new Exception("Invalid id condition passed through")
                }
            }
            case BoolExpr(b: Boolean) => {
                val lb = new ListBuffer[Instr]
                lb += UnaryOperation(A_Cmp, b match {
                    case true => a_true
                    case false => a_false
                }, a_true)
                Conditional(A_EQ, lb.toList)
            }
            case ParenExpr(e: Expr) => translateCondition(e)
            case x => throw new Exception(s"Invalid condition passed through: $x")
        }
    }

    def translateCondExp(left: Expr, right: Expr, code: A_Condition) = {
        val lb = new ListBuffer[Instr]
        val cl = translateExpression(left, lb)
        val cr = translateExpression(right, lb)
        lb += UnaryOperation(A_Cmp, cl, cr) 
        Conditional(code, lb.toList)
    }
    
    def translateStatement(st: StatementUnit, l: ListBuffer[Instr]): Unit = {
        st match {
            case SkipStat => 
            case AssignStat(t, id, value) => {
                st.symbolTable.get.add(id.id, t)
                st.symbolTable.get.setAssignedId(id.id)
                val intermediate = st.symbolTable.get.lookupRecursiveID(id.id)
                translateRValueInto(value, Stored(intermediate._1, translateType(intermediate._2)), l)
                st.symbolTable.get.setAssignedId(id.id)
            }
            case ReassignStat(left, right) => {
                val leftInter = translateLValue(left, l)
                leftInter match {
                    case b: BaseValue => translateRValueInto(right, leftInter, l)
                    case a: Access => {
                        val intermediate = getNewIntermediate(PointerType)
                        translateRValueInto(right, intermediate, l)
                        l += UnaryOperation(A_Load, intermediate, leftInter)
                    }
                }
            }
            case ScopeStat(body) => translateStatement(body, l)
            case ExitStat(value) => {
                val bv = translateExpression(value, l)
                l += InbuiltFunction(A_Exit, bv)
            }
            case FreeStat(value) => {
                val bv = translateExpression(value, l)
                l += InbuiltFunction(A_Free, bv)
            }
            case IfStat(cond, ifBody, elseBody) => {
                val condition = translateCondition(cond)
                val ifBuffer = new ListBuffer[Instr]()
                val elseBuffer = new ListBuffer[Instr]()
                translateStatement(ifBody, ifBuffer)
                translateStatement(elseBody, elseBuffer)
                l += IfInstruction(condition, ifBuffer.toList, elseBuffer.toList)
            }
            case WhileStat(cond, body) => {
                val condition = translateCondition(cond)
                val bodyBuffer = new ListBuffer[Instr]()
                translateStatement(body, bodyBuffer)
                l += WhileInstruction(condition, bodyBuffer.toList)
            }
            case PrintStat(expr) => {
                val bv = translateExpression(expr, l)
                l += InbuiltFunction(A_Print, bv)
            }
            case PrintlnStat(expr) => {
                val bv = translateExpression(expr, l)
                l += InbuiltFunction(A_Println, bv)
            }
            case ReadStat(value) => {
                val bv = translateLValue(value, l)
                l += InbuiltFunction(A_Read, bv)
            }
            case ReturnStat(expr) => {
                val bv = translateExpression(expr, l)
                l += InbuiltFunction(A_Return, bv)
            }
            case SeqStat(stats) => stats.map(stat => translateStatement(stat, l))
        }
    }

    def translateLValue(lvalue: Lvalue, lb: ListBuffer[Instr]): Value = lvalue match {
        case p: PairElem => getPairToValue(p, lb)
        case e: Expr => translateExpression(e, lb)
    }

    def getPairToValue(p: PairElem, lb: ListBuffer[Instr]): Value = {
        val basePair = p match {
            case PairElemFst(pair: Lvalue) => pair 
            case PairElemSnd(pair: Lvalue) => pair
        }
        translateLValue(basePair, lb) match {
            case b: BaseValue => Access(b, pairAccessLocation(p), PointerType)
            case a: Access => {
                val intermediate = getNewIntermediate(PointerType)
                lb += UnaryOperation(A_Load, a, intermediate)
                Access(intermediate, pairAccessLocation(p), PointerType)
            }
        }
    }

    def pairAccessLocation(p: PairElem): Immediate = p match {
        case PairElemFst(_) => Immediate(0) 
        case PairElemSnd(_) => Immediate(defaultIntSize)
    }

    def getElementSize(t: Option[SymbolType]): Int = t match {
        case None => defaultIntSize
        case Some(value) => value match {
            case CharSymbol => 1
            case BoolSymbol => 1
            case _ => defaultIntSize
        }
    }

    def translateRValueInto(rvalue: Rvalue, location: Value, list: ListBuffer[Instr]) = rvalue match {
        case ArrayLiteral(value) => {
            val arrayPointer = getNewIntermediate(PointerType)
            var arrayLocSize = defaultIntSize
            if (value.length > 0) {
                arrayLocSize = getElementSize(value.head.tiepe)
            }
            list += UnaryOperation(A_Malloc, Immediate(defaultIntSize + arrayLocSize * value.length), arrayPointer)
            list += BinaryOperation(A_Add, arrayPointer, Immediate(defaultIntSize), arrayPointer)
            list += UnaryOperation(A_Load, Immediate(value.length), Access(arrayPointer, Immediate(-1 * arrayLocSize), IntType))

            for (i <- 0 to (value.length - 1)) {
                val indexValue = Access(arrayPointer, Immediate(i * arrayLocSize), translateType(value.head.tiepe.get))
                val e = translateExpression(value(i), list)
                list += UnaryOperation(A_Load, e, indexValue)
            }
        }
        case Call(id, args) => {
            val argList: ListBuffer[Value] = new ListBuffer[Value]()
            for (e <- args.args) {
                val argValue = translateExpression(e, list)
                val inter = getNewIntermediate(translateType(e.tiepe.get))
                list += UnaryOperation(A_Mov, argValue, inter)
                argList += inter
            }
            val funcCall = FunctionCall(id.id, argList.toList, location)
            list += funcCall
        }
        case p: PairElem => getPairToValue(p, list)
        case NewPair(el, er) => {
            val fst = translateExpression(el, list)
            val fstInd = Access(Immediate(0), location, PointerType)
            val snd = translateExpression(er, list)
            val sndInd = Access(Immediate(defaultIntSize), location, PointerType)
            list += UnaryOperation(A_Malloc, Immediate(defaultIntSize *  2), location)
            list += UnaryOperation(A_Load, fst, fstInd)
            list += UnaryOperation(A_Load, snd, sndInd)
        }
        case e: Expr => {
            val x = translateExpression(e, list)
            list += UnaryOperation(A_Load, x, location)
        }
    }
}
