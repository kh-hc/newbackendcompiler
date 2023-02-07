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

    def checkFunction(function: NiladicFunc, symbolTable: SymbolTable) = checkFunction(ParamFunc(function.t, function.id, ParamList(new List[Param]()), function.body))
    def checkFunction(function: ParamFunc, symbolTable: SymbolTable) = {
        // Create a symbol table for the new scope
        var funcSymbols = new SymbolTable(Some(symbolTable))
        // Add each parameter into the new symbol table 
        function.params.paramlist.map(p => funcSymbols.add(p.id.id, p.t))
        // Analyze each statement in the body of the function
        checkStatement(func.body, funcSymbols)
    }

    def checkStatement(statement: SkipStat, symbolTable: SymbolTable, returnType: SymbolType) = Unit
    def checkStatement(statement: AssignStat, symbolTable: SymbolTable, returnType: SymbolType) = symbolTable.add(statement.id.id, statement.t)
    def checkStatement(statement: ReassignStat, symbolTable: SymbolTable, returnType: SymbolType) = {
        var leftType = checkLvalue(statement.left, symbolTable)
        var rightType = checkRvalue(statement.right, symbolTable)
        if (leftType != rightType){
            if (!((leftType == AmbiguousSymbol) ^ (rightType == AmbiguousSymbol))){
                throw new Error("Type mismatch")
            }
        }
    }
    def checkStatement(statement: ReadStat, symbolTable: SymbolTable, returnType: SymbolType) = checkLvalue(statement.value, symbolTable)
    def checkStatement(statement: FreeStat, symbolTable: SymbolTable, returnType: SymbolType) = {
        checkExpression(statement.expr, symbolTable) match {
            case ArraySymbol => Unit
            case PairSymbol => Unit
            case default => throw new Error("Tried to free a non-pair/array") 
        }
    }
    def checkStatement(statement: ReturnStat, symbolTable: SymbolTable, returnType: SymbolType) = checkEvaluatesTo(statement.expr, symbolTable, returnType)
    def checkStatement(statement: ExitStat, symbolTable: SymbolTable, returnType: SymbolType) = checkEvaluatesTo(statement.expr, symbolTable, IntSymbol)
    def checkStatement(statement: PrintStat, symbolTable: SymbolTable, returnType: SymbolType) = checkExpression(statement.expr, symbolTable)
    def checkStatement(statement: PrintlnStat, symbolTable: SymbolTable, returnType: SymbolType) = checkExpression(statement.expr, symbolTable)
    def checkStatement(statement: IfStat, symbolTable: SymbolTable, returnType: SymbolType) = (
        checkEvaluatesTo(statement.cond, symbolTable, BoolSymbol)
        checkStatement(statement.ifStat, symbolTable, returnType)
        checkStatement(statement.elseStat, symbolTable, returnType)
    )
    def checkStatement(statement: WhileStat, symbolTable: SymbolTable, returnType: SymbolType) = (
        checkEvaluatesTo(statement.cond, symbolTable BoolSymbol)
        checkStatement(statement.body, symbolTable, returnType)
    )
    def checkStatement(statement: ScopeStat, symbolTable: SymbolTable, returnType: SymbolType) = checkStatement(statement.body, new SymbolTable(Some(symbolTable)), returnType)
    def checkStatement(statement: SeqStat, symbolTable: SymbolTable, returnType: SymbolType) = statement.statements.map(s => checkStatement(s, symbolTable, returnType))

    def checkEvaluatesTo(expr: Expr, symbolTable: SymbolTable, t: NoReturn) = throw new Error("Attempt to return from program body")
    def checkEvaluatesTo(expr: Expr, symbolTable: SymbolTable, t: SymbolType) = {
        var exprType = checkExpression(expr, symbolTable)
        if (exprType != t){
            if (t == ArraySymbol(AmbiguousSymbol)){
                exprType match{
                    case ArraySymbol(subtype) => return
                    case _ => 
                }
            } 
            throw new Error("Expression did not evalute to correct type")
        }
    }


    def checkExpression(expr: IntExpr, st: SymbolTable): SymbolType = IntSymbol
    def checkExpression(expr: BoolExpr, st: SymbolTable): SymbolType = BoolSymbol
    def checkExpression(expr: CharExpr, st: SymbolTable): SymbolType = CharSymbol
    def checkExpression(expr: StrExpr, st: SymbolTable): SymbolType = StringSymbol
    def checkExpression(expr: Identifier, st: SymbolTable): SymbolType = t.lookup(expr.id) match{
        case None => throw new Error("Attempted to access an undefined variable")
        case Some(value) => return value
    }
    def checkExpression(expr: ArrayElem, st: SymbolTable): SymbolType = {
        var arrayType: SymbolType = st.lookupRecursive(expr.id.id)
        expr.position.map(p => checkEvaluatesTo(p, st, IntSymbol))
        return getBaseType(arrayType)
    }
    def checkExpression(expr: ParenExpr, st: SymbolTable): SymbolType = checkExpression(expr.expr, st)
    def checkExpression(expr: UnaryOp, st: SymbolTable): SymbolType = expr match{
        case ChrOp(e) => (
            checkEvaluatesTo(e, st, IntSymbol)
            CharSymbol
        ) 
        case LenOp(e)  => (
            checkEvaluatesTo(e, st, ArraySymbol(AmbiguousSymbol))
            IntSymbol
        )
        case NegateOp(e)  => (
            checkEvaluatesTo(e, st, IntSymbol)
            IntSymbol
        )
        case NotOp(e)  => (
            checkEvaluatesTo(e, st, BoolSymbol)
            BoolSymbol
        ) 
        case OrdOp(e)  => (
            checkEvaluatesTo(e, st, CharSymbol)
            IntSymbol
        )        
    }
    def checkExpression(expr: BinaryOp, st: SymbolTable): SymbolType = expr match{
        case Div => checkMathExpr(expr.exprLeft, expr.exprRight, st)
        case Mod => checkMathExpr(expr.exprLeft, expr.exprRight, st)
        case Mul => checkMathExpr(expr.exprLeft, expr.exprRight, st)
        case Add => checkMathExpr(expr.exprLeft, expr.exprRight, st)
        case Sub => checkMathExpr(expr.exprLeft, expr.exprRight, st)
        case GreaterThan => checkOrderExpr(expr.exprLeft, expr.exprRight, st)
        case GreaterOrEqualThan => checkOrderExpr(expr.exprLeft, expr.exprRight, st)
        case LessThan => checkOrderExpr(expr.exprLeft, expr.exprRight, st)
        case LessOrEqualThan => checkOrderExpr(expr.exprLeft, expr.exprRight, st)
        case Equal => {
            checkEqualExpr(expr.exprLeft, expr.exprRight, st)
            return BoolSymbol
        }
        case NotEqual => {
            checkEqualExpr(expr.exprLeft, expr.exprRight, st)
            return BoolSymbol
        }
        case And => checkBoolExpr(expr.exprLeft, expr.exprRight, st)
        case Or => checkBoolExpr(expr.exprLeft, expr.exprRight, st)
    }
    def checkExpression(expr: PairLiteral, st: SymbolTable): SymbolType = PairObjSymbol

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
            throw new Error("Type mismatch in expression")
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

    def checkLvalue(ident: Identifier, st: SymbolTable): SymbolType = checkExpression(ident, st)
    def checkLvalue(arrayElem: ArrayElem, st: SymbolTable): SymbolType = checkExpression(arrayElem, st)
    def checkLvalue(pairElem: PairElemFst, st: SymbolTable): SymbolType = checkLvalue(pairElem.pair) match{
        case TopPairSymbol(ft, st) => ft
        case PairObjSymbol => PairObjSymbol
        case _ => throw new Error("Attempt to deference a non-pair element")
    }

    def checkRvalue(expr: Expr, st: SymbolTable): SymbolType = checkExpression(expr, st)
    def checkRvalue(arrayLiter: ArrayLiteral, st: SymbolTable): SymbolType = {
        var arrayTypes: List[SymbolType] = arrayLiter.value.map(e => checkExpression(e, st))
        if (arrayTypes.length() > 0) {
            if (arrayTypes.distinct.length() == 1){
                return ArraySymbol(arrayTypes.head)
            } else{
                throw new Error("Non uniform types in array")
            }            
        } else {
            return ArraySymbol(AmbiguousSymbol)
        }
    }
    def checkRvalue(newPair: NewPair, st: SymbolTable): SymbolType = TopPairSymbol(checkExpression(newPair.exprLeft), checkExpression(newPair.exprRight))
    def checkRvalue(call: NiladicCall, st: SymbolTable): SymbolType = checkRvalue(ParamCall(call.id, ArgList(new List[Expr]())), st)
    def checkRvalue(call: ParamCall, st: SymbolTablel): SymbolType = st.lookupRecursive(call.id.id) match {
        case FunctionSymbol(returnT, argsT) => (
            matchArgs(argsT, call.args.args)
            returnT
        )
        case _ => throw new Error("Attempted to call a function that does not exist")
    }

    def matchArgs(expected: List[SymbolType], provided: List[Expr], st: SymbolTable) = (
        if (expected.length != provided.length){
            throw new Error("Unexpected arguments provided")
        } else {
            if(expected != provided.map(e => checkExpression(e, st))){
                throw new Error("Arguments passed to this function do not match the expected types")
            }
        }
    )

}
