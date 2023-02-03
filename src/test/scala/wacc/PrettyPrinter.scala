package wacc

import wacc.{abstractSyntaxTree => ast}

object PrettyPrinters {
    // Pretty prints the a WACCprogram line
    def prettyPrintFunction(functionLine : ast.FunctionUnit) : String = functionLine match {
      case ast.ParamFunc(t, id, params, body) => {prettyPrintType(t) + " " +
                                                  prettyPrintExpr(id) + "(" +
                                                  prettyPrintParams(params) + ") is\n\t" +
                                                  prettyPrintStatement(body) + "\nend"}
      case ast.NiladicFunc(t, id, body)       => {prettyPrintType(t) + " " +
                                                  prettyPrintExpr(id) + "()" +
                                                  prettyPrintStatement(body) + "\nend"}
    }

    def prettyPrintParams(params : ast.ParamList) : String = {
      // ParamList : List[Type, Identifier]
      var parameterList = ""
      val abstractedParams = params.paramlist
      for (p <- abstractedParams) {
        val t = p.t
        val id = p.id
        val paramInfo = prettyPrintType(t) + " " + prettyPrintExpr(id)
        parameterList = parameterList + ", " + paramInfo
      }
      return parameterList
    }

    def prettyPrintStatement(statement : ast.StatementUnit) : String = statement match {
      case ast.SkipStat                   =>  "skip"
      case ast.AssignStat(t, id, value)   =>  {prettyPrintType(t) + " " +
                                              prettyPrintExpr(id) + " = " +
                                              value.toString}
      case ast.ReassignStat(left, right)  =>  left.toString + " = " + right.toString
      case ast.ReadStat(value)            =>  "read " + value.toString + " ;"
      case ast.FreeStat(expr)             =>  "free " + prettyPrintExpr(expr)
      case ast.ReturnStat(expr)           =>  "return " + prettyPrintExpr(expr)
      case ast.ExitStat(expr)             =>  "exit " + prettyPrintExpr(expr)
      case ast.PrintStat(expr)            =>  "print " + prettyPrintExpr(expr) + " ;"
      case ast.PrintlnStat(expr)          =>  "print " + prettyPrintExpr(expr) + " ;\n"
      case ast.IfStat(cond, ifStat, elseStat) => {"if\n" +
                                                  prettyPrintExpr(cond) +
                                                  "\nthen\n\t" +
                                                  prettyPrintStatement(ifStat) +
                                                  "\nelse\n\t" +
                                                  prettyPrintStatement(ifStat) +
                                                  "fi"}
      case ast.WhileStat(cond, body)      =>  {"while\n" +
                                                prettyPrintExpr(cond) +
                                                "\ndo\n\t" +
                                                prettyPrintStatement(body) + "\ndone"}
      case ast.ScopeStat(body)            => "begin\n\t" + prettyPrintStatement(body) + "\nend"
      case ast.SeqStat(statements)        =>  {
        var instruction = ""
        for (statement <- statements) {
          instruction = prettyPrintStatement(statement) + " ;"
        }
        return instruction
      }
    }

    def prettyPrintLValue(lValue : ast.Lvalue) : String = lValue match {
      case ast.Identifier(id)           => id
      case ast.ArrayElem(id, position)  => prettyPrintExpr(id) + "[" + prettyPrintExprList(position) + "]"
      case ast.PairElemFst(pair)        => "fst " + prettyPrintLValue(pair)
      case ast.PairElemSnd(pair)        => "snd " + prettyPrintLValue(pair)
    }

    def prettyPrintPairElem(pairElem : ast.PairElem) : String = pairElem match {
      case ast.PairElemFst(pair) => prettyPrintLValue(pair)
      case ast.PairElemSnd(pair) => prettyPrintLValue(pair)
    }

