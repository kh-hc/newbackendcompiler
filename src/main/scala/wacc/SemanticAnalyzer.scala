package wacc
import wacc.abstractSyntaxTree._
import scala.collection.mutable.ListBuffer

class SemanticAnalyzer(file: String) {
    import SymbolTypes._    
    import WACCErrors._

    // Stores the errors - this allows us to analyze the entire program and catch all the semantic errors
    var errorStack = new ListBuffer[WACCError]

    // Checks whether any errors have been found
    def isErrors(): Boolean = {
        return errorStack.length > 0 
    }

    // Gets a list of errors 
    def getErrors(): List[WACCError] = {
        return errorStack.toList
    }

    // Main analysis function
    def analyzeProgram(ast: WACCprogram)  = {
        val symbolTable = new SymbolTable(None)

        // Record function definitions in the symbol table as functions can be mutually recursive
        ast.funcs.map(f => {
            try{
                symbolTable.add(f)
            } catch {
                case  e: Exception =>{
                    errorStack += varAlreadyAss.err(f.id)(file)
                } 
            }
        })

        // Analyze the body of the functions
        ast.funcs.map(f => checkFunction(f, symbolTable))

        // Using NoReturn allows checking that the main body does not return anything
        checkStatement(ast.stat, symbolTable, NoReturn)
        ast.symbolTable = Some(symbolTable)
    }

    def checkFunction(function: FunctionUnit, symbolTable: SymbolTable) = {
        // Create a symbol table for the argument scope
        val argsSymbols = new SymbolTable(Some(symbolTable))

        // Add each parameter into the new symbol table 
        function.params.paramlist.map(p => {
            try{
                argsSymbols.add(p.id.id, p.t) 
            } catch {
                case  e: Exception => {
                    errorStack += varAlreadyAss.err(p.id)(file)
                }
            }})

        // Analyze the function, with a new child symbol table as function arguments can be shadowed
        checkStatement(function.body, new SymbolTable(Some(argsSymbols)), translate(function.t))
        function.symbolTable = Some(symbolTable)
    }

