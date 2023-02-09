package wacc
import wacc.abstractSyntaxTree._

object SemanticAnalyzer {
    import SymbolTypes._    

    def analyzeProgram(ast: WACCprogram)  = {
        val symbolTable = new SymbolTable(None)
        // Record function definitions in the symbol table as functions can be mutually recursive
        ast.funcs.map(symbolTable.add)
        // Analyze the body of the functions
        ast.funcs.map(f => checkFunction(f, symbolTable))
        // Checks the program body
        // Using NullSymbol disallows returns implicitly
        checkStatement(ast.stat, symbolTable, NoReturn)
    }

    def checkFunction(function: FunctionUnit, symbolTable: SymbolTable) = {
        // Create a symbol table for the new scope
        val argsSymbols = new SymbolTable(Some(symbolTable))
        // Add each parameter into the new symbol table 
        function.params.paramlist.map(p => argsSymbols.add(p.id.id, p.t))
        // Analyze each statement in the body of the function
        checkStatement(function.body, new SymbolTable(Some(argsSymbols)), translate(function.t))
    }

    def checkStatement(statement: StatementUnit, symbolTable: SymbolTable, returnType: SymbolType): Unit = statement match{
        case SkipStat => ()
        case AssignStat(t, id, value) => {
            if (symbolTable.lookup(id.id).isEmpty){
                val expectedType = translate(t)
                val providedType = checkRvalue(value, symbolTable)
                if (expectedType != providedType) {
                    providedType match {
                        case TopPairSymbol(a, b) => expectedType match {
                            case TopPairSymbol(x, y) => {
                                if (!((x == NestedPairSymbol || a == NestedPairSymbol || x == a)
                                && (y == NestedPairSymbol || b == NestedPairSymbol || b == y))){
                                    throw new Exception("Non matching pair types")
                                }
                            }
                            case NestedPairSymbol => 
                            case PairLiteralSymbol =>
                            case default => throw new Exception("Unexpected pair literal")
                        }
                        case PairLiteralSymbol => expectedType match {
                            case TopPairSymbol(ft, st) => 
                            case NestedPairSymbol => 
                            case default => throw new Exception("Unexpected pair literal")
                        }
                        case ArraySymbol(AmbiguousSymbol) =>  
                        case NestedPairSymbol => 
                        case AmbiguousSymbol => 
                        case default => throw new Exception("Definition with conflicting types")
                    }
                }
                symbolTable.add(id.id, expectedType)
                return ()
            } else {
                throw new Exception("Variable already assigned to in this scope")
            }
        }
        case ReassignStat(left, right) => {
            val leftType = checkLvalue(left, symbolTable)
            val rightType = checkRvalue(right, symbolTable)
            if (leftType != rightType){
                leftType match {
                    case TopPairSymbol(ft, st) => rightType match {
                        case NestedPairSymbol => 
                        case PairLiteralSymbol => 
                        case default => throw new Exception("Unexpected pair literal")
                    }
                    case ArraySymbol(AmbiguousSymbol) => rightType match {
                        case ArraySymbol(x) =>
                        case default => throw new Exception("Definition with conflicting types")
                    }
                    case AmbiguousSymbol =>
                    case PairLiteralSymbol =>  rightType match {
                        case TopPairSymbol(ft, st) => 
                        case NestedPairSymbol =>
                        case default => throw new Exception("Definition with conflicting types")
                    }
                    case NestedPairSymbol =>
                    case default => throw new Exception("Definition with conflicting types")
                }
            }
            if ((leftType == NestedPairSymbol) && (rightType == NestedPairSymbol)){
                throw new Exception("Cannot reassign with ambiguous types on both sides")
            }
            return ()
        }
        case ReadStat(value) => checkLvalue(value, symbolTable) match {
            case IntSymbol => ()
            case CharSymbol => ()
            case default => throw new Exception("Tried to read to a non-int")
        }
        case FreeStat(expr) =>  {
            checkExpression(expr, symbolTable) match {
                case ArraySymbol(_) => ()
                case NestedPairSymbol => ()
                case TopPairSymbol(_, _) => ()
                case default => throw new Exception("Tried to free a non-pair/array") 
            }
        }
        case ReturnStat(expr) =>  checkEvaluatesTo(expr, symbolTable, returnType)
        case ExitStat(expr) => checkEvaluatesTo(expr, symbolTable, IntSymbol)
        case PrintStat(expr) => checkExpression(expr, symbolTable)
        case PrintlnStat(expr) => checkExpression(expr, symbolTable)
        case IfStat(cond, ifStat, elseStat) =>  {
            checkEvaluatesTo(cond, symbolTable, BoolSymbol)
            checkStatement(ifStat, new SymbolTable(Some(symbolTable)), returnType)
            checkStatement(elseStat, new SymbolTable(Some(symbolTable)), returnType)
        }
        case WhileStat(cond, body) => {
            checkEvaluatesTo(cond, symbolTable, BoolSymbol)
            checkStatement(body, new SymbolTable(Some(symbolTable)), returnType)
        }
        case ScopeStat(stat) => checkStatement(stat, new SymbolTable(Some(symbolTable)), returnType)
        case SeqStat(stats) => stats.map(s => checkStatement(s, symbolTable, returnType))
    }

