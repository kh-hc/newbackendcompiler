package wacc

import wacc.{abstractSyntaxTree => ast}

object PrettyPrinters {
    // Pretty prints the a WACCprogram line
    def prettyPrintFunction(functionLine : ast.FunctionUnit) : String = functionLine match {
      case ast.ParamFunc(t, id, params, body) => {prettyPrintType(t) + " " +
                                                  prettyPrintExpr(id, false) + "(" +
                                                  prettyPrintParams(params) + ") is\n" +
                                                  prettyPrintStatement(body) + "\nend"}
      case ast.NiladicFunc(t, id, body)       => {prettyPrintType(t) + " " +
                                                  prettyPrintExpr(id, false) + "() is\n" +
                                                  prettyPrintStatement(body) + "\nend"}
    }

    def prettyPrintParams(params : ast.ParamList) : String = {
      // ParamList : List[Type, Identifier]
      val abstractedParams = params.paramlist
      var parameterList = ""
      if (abstractedParams.length > 0) {
        val firstParam = abstractedParams(0)
        parameterList = prettyPrintType(firstParam.t) + " " + prettyPrintExpr(firstParam.id, false)
        for (p <- 1 to abstractedParams.length - 1) {
          val param = abstractedParams(p)
          val t = param.t
          val id = param.id
          val paramInfo = prettyPrintType(t) + " " + prettyPrintExpr(id, false)
          parameterList = parameterList + ", " + paramInfo
        }
      }
      return parameterList
    }

    def prettyPrintStatement(statement : ast.StatementUnit) : String = statement match {
      case ast.SkipStat                   =>  "skip"
      case ast.AssignStat(t, id, value)   =>  {prettyPrintType(t) + " " +
                                              prettyPrintExpr(id, false) + " = " +
                                              prettyPrintRvalue(value)}
      case ast.ReassignStat(left, right)  =>  prettyPrintLValue(left) + " = " + prettyPrintRvalue(right)
      case ast.ReadStat(value)            =>  "read " + prettyPrintLValue(value)
      case ast.FreeStat(expr)             =>  "free " + prettyPrintExpr(expr, false)
      case ast.ReturnStat(expr)           =>  "return " + prettyPrintExpr(expr, false)
      case ast.ExitStat(expr)             =>  "exit " + prettyPrintExpr(expr, false)
      // Note that if a char is printed, it should be '' instead of """"
      case ast.PrintStat(expr)            =>  "print " + prettyPrintExpr(expr, true)
      case ast.PrintlnStat(expr)          =>  "println " + prettyPrintExpr(expr, true) + "\n"
      case ast.IfStat(cond, ifStat, elseStat) => {"if\n" +
                                                  prettyPrintExpr(cond, false) +
                                                  "\nthen\n" +
                                                  prettyPrintStatement(ifStat) +
                                                  "\nelse\n" +
                                                  prettyPrintStatement(elseStat) +
                                                  "\nfi"}
      case ast.WhileStat(cond, body)      =>  {"while\n" +
                                                prettyPrintExpr(cond, false) +
                                                "\ndo\n" +
                                                prettyPrintStatement(body) + "\ndone"}
      case ast.ScopeStat(body)            => "begin\n" + prettyPrintStatement(body) +  "\nend"
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
      case ast.ArrayElem(id, position)  => prettyPrintExpr(id, false) + "[" + prettyPrintExprList(position) + "]"
      case ast.PairElemFst(pair)        => "fst " + prettyPrintLValue(pair)
      case ast.PairElemSnd(pair)        => "snd " + prettyPrintLValue(pair)
    }

    def prettyPrintPairElem(pairElem : ast.PairElem) : String = pairElem match {
      case ast.PairElemFst(pair) => prettyPrintLValue(pair)
      case ast.PairElemSnd(pair) => prettyPrintLValue(pair)
    }