    def checkStatement(statement: StatementUnit, symbolTable: SymbolTable, returnType: SymbolType): Unit = statement match{
        case SkipStat => ()
        case AssignStat(t, id, value) => {
            // Check that we are not trying to assign to something that already exists
            if (symbolTable.lookup(id.id).isEmpty){
                val expectedType = translate(t)
                val providedType = checkRvalue(value, symbolTable)
                if (expectedType != providedType) {
                    // If the type of the right value provided is unexpected, this could be due to ambiguous typing rules with pairs and arrays:
                    providedType match {
                        case TopPairSymbol(a, b) => expectedType match {
                            case TopPairSymbol(x, y) => {
                                if (!((x == NestedPairSymbol || a == NestedPairSymbol || x == a)
                                && (y == NestedPairSymbol || b == NestedPairSymbol || b == y))){
                                    errorStack += unexpectedTypeStat.err(statement, providedType, expectedType)(file)
                                }
                            }
                            case NestedPairSymbol => 
                            case PairLiteralSymbol =>
                            case default => errorStack += unexpectedTypeStat.err(statement, providedType, expectedType)(file)
                        }
                        case PairLiteralSymbol => expectedType match {
                            case TopPairSymbol(ft, st) => 
                            case NestedPairSymbol => 
                            case default => errorStack += unexpectedTypeStat.err(statement, providedType, expectedType)(file)
                        }
                        case ArraySymbol(AmbiguousSymbol) => expectedType match{
                            case ArraySymbol(x) =>
                            case default => errorStack += unexpectedTypeStat.err(statement, providedType, expectedType)(file)
                        }
                        case ArraySymbol(TopPairSymbol(x, y)) => expectedType match{
                            case ArraySymbol(TopPairSymbol(a, b)) => {
                                if (!((x == NestedPairSymbol || a == NestedPairSymbol || x == a)
                                && (y == NestedPairSymbol || b == NestedPairSymbol || b == y))){
                                    errorStack += unexpectedTypeStat.err(statement, providedType, expectedType)(file)
                                }
                            }
                            case ArraySymbol(NestedPairSymbol) => 
                            case ArraySymbol(PairLiteralSymbol) =>
                            case default => errorStack += unexpectedTypeStat.err(statement, providedType, expectedType)(file)
                        }
                        case ArraySymbol(PairLiteralSymbol) => expectedType match {
                            case ArraySymbol(TopPairSymbol(ft, st)) => 
                            case ArraySymbol(NestedPairSymbol) => 
                            case default => errorStack += unexpectedTypeStat.err(statement, providedType, expectedType)(file)
                        }
                        case ArraySymbol(NestedPairSymbol) => expectedType match {
                            case ArraySymbol(x) =>
                            case default => errorStack += unexpectedTypeStat.err(statement, providedType, expectedType)(file)
                        }
                        case NestedPairSymbol => 
                        case AmbiguousSymbol => 
                        case default => errorStack += unexpectedTypeStat.err(statement, providedType, expectedType)(file)
                    }
                }
                try{
                    symbolTable.add(id.id, expectedType)
                } catch {
                    case e: Exception =>{
                        errorStack += varAlreadyAss.err(id)(file)
                    }
                }
                statement.symbolTable = Some(symbolTable)
                return ()
            } else {
                errorStack += varAlreadyAss.err(id)(file)
                return ()
            }
        }
        case ReassignStat(left, right) => {
            val leftType = checkLvalue(left, symbolTable)
            val rightType = checkRvalue(right, symbolTable)
            // If the types are not equal, we may be dealing with the ambiguous typing rules with pairs/arrays
            if (leftType != rightType){
                leftType match {
                    case TopPairSymbol(ft, st) => rightType match {
                        case NestedPairSymbol => 
                        case PairLiteralSymbol => 
                        case default => errorStack += unexpectedTypeStat.err(statement, rightType, leftType)(file)
                    }
                    case ArraySymbol(AmbiguousSymbol) => rightType match {
                        case ArraySymbol(x) =>
                        case default => errorStack += unexpectedTypeStat.err(statement, rightType, leftType)(file)
                    }
                    case AmbiguousSymbol =>
                    case PairLiteralSymbol =>  rightType match {
                        case TopPairSymbol(ft, st) => 
                        case NestedPairSymbol =>
                        case default => errorStack += unexpectedTypeStat.err(statement, rightType, leftType)(file) 
                    }
                    case NestedPairSymbol =>
                    case default => errorStack += unexpectedTypeStat.err(statement, rightType, leftType)(file) 
                }
            }
            // Disallow having an ambiguous type on both sides of the reassign, as mentioned in the spec
            if ((leftType == NestedPairSymbol) && (rightType == NestedPairSymbol)){
                errorStack += ambiguousTypesReAss.err(statement, left, right)(file) 
            }
            statement.symbolTable = Some(symbolTable)
            return ()
        }
        case ReadStat(value) => checkLvalue(value, symbolTable) match {
            // We can only read ints or chars
            case IntSymbol => ()
            case CharSymbol => ()
            case default => errorStack += readError.err(value, default)(file) 
        }
        case FreeStat(expr) =>  checkExpression(expr, symbolTable) match {
            // Makes sure that we are only freeing pairs or arrays
            case ArraySymbol(_) => ()
            case NestedPairSymbol => ()
            case PairLiteralSymbol => ()
            case TopPairSymbol(_, _) => ()
            case default => errorStack += freeError.err(expr, default)(file)
        }
        case ReturnStat(expr) => checkEvaluatesTo(expr, symbolTable, returnType)
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
        statement.symbolTable = Some(symbolTable)
    }

