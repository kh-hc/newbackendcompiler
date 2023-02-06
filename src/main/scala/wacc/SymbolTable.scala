package wacc
import scala.collection.mutable.HashMap

object SymbolTypes {
    sealed trait SymbolType

    case object IntSymbol extends SymbolType
    case object BoolType extends SymbolType
    case object CharSymbol extends SymbolType
    case object StringSymbol extends SymbolType
    case class ArraySymbol(t: SymbolType) extends SymbolType
    case class PairSymbol(ft: SymbolType, st: SymbolType) extends SymbolType
    case class FunctionSymbol(t: ReturnType) extends SymbolType
}

class SymbolTable(val parent: Option[SymbolTable]) {

    var table = new HashMap();

    def add(name: String, t: SymbolType) : Unit = (
        table = table + (name -> t)
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