    def prettyPrintRvalue(rValue : ast.Rvalue) : String = rValue match {
      case ast.ArrayLiteral(value)           =>  prettyPrintExprList(value)
      case ast.NewPair(exprLeft, exprRight)  =>  {"newpair (" + prettyPrintExpr(exprLeft) +
                                                  ", " + prettyPrintExpr(exprRight)}
      case ast.ParamCall(id, args)           => {"call " + prettyPrintExpr(id) +
                                                "(" + prettyPrintExprList(args.args) + ")"}
      case ast.NiladicCall(id)               => "call " + prettyPrintExpr(id) + "()"
      case default                           => prettyPrintExpr(rValue.asInstanceOf[ast.Expr])
    }

    def prettyPrintType(t : ast.Type) : String = t match {
      case ast.IntT                   => "int"
      case ast.BoolT                  => "bool"
      case ast.CharT                  => "char"
      case ast.StringT                => "string"
      case ast.ArrayType(arrayType)   => prettyPrintType(arrayType)
      case ast.PairType(left, right)  => {"pair (" + prettyPrintPairElemType(left) +
                                          ", " + prettyPrintPairElemType(right) + ")"}
    }

    def prettyPrintPairElemType(pairElemType : ast.PairElemType) : String = pairElemType match {
      case ast.PairElemTypeT(t) => prettyPrintType(t)
      case ast.NestedPair       => "pair"
    }

    def prettyPrintExpr(expr : ast.Expr) : String = expr match {
      case ast.IntExpr(value)           => value.toString
      case ast.BoolExpr(value)          => value.toString
      case ast.CharExpr(value)          => value.toString
      case ast.StrExpr(value)           => value.toString
      case ast.PairLiteral              => "null"
      case ast.ArrayElem(id, position)  => prettyPrintExpr(id) + prettyPrintExprList(position)
      case ast.ParenExpr(expr)          => "(" + prettyPrintExpr(expr) + ")"
      case ast.Identifier(id)           => id
      
      // Unary Operators
      case ast.NotOp(expr)      =>  "!" + prettyPrintExpr(expr)
      case ast.NegateOp(expr)   =>  "-" + prettyPrintExpr(expr)
      case ast.LenOp(expr)      =>  "len " + prettyPrintExpr(expr)
      case ast.OrdOp(expr)      =>  "ord " + prettyPrintExpr(expr)
      case ast.ChrOp(expr)      =>  "chr " + prettyPrintExpr(expr)

      // Binary Operators
      case ast.Div(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft) + " / " + prettyPrintExpr(exprRight)
      case ast.Mod(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft) + " % " + prettyPrintExpr(exprRight)
      case ast.Mul(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft) + "* " + prettyPrintExpr(exprRight)
      case ast.Add(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft) + " + " + prettyPrintExpr(exprRight)
      case ast.Sub(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft) + " - " + prettyPrintExpr(exprRight)
      case ast.GreaterThan(exprLeft, exprRight)         =>  prettyPrintExpr(exprLeft) + " > " + prettyPrintExpr(exprRight)
      case ast.GreaterOrEqualThan(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft) + " >= " + prettyPrintExpr(exprRight)
      case ast.LessThan(exprLeft, exprRight)            =>  prettyPrintExpr(exprLeft) + " < " + prettyPrintExpr(exprRight)
      case ast.LessOrEqualThan(exprLeft, exprRight)     =>  prettyPrintExpr(exprLeft) + " <= " + prettyPrintExpr(exprRight)
      case ast.Equal(exprLeft, exprRight)               =>  prettyPrintExpr(exprLeft) + " == " + prettyPrintExpr(exprRight)
      case ast.NotEqual(exprLeft, exprRight)            =>  prettyPrintExpr(exprLeft) + " != " + prettyPrintExpr(exprRight)
      case ast.And(exprLeft, exprRight)                 =>  prettyPrintExpr(exprLeft) + " && " + prettyPrintExpr(exprRight)
      case ast.Or(exprLeft, exprRight)                  =>  prettyPrintExpr(exprLeft) + " || " + prettyPrintExpr(exprRight)
    }


    def prettyPrintExprList(list : List[ast.Expr]) : String = {
      var instruction = ""
        for (expr <- list) {
          instruction = instruction + "[" + prettyPrintExpr(expr) + "]"
        }
        return instruction
    }

}