package wacc
import wacc.abstractSyntaxTree._

object SemanticAnalyzer {
    import SymbolTypes._    

    def analyzeProgram(ast: WACCprogram)  = {
        var symbolTable = new SymbolTable(None)
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
        var funcSymbols = new SymbolTable(Some(symbolTable))
        // Add each parameter into the new symbol table 
        function.params.paramlist.map(p => funcSymbols.add(p.id.id, p.t))
        // Analyze each statement in the body of the function
        checkStatement(function.body, funcSymbols, translate(function.t))
    }

    def checkStatement(statement: StatementUnit, symbolTable: SymbolTable, returnType: SymbolType): Unit = statement match{
        case SkipStat => ()
        case AssignStat(t, id, value) => {
            if (symbolTable.lookup(id.id).isEmpty){
                if(checkRvalue(value, symbolTable) == translate(t)){
                    symbolTable.add(id.id, t)
                    return ()
                } else {
                    throw new Exception("Definition with conflicting types")
                }
            } else {
                throw new Exception("Variable already assigned to in this scope")
            }
        }
        case ReassignStat(left, right) => {
            var leftType = checkLvalue(left, symbolTable)
            var rightType = checkRvalue(right, symbolTable)
            if (leftType != rightType){
                if (!((leftType == AmbiguousSymbol) ^ (rightType == AmbiguousSymbol))){
                    throw new Exception("Type mismatch")
                }
            }
            return ()
        }
        case ReadStat(value) => checkLvalue(value, symbolTable)
        case FreeStat(expr) =>  {
            checkExpression(expr, symbolTable) match {
                case ArraySymbol(_) => ()
                case PairObjSymbol => ()
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
            checkStatement(ifStat, symbolTable, returnType)
            checkStatement(elseStat, symbolTable, returnType)
        }
        case WhileStat(cond, body) => {
            checkEvaluatesTo(cond, symbolTable, BoolSymbol)
            checkStatement(body, symbolTable, returnType)
        }
        case ScopeStat(stat) => checkStatement(stat, new SymbolTable(Some(symbolTable)), returnType)
        case SeqStat(stats) => stats.map(s => checkStatement(s, symbolTable, returnType))
    }

    def checkEvaluatesTo(expr: Expr, symbolTable: SymbolTable, t: SymbolType): Unit = t match{
        case NoReturn => throw new Exception("Attempt to return from program body")
        case symbolType => {
            var exprType = checkExpression(expr, symbolTable)
            if (exprType != symbolType){
                if (t == ArraySymbol(AmbiguousSymbol)){
                    exprType match{
                        case ArraySymbol(subtype) => return ()
                        case _ => throw new Exception("Expression did not evalute to correct type")
                    }
                }else{
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
        case Identifier(id) => st.lookup(id) match {
            case None => throw new Exception("Attempted to access an undefined variable")
            case Some(value) => return value
        }
        case ArrayElem(id, positions) => {
            var arrayType: SymbolType = st.lookupRecursive(id.id) match {
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
        case PairLiteral => return PairObjSymbol
    }
/*
    def checkExpression(expr: IntExpr, st: SymbolTable): SymbolType = IntSymbol
    def checkExpression(expr: BoolExpr, st: SymbolTable): SymbolType = BoolSymbol
    def checkExpression(expr: CharExpr, st: SymbolTable): SymbolType = CharSymbol
    def checkExpression(expr: StrExpr, st: SymbolTable): SymbolType = StringSymbol
    def checkExpression(expr: Identifier, st: SymbolTable): SymbolType = t.lookup(expr.id) match{
        case None => throw new Exception("Attempted to access an undefined variable")
        case Some(value) => return value
    }
    def checkExpression(expr: ArrayElem, st: SymbolTable): SymbolType = {
        var arrayType: SymbolType = st.lookupRecursive(expr.id.id)
        expr.position.map(p => checkEvaluatesTo(p, st, IntSymbol))
        return getBaseType(arrayType)
    }
    def checkExpression(expr: ParenExpr, st: SymbolTable): SymbolType = checkExpression(expr.expr, st)
    def checkExpression(expr: UnaryOp, st: SymbolTable): SymbolType = expr match{
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
    }
    def checkExpression(expr: BinaryOp, st: SymbolTable): SymbolType = expr match{
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
    }
    def checkExpression(expr: PairLiteral, st: SymbolTable): SymbolType = PairObjSymbol
*/
    def checkEqualExpr(exprL: Expr, exprR: Expr, st: SymbolTable): SymbolType = {
        var exprType = checkExpression(exprL, st)
        checkEvaluatesTo(exprR, st, exprType)
        return exprType
    }

    def checkOrderExpr(exprL: Expr, exprR: Expr, st: SymbolTable): SymbolType = {
        var t = checkEqualExpr(exprL, exprR, st)
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
            case PairObjSymbol => return PairObjSymbol
            case _ => throw new Exception("Attempt to deference a non-pair element")
        }
        case PairElemSnd(pair) => checkLvalue(pair, st) match{
            case TopPairSymbol(fst, snd) => return snd
            case PairObjSymbol => return PairObjSymbol
            case _ => throw new Exception("Attempt to deference a non-pair element")
        }
        case expr => return checkExpression(expr.asInstanceOf[Expr], st)
    }

    // def checkLvalue(ident: Identifier, st: SymbolTable): SymbolType = checkExpression(ident, st)
    // def checkLvalue(arrayElem: ArrayElem, st: SymbolTable): SymbolType = checkExpression(arrayElem, st)
    // def checkLvalue(pairElem: PairElemFst, st: SymbolTable): SymbolType = checkLvalue(pairElem.pair) match{
    //     case TopPairSymbol(ft, st) => ft
    //     case PairObjSymbol => PairObjSymbol
    //     case _ => throw new Exception("Attempt to deference a non-pair element")
    // }

    def checkRvalue(value: Rvalue, st: SymbolTable): SymbolType = value match{
        case ArrayLiteral(value) => {
            var arrayTypes: List[SymbolType] = value.map(e => checkExpression(e, st))
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
        case NewPair(left, right) => TopPairSymbol(checkExpression(left, st), checkExpression(right, st))
        case Call(id, args) => st.lookupRecursive(id.id) match {
            case Some(FunctionSymbol(returnT, argsT)) => {
                matchArgs(argsT, args.args, st)
                return returnT
            }
            case _ => throw new Exception("Attempted to call a function that does not exist")
        }
        case expr => checkExpression(expr.asInstanceOf[Expr], st)
    }

    def matchArgs(expected: List[SymbolType], provided: List[Expr], st: SymbolTable) = (
        if (expected.length != provided.length){
            throw new Exception("Unexpected arguments provided")
        } else {
            if(expected != provided.map(e => checkExpression(e, st))){
                throw new Exception("Arguments passed to this function do not match the expected types")
            }
        }
    )

}
