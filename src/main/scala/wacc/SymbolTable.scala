package wacc
import scala.collection.immutable.HashMap

class SymbolTable(val parent: Option[SymbolTable]) {
    import SymbolTypes._
    import abstractSyntaxTree._

    var table = new HashMap[String, SymbolType]();

    def add(func: FunctionUnit) : Unit = {
        var paramSymbol : List[SymbolTable] = func match {
            case ParamFunc => func.params.paramlist.map(p => translate(p.t))
            case NiladicFunc => List[SymbolTypes]()
        }
        add(func.id.id, FunctionSymbol(translate(func.t), paramSymbol))
    }

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
}

object SymbolTypes {
    import abstractSyntaxTree._

    sealed trait SymbolType

    case object IntSymbol extends SymbolType
    case object BoolSymbol extends SymbolType
    case object CharSymbol extends SymbolType
    case object StringSymbol extends SymbolType
    case class ArraySymbol(t: SymbolType) extends SymbolType
    case class PairSymbol(ft: SymbolType, st: SymbolType) extends SymbolType
    case object NestedPairSymbol extends SymbolType
    case class FunctionSymbol(returnType: SymbolType, argTypes: List[SymbolType]) extends SymbolType
    case object AmbiguousSymbol extends SymbolTree
    case object NullSymbol extends SymbolTree

    def translate(t: Any) : SymbolType = t match {
            case IntT => IntSymbol
            case BoolT => BoolSymbol
            case CharT => CharSymbol 
            case StringT => StringSymbol
            case ArrayT => ArraySymbol(translate(t.t))
            case PairType => PairSymbol(translate(t.fst), translate(t.snd))
            case PairElemTypeT => translate(t.t)
            case NestedPair => NestedPairSymbol
        }
}