    def prettyPrintRvalue(rValue : ast.Rvalue) : String = rValue match {
      case ast.ArrayLiteral(value)           =>  prettyPrintExprList(value)
      case ast.NewPair(exprLeft, exprRight)  =>  {"newpair (" + prettyPrintExpr(exprLeft, false) +
                                                  ", " + prettyPrintExpr(exprRight, false) + ")"}
      case ast.ParamCall(id, args)           => {
        val arguments = args.args
        var instruction = "" 
        if (arguments.length > 0) {
          val firstArg = arguments(0)
          instruction = instruction + prettyPrintExpr(firstArg, false)
          for (l <- 1 to arguments.length - 1) {
            val expr = arguments(l)
            instruction = instruction + ", " + prettyPrintExpr(expr, false)
          } 
        }
        return "call " + prettyPrintExpr(id, false) + "(" + instruction + ")"
      }
      case ast.NiladicCall(id)               => "call " + prettyPrintExpr(id, false) + "()"
      case ast.PairElemFst(pair)             => "fst " + prettyPrintLValue(pair)
      case ast.PairElemSnd(pair)             => "snd " + prettyPrintLValue(pair)
      case default                           => prettyPrintExpr(rValue.asInstanceOf[ast.Expr], false)
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

    def prettyPrintExpr(expr : ast.Expr, toPrint : Boolean) : String = expr match {
        case ast.IntExpr(value)           => value.toString
        case ast.BoolExpr(value)          => value.toString
        case ast.CharExpr(value)          => {
          var char = value.toString
          if (toPrint) {
            char = "\'" + value.toString + "\'"
          }
          return char
        }
        case ast.StrExpr(value)           => {
          var str = value
          if (toPrint) {
            str = "\"" + str.toString + "\""
          }
          return str
        }
        case ast.PairLiteral              => "null"
        case ast.ArrayElem(id, position)  => prettyPrintExpr(id, toPrint) + prettyPrintExprList(position)
        case ast.ParenExpr(expr)          => "(" + prettyPrintExpr(expr, toPrint) + ")"
        case ast.Identifier(id)           => id
        
        // Unary Operators
        case ast.NotOp(expr)      =>  "!" + prettyPrintExpr(expr, toPrint)
        case ast.NegateOp(expr)   =>  "-" + prettyPrintExpr(expr, toPrint)
        case ast.LenOp(expr)      =>  "len " + prettyPrintExpr(expr, toPrint)
        case ast.OrdOp(expr)      =>  "ord " + prettyPrintExpr(expr, toPrint)
        case ast.ChrOp(expr)      =>  "chr " + prettyPrintExpr(expr, toPrint)

        // Binary Operators
        case ast.Div(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft, toPrint) + " / " + prettyPrintExpr(exprRight, toPrint)
        case ast.Mod(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft, toPrint) + " % " + prettyPrintExpr(exprRight, toPrint)
        case ast.Mul(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft, toPrint) + "* " + prettyPrintExpr(exprRight, toPrint)
        case ast.Add(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft, toPrint) + " + " + prettyPrintExpr(exprRight, toPrint)
        case ast.Sub(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft, toPrint) + " - " + prettyPrintExpr(exprRight, toPrint)
        case ast.GreaterThan(exprLeft, exprRight)         =>  prettyPrintExpr(exprLeft, toPrint) + " > " + prettyPrintExpr(exprRight, toPrint)
        case ast.GreaterOrEqualThan(exprLeft, exprRight)  =>  prettyPrintExpr(exprLeft, toPrint) + " >= " + prettyPrintExpr(exprRight, toPrint)
        case ast.LessThan(exprLeft, exprRight)            =>  prettyPrintExpr(exprLeft, toPrint) + " < " + prettyPrintExpr(exprRight, toPrint)
        case ast.LessOrEqualThan(exprLeft, exprRight)     =>  prettyPrintExpr(exprLeft, toPrint) + " <= " + prettyPrintExpr(exprRight, toPrint)
        case ast.Equal(exprLeft, exprRight)               =>  prettyPrintExpr(exprLeft, toPrint) + " == " + prettyPrintExpr(exprRight, toPrint)
        case ast.NotEqual(exprLeft, exprRight)            =>  prettyPrintExpr(exprLeft, toPrint) + " != " + prettyPrintExpr(exprRight, toPrint)
        case ast.And(exprLeft, exprRight)                 =>  prettyPrintExpr(exprLeft, toPrint) + " && " + prettyPrintExpr(exprRight, toPrint)
        case ast.Or(exprLeft, exprRight)                  =>  prettyPrintExpr(exprLeft, toPrint) + " || " + prettyPrintExpr(exprRight, toPrint)
      }


    def prettyPrintExprList(list : List[ast.Expr]) : String = {
      var instruction = ""
        for (expr <- list) {
          instruction = instruction + "[" + prettyPrintExpr(expr, false) + "]"
        }
        return instruction
    }

    // If the next keyword is "end", the line shouldn't end with a semicolon
    // def endTheStatement(statement : String) : String = {
    //   var updatedStatement = statement
    //   if (statement.charAt(statement.length - 1) == ';') {
    //     updatedStatement = updatedStatement.slice(0, updatedStatement.length - 2)
    //   }
    //   return updatedStatement + "\nend"
    // }

}