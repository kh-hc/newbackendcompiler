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
    sealed trait PairSymbol extends SymbolType
    case class TopPairSymbol(ft: SymbolType, st: SymbolType) extends PairSymbol
    case object PairObjSymbol extends PairSymbol
    case class FunctionSymbol(returnType: SymbolType, argTypes: List[SymbolType]) extends SymbolType
    case object AmbiguousSymbol extends SymbolType
    case object NoReturn extends SymbolTree

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

    def getBaseType(t: SymbolType): SymbolType = t match{
        case ArraySymbol(t) => getBaseType(t.t)
        case baseType => baseType
    }
}