    def checkEvaluatesTo(expr: Expr, symbolTable: SymbolTable, t: SymbolType): Unit = t match{
        case NoReturn => throw new Exception("Attempt to return from program body")
        case NestedPairSymbol => return ()
        case TopPairSymbol(x, y) => {
            val exprType = checkExpression(expr, symbolTable)
            if (exprType != t){
                exprType match{
                    case NestedPairSymbol => return ()
                    case PairLiteralSymbol => return ()
                    case _ => throw new Exception("Non-matching pairs")
                }
            }
        }
        case symbolType => {
            val exprType = checkExpression(expr, symbolTable)
            if (exprType != symbolType){
                if (exprType == NestedPairSymbol) {
                    return ()
                }
                if (symbolType == ArraySymbol(AmbiguousSymbol)){
                    exprType match{
                        case ArraySymbol(subtype) => return ()
                        case _ => throw new Exception("Expression did not evalute to correct type")
                    }
                } else if (symbolType == PairLiteralSymbol) {
                    exprType match {
                        case TopPairSymbol(x, y) =>
                        case _ => throw new Exception("Non-matching pairs exception")
                    }
                } 
                else {
                    throw new Exception("Expression did not evalute to correct type")
                }
            }
            return ()
        }
    }

    def checkExpression(expr: Expr, st: SymbolTable): SymbolType = expr match {
        case IntExpr(_) => return IntSymbol
        case BoolExpr(_) => return BoolSymbol
        case CharExpr(_) => return CharSymbol
        case StrExpr(_) => return StringSymbol
        case Identifier(id) => st.lookupRecursive(id) match {
            case None => throw new Exception("Attempted to access an undefined variable")
            case Some(value) => return value
        }
        case ArrayElem(id, positions) => {
            val arrayType: SymbolType = st.lookupRecursive(id.id) match {
                case Some(value) => value
                case None => throw new Exception("Value does not exist")
            }
            positions.map(p => checkEvaluatesTo(p, st, IntSymbol))
            return derefType(arrayType, positions.length)
        }
        case ParenExpr(e) => checkExpression(e, st)
        case ChrOp(e) => {
            checkEvaluatesTo(e, st, IntSymbol)
            return CharSymbol
        }
        case LenOp(e)  => {
            checkEvaluatesTo(e, st, ArraySymbol(AmbiguousSymbol))
            return IntSymbol
        }
        case NegateOp(e)  => {
            checkEvaluatesTo(e, st, IntSymbol)
            return IntSymbol
        }
        case NotOp(e)  => {
            checkEvaluatesTo(e, st, BoolSymbol)
            return BoolSymbol
        }
        case OrdOp(e)  => {
            checkEvaluatesTo(e, st, CharSymbol)
            return IntSymbol
        }
        case Div(left, right) => checkMathExpr(left, right, st)
        case Mod(left, right) => checkMathExpr(left, right, st)
        case Mul(left, right) => checkMathExpr(left, right, st)
        case Add(left, right) => checkMathExpr(left, right, st)
        case Sub(left, right) => checkMathExpr(left, right, st)
        case GreaterThan(left, right) => checkOrderExpr(left, right, st)
        case GreaterOrEqualThan(left, right) => checkOrderExpr(left, right, st)
        case LessThan(left, right) => checkOrderExpr(left, right, st)
        case LessOrEqualThan(left, right) => checkOrderExpr(left, right, st)
        case Equal(left, right) => {
            checkEqualExpr(left, right, st)
            return BoolSymbol
        }
        case NotEqual(left, right) => {
            checkEqualExpr(left, right, st)
            return BoolSymbol
        }
        case And(left, right) => checkBoolExpr(left, right, st)
        case Or(left, right) => checkBoolExpr(left, right, st)
        case PairLiteral => return PairLiteralSymbol
    }

