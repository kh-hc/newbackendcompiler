package wacc

import wacc.{abstractSyntaxTree => ast}

// This follows the style of the AST and WACC Language spec - see those for further details

object PrettyPrinters {
    // Pretty prints the a WACCprogram line
    def prettyPrintFunction(functionLine : ast.FunctionUnit) : String = {
      prettyPrintType(functionLine.t) + " " +
      prettyPrintExpr(functionLine.id) + "(" + prettyPrintParamList(functionLine.params) +
      ") is\n" + prettyPrintStatement(functionLine.body) + "\nend"
    }

    def prettyPrintParamList(params : ast.ParamList) : String = {
      // ParamList : List[Type, Identifier]
      val abstractedParams = params.paramlist
      var parameterList = ""
      if (abstractedParams.length > 0) {
        val firstParam = abstractedParams(0)
        parameterList = prettyPrintParam(firstParam)
        for (p <- 1 to abstractedParams.length - 1) {
          val param = abstractedParams(p)
          parameterList = parameterList + ", " +  prettyPrintParam(param)
        }
      }
      return parameterList
    }

    def prettyPrintParam(param : ast.Param) : String = {
      prettyPrintType(param.t) + " " + prettyPrintExpr(param.id)
    }

    def prettyPrintStatement(statement : ast.StatementUnit) : String = statement match {
      case ast.SkipStat                   =>  "skip"
      case ast.AssignStat(t, id, value)   =>  {prettyPrintType(t) + " " +
                                              prettyPrintExpr(id) + " = " +
                                              prettyPrintRvalue(value)}
      case ast.ReassignStat(left, right)  =>  prettyPrintLValue(left) + " = " + prettyPrintRvalue(right)
      case ast.ReadStat(value)            =>  "read " + prettyPrintLValue(value)
      case ast.FreeStat(expr)             =>  "free " + prettyPrintExpr(expr)
      case ast.ReturnStat(expr)           =>  "return " + prettyPrintExpr(expr)
      case ast.ExitStat(expr)             =>  "exit " + prettyPrintExpr(expr)
      case ast.PrintStat(expr)            =>  "print " + prettyPrintExpr(expr)
      case ast.PrintlnStat(expr)          =>  "println " + prettyPrintExpr(expr) + "\n"
      case ast.IfStat(cond, ifStat, elseStat) => {"if\n" +
                                                  prettyPrintExpr(cond) +
                                                  "\nthen\n" +
                                                  prettyPrintStatement(ifStat) +
                                                  "\nelse\n" +
                                                  elseStat.fold {} {x => prettyPrintStatement(x)} +
                                                  "\nfi"}
      case ast.WhileStat(cond, body)      =>  {"while\n" +
                                                prettyPrintExpr(cond) +
                                                "\ndo\n" +
                                                prettyPrintStatement(body) + "\ndone"}
      case ast.ScopeStat(body)            => "begin\n" + prettyPrintStatement(body) + "\nend"
      case ast.SeqStat(statements)        =>  {
        var instruction = ""
        for (statement <- statements) {
          instruction = instruction + prettyPrintStatement(statement) + " ;"
        }
        // Remove the last semi-colon
        if (instruction.length > 0) {
          instruction = instruction.slice(0, instruction.length - 2)
        }
        return instruction
      }
    }

    def prettyPrintLValue(lValue : ast.Lvalue) : String = lValue match {
      case ast.Identifier(id)           => id
      case ast.ArrayElem(id, position)  => prettyPrintArrayElem(id, position)
      case ast.PairElemFst(pair)        => "fst " + prettyPrintLValue(pair)
      case ast.PairElemSnd(pair)        => "snd " + prettyPrintLValue(pair)
    }

    def prettyPrintPairElem(pairElem : ast.PairElem) : String = pairElem match {
      case ast.PairElemFst(pair) => "fst " + prettyPrintLValue(pair)
      case ast.PairElemSnd(pair) => "snd " + prettyPrintLValue(pair)
    }

    def prettyPrintRvalue(rValue : ast.Rvalue) : String = rValue match {
      case ast.ArrayLiteral(value)           =>  "[" + prettyPrintExprListWithCommas(value) + "]"
      case ast.NewPair(exprLeft, exprRight)  =>  {"newpair (" + prettyPrintExpr(exprLeft) +
                                                  ", " + prettyPrintExpr(exprRight) + ")"}
      case ast.PairElemFst(pair)             => "fst " + prettyPrintLValue(pair)
      case ast.PairElemSnd(pair)             => "snd " + prettyPrintLValue(pair)      
      case ast.Call(id, args)           => "call " + prettyPrintExpr(id) + "(" + prettyPrintExprListWithCommas(args.args) + ")"
      case default                           => prettyPrintExpr(rValue.asInstanceOf[ast.Expr])
    }

    def prettyPrintExprListWithCommas(list : List[ast.Expr]) : String = {
      var instruction = ""
      if (list.length > 0) {
        val firstArg = list(0)
        instruction = instruction + prettyPrintExpr(firstArg)
        for (l <- 1 to list.length - 1) {
          val expr = list(l)
          instruction = instruction + ", " + prettyPrintExpr(expr)
        } 
      }
      return instruction
    }

    def prettyPrintType(t : ast.Type) : String = t match {
      case ast.IntT                   => "int"
      case ast.BoolT                  => "bool"
      case ast.CharT                  => "char"
      case ast.StringT                => "string"
      case ast.ArrayType(arrayType)   => prettyPrintType(arrayType) + "[]"
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
      case ast.CharExpr(value)          => "\'" + value.toString + "\'"
      case ast.StrExpr(value)           => "\"" + value + "\""
      case ast.PairLiteral              => "null"
      case ast.ArrayElem(id, position)  => prettyPrintArrayElem(id, position)
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
  
    def prettyPrintArrayElem(id : ast.Identifier, position : List[ast.Expr]) : String = {
      var instruction = prettyPrintExpr(id)
      if (position.length > 0) {
        val firstExpr = position(0)
        instruction = instruction + "[" + prettyPrintExpr(firstExpr) + "]"
        for (l <- 1 to position.length - 1) {
          val expr = position(l)
          instruction = instruction + ", " + "[" + prettyPrintExpr(expr) + "]"
        } 
      }
      return instruction
    }

    def prettyPrintExprList(list : List[ast.Expr]) : String = {
      var instruction = ""
        for (expr <- list) {
          instruction = instruction + "[" + prettyPrintExpr(expr) + "]"
        }
        return instruction
    }
}