    def checkEvaluatesTo(expr: Expr, symbolTable: SymbolTable, t: SymbolType): Unit = t match{
        // We only try evaluting to NoReturn if we are trying to return from the body of the code
        case NoReturn => errorStack += returnError.err(expr)(file)
        // Nested pairs can match with anything
        case NestedPairSymbol => return ()
        case TopPairSymbol(x, y) => {
            val exprType = checkExpression(expr, symbolTable)
            if (exprType != t){
                exprType match{
                    case NestedPairSymbol => return ()
                    case PairLiteralSymbol => return ()
                    case _ => errorStack += unexpectedTypeExpr.err(expr, exprType, t)(file)
                }
            }
        }
        case symbolType => {
            val exprType = checkExpression(expr, symbolTable)
            // If the expected type does not match the actual type, check that the evalution does not lead to an ambiguous type
            if (exprType != symbolType){
                if (exprType == NestedPairSymbol) {
                    return ()
                }
                if (symbolType == ArraySymbol(AmbiguousSymbol)){
                    exprType match{
                        case ArraySymbol(subtype) => return ()
                        case _ => errorStack += unexpectedTypeExpr.err(expr, exprType, symbolType)(file) 
                    }
                } else if (symbolType == PairLiteralSymbol) {
                    exprType match {
                        case TopPairSymbol(x, y) =>
                        case _ => errorStack += unexpectedTypeExpr.err(expr, exprType, symbolType)(file) 
                    }
                } 
                else {
                    errorStack += unexpectedTypeExpr.err(expr, exprType, symbolType)(file) 
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
            // If we can't find the identifer, log an error but then continue the analysis with an amibiguous symbol
            case None => {
                errorStack += undefinedVar.err(expr.asInstanceOf[Identifier])(file) 
                return AmbiguousSymbol
            }
            case Some(value) => return value
        }
        case ArrayElem(id, positions) => {
            val arrayType: SymbolType = st.lookupRecursive(id.id) match {
                case Some(value) => value
                case None => {
                    errorStack += undefinedVar.err(id)(file) 
                    return AmbiguousSymbol
                }
            }
            positions.map(p => checkEvaluatesTo(p, st, IntSymbol))
            // Makes sure that the array types match fully, and logs an error if not
            try{
                return derefType(arrayType, positions.length)
            } catch {
                case e: Exception => {
                    errorStack += derefErrE.err(expr)(file) 
                    return AmbiguousSymbol
                }
            }
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
        // Checks that the types on either side of a binary expression are the same
        val exprType = checkExpression(exprL, st)
        checkEvaluatesTo(exprR, st, exprType)
        return exprType
    }

    def checkOrderExpr(exprL: Expr, exprR: Expr, st: SymbolTable): SymbolType = {
        // Checks that the types on either side of a binary expression could be ints or chars
        val t = checkEqualExpr(exprL, exprR, st)
        if (!(t == IntSymbol || t == CharSymbol)) {
            errorStack += unexpectedTypeExpr.err(exprL, t, IntSymbol)(file) 
        }
        return BoolSymbol
    }

    def checkMathExpr(exprL: Expr, exprR: Expr, st: SymbolTable): SymbolType = {
        // Checks that both expressions could evaluate to ints
        checkEvaluatesTo(exprL, st, IntSymbol)
        checkEvaluatesTo(exprR, st, IntSymbol)
        return IntSymbol
    }

    def checkBoolExpr(exprL: Expr, exprR: Expr, st: SymbolTable): SymbolType = {
        // Checks that both expressions could evalute to chars
        checkEvaluatesTo(exprL, st, BoolSymbol)
        checkEvaluatesTo(exprR, st, BoolSymbol)
        return BoolSymbol
    }

    def checkLvalue(lValue: Lvalue, st: SymbolTable): SymbolType = lValue match {
        case PairElemFst(pair) => checkLvalue(pair, st) match{
            case TopPairSymbol(fst, snd) => return fst
            case PairLiteralSymbol => return NestedPairSymbol
            case NestedPairSymbol => return NestedPairSymbol
            case default => {
                errorStack += derefErr.err(lValue, default)(file) 
                return NestedPairSymbol
            }
        }
        case PairElemSnd(pair) => checkLvalue(pair, st) match{
            case TopPairSymbol(fst, snd) => return snd
            case PairLiteralSymbol => return NestedPairSymbol
            case NestedPairSymbol => return NestedPairSymbol
            case default => {
                errorStack += derefErr.err(lValue, default)(file) 
                return NestedPairSymbol
            }
        }
        // All l-values types that are not pair elems are encompassed in the evalution of expressions, so we can use the same checker
        case expr => return checkExpression(expr.asInstanceOf[Expr], st)
    }

    def checkRvalue(value: Rvalue, st: SymbolTable): SymbolType = value match{
        case ArrayLiteral(contents) => {
            val arrayTypes: List[SymbolType] = contents.map(e => checkExpression(e, st))
            // Ensures that every element in the array is of the same type, and returns that type
            if (arrayTypes.length > 0) {
                if (arrayTypes.distinct.length == 1){
                    return ArraySymbol(arrayTypes.head)
                } else{
                    errorStack += arrayTypeErr.err(value, arrayTypes.head)(file) 
                    return ArraySymbol(AmbiguousSymbol)
                }            
            } else {
                return ArraySymbol(AmbiguousSymbol)
            }
        }
        case NewPair(left, right) => {
            val symbolLeft = checkExpression(left, st)
            val symbolRight = checkExpression(right, st)
            // Ensures that the pair type nesting heirachy is preserved when new pairs are created
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
            // Check that the function exists and the argument types match
            case Some(FunctionSymbol(returnT, argsT)) => {
                matchArgs(argsT, args.args, st, id)
                return returnT
            }
            case _ => {
                errorStack += undefFunc.err(id)(file) 
                return AmbiguousSymbol
            }
        }
        // Reduce code duplication by letting l-value and expression evalute the rest of the r-values (they evaluate in the same way)
        case PairElemFst(pair) => checkLvalue(value.asInstanceOf[Lvalue], st)
        case PairElemSnd(pair) => checkLvalue(value.asInstanceOf[Lvalue], st)
        case expr => checkExpression(expr.asInstanceOf[Expr], st)
    }

    def matchArgs(expected: List[SymbolType], provided: List[Expr], st: SymbolTable, id: Identifier) = {
        // Checks that the function is given the arguments that we expect
        if (expected.length != provided.length){
            errorStack += argumentMismatch.err(id)(file) 
        } else { 
            expected.lazyZip(provided).map((ex, pr) => checkEvaluatesTo(pr, st, ex))            
        }
    }

}
