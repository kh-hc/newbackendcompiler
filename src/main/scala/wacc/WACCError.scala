package wacc

import parsley.errors.ErrorBuilder
import parsley.errors.tokenextractors
import abstractSyntaxTree._
import SymbolTypes._

object WACCErrors {
    case class WACCError(pos: (Int, Int), file: String, lines: WACCErrorLines) {
        override def toString: String = {
            (s"${lines.errorType} error " +
             "in file: " + file + ", at line: " + pos._1 + ", column: " + pos._2 + "\n" +
             lines.errorLines.mkString("\n") + "\n" 
            )
        }
    }

    sealed trait WACCErrorLines {
        val errorType: String
        val errorLines: Seq[String]
    }
    case class SyntacticError(unexpected: Option[String], expecteds: Set[String], reasons: Set[String], lines: Seq[String]) extends WACCErrorLines {
        override val errorType: String = "Syntactic"
        override val errorLines: Seq[String] = Seq (
          "Unexpected value: " + unexpected.getOrElse("None") + "\n" +
          "Expected value set: " + expecteds.mkString(",") + "\nError lines: \n" + lines.mkString("\n")
        )
        override def toString: String = {
            "Unexpected value: " + unexpected.getOrElse("None") + "\n" +
            "Expected value set:     " + expecteds.mkString("\n") + "\nError lines: \n" + lines.mkString("\n")
        }
    }
    sealed trait SemanticError extends WACCErrorLines {
        override val errorType: String = "Semantic"
    }


    case class unexpectedType(unexpected: SymbolType, expected: SymbolType) extends SemanticError {
        override val errorLines: Seq[String] = Seq(s"| Type error. \n| Expected: ${expected}" +
                                                s"\n| Actual: $unexpected")
    }

    case class varAlreadyAss(id: Identifier) extends SemanticError {
        override val errorLines: Seq[String] = Seq(s"| Variable ${id.id} is already defined in this scope.")
    }

