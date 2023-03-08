package wacc

class SymbolTable(val parent: Option[SymbolTable]) {
    import SymbolTypes._
    import abstractSyntaxTree._

    var unique_id = ""
    var counter = 0

    parent match {
        case Some(st) => {
            st.counter = st.counter + 1
            unique_id = st.unique_id + st.counter.toString
        } 
        case None => {
            unique_id = "0"
        }
    }

    // Stores functions and variables separately, as variable names can shadow function names
    var table = Map.empty[String, SymbolType];
    var functionTable = Map.empty[String, SymbolType];

    def add(func: FunctionUnit) : Unit = (
        if (lookupFunction(func.id.id).isEmpty){
            functionTable = functionTable + (func.id.id -> FunctionSymbol(translate(func.t), func.params.paramlist.map(p => translate(p.t))))
        } else {
            throw new Exception("Attempt to redefine a variable or function")
        }
    )

    def add(name: String, t: Type) : Unit = (
        add(name, translate(t))
    )

    def add(name: String, t: SymbolType) : Unit = (
        if (lookup(name).isEmpty){
            table = table + (name -> t)
        } else {
            throw new Exception("Attempt to redefine a variable or function")
        }
    )

    def lookup(name: String) : Option[SymbolType] = (
        table.get(name)
    )

    def lookupFunction(name: String) : Option[SymbolType] = (
        functionTable.get(name)
    )

    def lookupRecursive(name: String) : Option[SymbolType] = {
        var symbolType = lookup(name)
        if (symbolType.isEmpty) {
            symbolType = parent match {
                case Some(table) => table.lookupRecursive(name)
                case None => None
            }
        }
        symbolType
    }

    def lookupRecursiveID(name: String) : (String, SymbolType) = lookup(name) match {
        case None => parent match {
            case Some(p) => p.lookupRecursiveID(name)
            case None => ("", NoReturn)
        }
        case Some(st) => {
            if (st.allocated){
                (unique_id + name, st)
            } else {
                parent match{
                    case Some(p) => {
                        p.lookupRecursiveID(name) match{
                            case ("", NoReturn) => {
                                st.allocated = true
                                (unique_id + name, st)
                            }
                            case a: Any => a
                        }
                    }
                    case None => {
                        st.allocated = true
                        (unique_id + name, st)
                    }
                }
            }
        }
    }

    def setAssignedId(name: String): Unit = lookup(name) match {
        case None => parent.get.setAssignedId(name)
        case Some(st) => {
            st.allocated = true
        } 
    }

    def lookupFunctionRecursive(name: String) : Option[SymbolType] = {
        var symbolType = lookupFunction(name)
        if (symbolType.isEmpty) {
            symbolType = parent match {
                case Some(table) => table.lookupFunctionRecursive(name)
                case _ => None
            }
        }
        symbolType
    }
}

object SymbolTypes {
    import abstractSyntaxTree._

    sealed trait SymbolType {
        var allocated: Boolean = false
    }

    // Ambiguous symbol refers to any symbol of unknown type
    object AmbiguousSymbol extends SymbolType with PairSymbol

    case object IntSymbol extends SymbolType
    case object BoolSymbol extends SymbolType
    case object CharSymbol extends SymbolType
    case object StringSymbol extends SymbolType
    case class ArraySymbol(t: SymbolType) extends SymbolType
    sealed trait PairSymbol extends SymbolType
    // Top pair symbol refers to a pair where we know that it is a pair, and we know the types of its elements
    case class TopPairSymbol(ft: SymbolType, st: SymbolType) extends PairSymbol
    // Pair literal symbol refers to a pair that we know for certain is a pair, but not the types of its elements
    case object PairLiteralSymbol extends PairSymbol
    // Nested pair symbol refers to an element inside a pair that may or may be any type
    case object NestedPairSymbol extends PairSymbol
    case class FunctionSymbol(returnType: SymbolType, argTypes: List[SymbolType]) extends SymbolType
    // NoReturn is a symbol that nothing can evalute to. It allows the analyzer to ensure that a sequence of statements doesn't return
    case object NoReturn extends SymbolType

    // Translates the AST types into the symbol table types
    def translate(t: Any) : SymbolType = t match {
            case IntT => IntSymbol
            case BoolT => BoolSymbol
            case CharT => CharSymbol 
            case StringT => StringSymbol
            case ArrayType(n) => ArraySymbol(translate(n))
            case PairType(fst, snd) => TopPairSymbol(translate(fst), translate(snd))
            case PairElemTypeT(n) => translate(n)
            case NestedPair => PairLiteralSymbol
        }

    // Dereferences array types by the given amount
    def derefType(t: SymbolType, layers: Int): SymbolType = if (layers == 0) {
        return t
    } else {
        t match{
            case ArraySymbol(n) => derefType(n, layers - 1)
            case default => throw new Exception("Tried to dereference a non-array type")
        }
    }
}
