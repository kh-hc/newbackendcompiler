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
        checkStatement(ast.stat, symbolTable, NullSymbol)
    }

    def checkFunction(function: FunctionUnit, symbolTable: SymbolTable) = {
        // Create a symbol table for the new scope
        var funcSymbols = new SymbolTable(Some(symbolTable))
        // Add each parameter into the new symbol table 
        function match {
            case ParamFunc => function.params.paramlist.map(p => funcSymbols.add(p.id.id, p.t))
            case NiladicFunc => Unit
        }
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

    def checkEvaluatesTo(expr: Expr, symbolTable: SymbolTable, t: SymbolType) = {
        if (checkExpression(expr, symbolTable) != t){
            throw new Error("Expression did not evalute to correct type")
        }
    }

    def checkExpression(expr: IntExpr, st: SymbolTable): SymbolType = IntSymbol
    def checkExpression(expr: BoolExpr, st: SymbolTable): SymbolType = BoolSymbol
    def checkExpression(expr: CharExpr, st: SymbolTable): SymbolType = CharSymbol
    def checkExpression(expr: StrExpr, st: SymbolTable): SymbolType = StringSymbol
    def checkExpression(expr: PairLiteral, st: SymbolTable): SymbolType = Unit//TODO
    def checkExpression(expr: Identifier, st: SymbolTable): SymbolType = t.lookup(expr.id) match{
        case None => throw new Error("Attempted to access an undefined variable")
        case Some(value) => return value
    }
    def checkExpression(expr: ArrayElem, st: SymbolTable): SymbolType = Unit//TODO
    def checkExpression(expr: ParenExpr, st: SymbolTable): SymbolType = checkExpression(expr.expr, st)
    def checkExpression(expr: UnaryOp, st: SymbolTable): SymbolType = Unit//TODO
    def checkExpression(expr: BinaryOp, st: SymbolTable): SymbolType = Unit//TODO

    def checkLvalue(ident: Identifier, st: SymbolTable): SymbolType = checkExpression(ident, st)
    def checkLvalue(arrayElem: ArrayElem, st: SymbolTable): SymbolType = checkExpression()
    def checkLvalue(pairElem: PairElem, st: SymbolTable): SymbolType = Unit//TODO

    def checkRvalue(expr: Expr, st: SymbolTable): SymbolType = Unit//TODO
    def checkRvalue(arrayLiter: ArrayLiteral, st: SymbolTable): SymbolType = Unit//TODO
    def checkRvalue(newPair: NewPair, st: SymbolTable): SymbolType = Unit//TODO
    def checkRvalue(functionCall: Cal, st: SymbolTablel): SymbolType = Unit//TODO

}
