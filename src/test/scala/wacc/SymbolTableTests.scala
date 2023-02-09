package wacc

import org.scalatest.flatspec.AnyFlatSpec

class SymbolTableTests extends AnyFlatSpec {
    import SymbolTypes._

    val st1 = new SymbolTable(None)
    val st2 = new SymbolTable(Some(st1))
    val st3 = new SymbolTable(Some(st2))
    val st4 = new SymbolTable(Some(st2))

    // Test if we can get something out of the symbol table
    st3.add("x", IntSymbol) 
    s"Symbol table " should s" be able to accurately store symbols" in {
        assert(st3.lookup("x") == Some(SymbolTypes.IntSymbol))
    }

    // Test that we can't get things that we haven't put in the symbol table yet
    s"Symbol table " should s" return None if it cannot find something" in {
        assert(st3.lookup("y") == None)
    }

    // Test that we can recursively find things in the symbol table
    st2.add("y", CharSymbol)
    s"Symbol table " should s" be able to recursively find symbols" in {
        assert(st3.lookupRecursive("y") == Some(SymbolTypes.CharSymbol))
    }

    // Test that we cannot find things in neighbouring children
    st4.add("z", CharSymbol)
    s"Symbol table " should s"not be able to find things in neighbouring children" in {
        assert(st3.lookupRecursive("z") == None)
    }

    // Test that we can reach more than one layer up
    st1.add("a", StringSymbol)
    s"Symbol table " should s" be able to recursively lookup over multiple levels" in {
        assert(st3.lookupRecursive("a") == Some(StringSymbol))
    }
}
