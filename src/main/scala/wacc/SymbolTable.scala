package wacc
import scala.collection.immutable.HashMap

class SymbolTable(val parent: Option[SymbolTable]) {
    import SymbolTypes._
    import abstractSyntaxTree._

    var table = new HashMap[String, SymbolType]();
    var functionTable = new HashMap[String, SymbolType]();

    def add(func: FunctionUnit) : Unit = (
        if (lookupFunction(func.id.id).isEmpty){
            functionTable = functionTable + (func.id.id -> FunctionSymbol(translate(func.t), func.params.paramlist.map(p => translate(p.t))))
        } else {
            throw new Error("Attempt to redefine a variable or function")
        }
    )

    def add(name: String, t: Type) : Unit = (
        add(name, translate(t))
    )

    def add(name: String, t: SymbolType) : Unit = (
        if (lookup(name).isEmpty){
            table = table + (name -> t)
        } else {
            throw new Error("Attempt to redefine a variable or function")
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

    sealed trait SymbolType

    object AmbiguousSymbol extends SymbolType with PairSymbol

    case object IntSymbol extends SymbolType
    case object BoolSymbol extends SymbolType
    case object CharSymbol extends SymbolType
    case object StringSymbol extends SymbolType
    case class ArraySymbol(t: SymbolType) extends SymbolType
    sealed trait PairSymbol extends SymbolType
    case class TopPairSymbol(ft: SymbolType, st: SymbolType) extends PairSymbol
    case object PairLiteralSymbol extends PairSymbol
    case object NestedPairSymbol extends PairSymbol
    case class FunctionSymbol(returnType: SymbolType, argTypes: List[SymbolType]) extends SymbolType
    case object NoReturn extends SymbolType

    def translate(t: Any) : SymbolType = t match {
            case IntT => IntSymbol
            case BoolT => BoolSymbol
            case CharT => CharSymbol 
            case StringT => StringSymbol
            case ArrayType(n) => ArraySymbol(translate(n))
            case PairType(fst, snd) => TopPairSymbol(translate(fst), translate(snd))
            case PairElemTypeT(n) => translate(n)
            case NestedPair => NestedPairSymbol
        }

    def derefType(t: SymbolType, layers: Int): SymbolType = if (layers == 0) {
        return t
    } else {
        t match{
            case ArraySymbol(n) => derefType(n, layers - 1)
            case default => throw new Exception("Tried to dereference a non-array type")
        }
    }
}