    def checkEqualExpr(exprL: Expr, exprR: Expr, st: SymbolTable): SymbolType = {
        val exprType = checkExpression(exprL, st)
        checkEvaluatesTo(exprR, st, exprType)
        return exprType
    }

    def checkOrderExpr(exprL: Expr, exprR: Expr, st: SymbolTable): SymbolType = {
        val t = checkEqualExpr(exprL, exprR, st)
        if (t == IntSymbol || t == CharSymbol) {
            return BoolSymbol
        } else {
            throw new Exception("Type mismatch in expression")
        }
    }

    def checkMathExpr(exprL: Expr, exprR: Expr, st: SymbolTable): SymbolType = {
        checkEvaluatesTo(exprL, st, IntSymbol)
        checkEvaluatesTo(exprR, st, IntSymbol)
        return IntSymbol
    }

    def checkBoolExpr(exprL: Expr, exprR: Expr, st: SymbolTable): SymbolType = {
        checkEvaluatesTo(exprL, st, BoolSymbol)
        checkEvaluatesTo(exprR, st, BoolSymbol)
        return BoolSymbol
    }

    def checkLvalue(lValue: Lvalue, st: SymbolTable): SymbolType = lValue match {
        case PairElemFst(pair) => checkLvalue(pair, st) match{
            case TopPairSymbol(fst, snd) => return fst
            case PairLiteralSymbol => return NestedPairSymbol
            case NestedPairSymbol => return NestedPairSymbol
            case _ => throw new Exception("Attempt to deference a non-pair element")
        }
        case PairElemSnd(pair) => checkLvalue(pair, st) match{
            case TopPairSymbol(fst, snd) => return snd
            case PairLiteralSymbol => return NestedPairSymbol
            case NestedPairSymbol => return NestedPairSymbol
            case _ => throw new Exception("Attempt to deference a non-pair element")
        }
        case expr => return checkExpression(expr.asInstanceOf[Expr], st)
    }

    def checkRvalue(value: Rvalue, st: SymbolTable): SymbolType = value match{
        case ArrayLiteral(value) => {
            val arrayTypes: List[SymbolType] = value.map(e => checkExpression(e, st))
            if (arrayTypes.length > 0) {
                if (arrayTypes.distinct.length == 1){
                    return ArraySymbol(arrayTypes.head)
                } else{
                    throw new Exception("Non uniform types in array")
                }            
            } else {
                return ArraySymbol(AmbiguousSymbol)
            }
        }
        case NewPair(left, right) => {
            val symbolLeft = checkExpression(left, st)
            val symbolRight = checkExpression(right, st)
            TopPairSymbol(symbolLeft match {
                case TopPairSymbol(ft, st) => PairLiteralSymbol
                case PairLiteralSymbol => NestedPairSymbol
                case NestedPairSymbol => NestedPairSymbol
                case default => default
            }, symbolRight match {
                case TopPairSymbol(ft, st) => PairLiteralSymbol
                case NestedPairSymbol => NestedPairSymbol
                case PairLiteralSymbol => NestedPairSymbol
                case default => default
            })
        }
        case Call(id, args) => st.lookupFunctionRecursive(id.id) match {
            case Some(FunctionSymbol(returnT, argsT)) => {
                matchArgs(argsT, args.args, st)
                return returnT
            }
            case _ => throw new Exception("Attempted to call a function that does not exist")
        }
        case PairElemFst(pair) => checkLvalue(value.asInstanceOf[Lvalue], st)
        case PairElemSnd(pair) => checkLvalue(value.asInstanceOf[Lvalue], st)
        case expr => checkExpression(expr.asInstanceOf[Expr], st)
    }

    def matchArgs(expected: List[SymbolType], provided: List[Expr], st: SymbolTable) = {
        if (expected.length != provided.length){
            throw new Exception("Unexpected arguments provided")
        } else { 
            if(expected != provided.map(e => checkExpression(e, st))){
                throw new Exception("Arguments passed to this function do not match the expected types")
            }
        }
    }

}