    case class ambiguousTypesReAss(s: StatementUnit, left: Lvalue, right: Rvalue) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Cannot reassign with ambiguous types on both sides,\n| left:" + 
                                                s"$left, and right: $right")
    }

    case class readError(lval: Lvalue, typeRec: SymbolType) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Cannot read values of type: $typeRec. Please supply an int or char.")
    }

    case class freeError(expr: Expr, typeRec: SymbolType) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Tried to free expression of type: $typeRec, can only free values of type pair and array.")
    }

    case class returnError(expr: Expr) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Attempt to return from program body.")
    }

    case class undefinedVar(varId: Identifier) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Variable $varId not defined.")
    }

    case class valNotExists(id: Identifier) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Value $id does not exist.")
    }

    case class derefErr(lval: Lvalue, t: SymbolType) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Tried to dereference something of type $t, but can only dereference things of type pair.")
    }

    case class derefErrE(e: Expr) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Invalid dereferencing of array.")
    }

    case class arrayTypeErr(rval: Rvalue, t: SymbolType) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Array expects values of type $t, but has values of different types.")
    }

    case class undefFunc(id: Identifier) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Function $id is not defined.")
    }

    case class argumentMismatch(id: Identifier) extends SemanticError {
      override val errorLines: Seq[String] = Seq(s"| Arguments provided do not match those expected.")
    }

    object unexpectedTypeStat {
      def err(s: StatementUnit, unexpected: SymbolType, expecteds: SymbolType)(implicit file: String): WACCError = {
        WACCError(s.pos, file, unexpectedType(unexpected, expecteds))
      }
    }

    object unexpectedTypeExpr {
      def err(e: Expr, unexpected: SymbolType, expecteds: SymbolType)(implicit file: String): WACCError = {
        WACCError(e.pos, file, unexpectedType(unexpected, expecteds))
      }
    }

    object varAlreadyAss {
      def err(id: Identifier)(implicit file: String): WACCError = {
        WACCError(id.pos, file, varAlreadyAss(id))
      }
    }

    object ambiguousTypesReAss {
      def err(s: StatementUnit, left: Lvalue, right: Rvalue)(implicit file: String): WACCError = {
        WACCError(s.pos, file, ambiguousTypesReAss(s, left, right))
      }
    }

    object readError {
      def err(lval: Lvalue, typeRec: SymbolType)(implicit file: String): WACCError = {
        WACCError(lval.pos, file, readError(lval, typeRec))
      }
    }

    object freeError {
      def err(expr: Expr, typeRec: SymbolType)(implicit file: String): WACCError = {
        WACCError(expr.pos, file, freeError(expr, typeRec))
      }
    }

    object returnError {
      def err(expr: Expr)(implicit file: String): WACCError = {
        WACCError(expr.pos, file, returnError(expr))
      }
    }

    object undefinedVar {
      def err(varId: Identifier)(implicit file: String): WACCError = {
        WACCError(varId.pos, file, undefinedVar(varId))
      }
    }

    object valNotExists {
      def err(id: Identifier)(implicit file: String): WACCError = {
        WACCError(id.pos, file, valNotExists(id))
      }
    }

    object derefErr {
      def err(lval: Lvalue, t: SymbolType)(implicit file: String): WACCError =  {
        WACCError(lval.pos, file, derefErr(lval, t))
      }
    }

    object derefErrE {
      def err(e: Expr)(implicit file: String): WACCError = {
        WACCError(e.pos, file, derefErrE(e))
      }
    }

    object arrayTypeErr {
      def err(rval:  Rvalue, t: SymbolType)(implicit file: String): WACCError = {
        WACCError(rval.pos, file, arrayTypeErr(rval, t))
      }
    }

    object undefFunc {
      def err(id: Identifier)(implicit file: String): WACCError = {
        WACCError(id.pos, file, undefFunc(id))
      }
    }

    object argumentMismatch {
      def err(id: Identifier)(implicit file: String): WACCError = {
        WACCError(id.pos, file, argumentMismatch(id))
      }
    }

    class WACCErrorBuilder extends ErrorBuilder[WACCError] with tokenextractors.TillNextWhitespace {

      override def trimToParserDemand: Boolean = false

      type Position = (Int, Int)
      type ErrorInfoLines = WACCErrorLines
      type Source = Option[String]
      type ExpectedLine = Set[String]
      type UnexpectedLine = Option[String]
      type Messages = Set[String]
      type Message =  String
      type LineInfo = Seq[String]
      type Item = String
      type ExpectedItems = Set[String]
      type Raw  = String
      type Named = String
      type EndOfInput = String


      override def format(pos: Position, source: Source, lines: ErrorInfoLines): WACCError = WACCError((pos._1, pos._2), source.getOrElse(""), lines)

      override def pos(line: Int, col: Int): Position = (line, col)

      override def source(sourceName: Option[String]): Source = sourceName.map(name => s"$name")

      override def vanillaError(unexpected: UnexpectedLine, expected: ExpectedLine, reasons: Messages, line: LineInfo): ErrorInfoLines = 
        SyntacticError(unexpected, expected, reasons, line)

      override def specialisedError(msgs: Messages, line: LineInfo): ErrorInfoLines = 
        SyntacticError(None, Set.empty, msgs, line)

      override def combineExpectedItems(alts: Set[Item]): ExpectedItems = alts

      override def combineMessages(alts: Seq[Message]): Messages = alts.toSet

      override def unexpected(item: Option[Item]): UnexpectedLine = item

      override def expected(alts: ExpectedItems): ExpectedLine = alts

      override def reason(reason: String): Message = reason

      override def message(msg: String): Message = msg

      override def lineInfo(line: String, linesBefore: Seq[String], linesAfter: Seq[String], errorPointsAt: Int, errorWidth: Int): LineInfo = {
        linesBefore.map(line => s"$errorLineStart$line") ++:
        Seq(s"$errorLineStart$line", s"$errorLineStart${" " * (errorLineStart.length - 2)}${errorPointer(errorPointsAt, errorWidth)}") ++:
        linesAfter.map(line => s"$errorLineStart$line")
      }

      private val errorLineStart = "| "
      private def errorPointer(caretAt: Int, caretWidth: Int) = s"${" " * caretAt}${"^" * caretWidth}"

      override val numLinesBefore: Int = 1

      override val numLinesAfter: Int = 1

      override def raw(item: String): Raw = item

      override def named(item: String): Named = item

      override val endOfInput: EndOfInput = "end of input"

    }
}
