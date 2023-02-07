package wacc

import parsley.errors.ErrorBuilder
import parsley.errors.tokenextractors

object WACCErrors {
    case class WACCError(pos: (Int, Int), file: String, lines: WACCErrorLines) {
        override def toString: String = {
            ("Error type: " + lines.errorType + "\n" +
             "In file: " + file + ", at position: " + pos + "\n" +
             lines + "\n"
            )
        }
    }

    sealed trait WACCErrorLines {
        val errorType: String
        val errorLines: Seq[String]
    }
    case class SyntacticError(unexpected: Option[String], expecteds: Set[String], reasons: Set[String], lines: Seq[String]) extends WACCErrorLines {
        override val errorType: String = "Syntactic"
        override val errorLines: Seq[String] = lines
        override def toString: String = {
            "Unexpected value: " + unexpected.getOrElse("None") + "\n" +
            "Expected value set:     " + expecteds.mkString("\n") + "\nReasons: \n" +
            reasons.mkString("\n") + "\nError lines: \n" + lines.mkString("\n")
        }
    }
    sealed trait SemanticError extends WACCErrorLines {
        override val errorType: String = "Semantic"
    }

    class WACCErrorBuilder extends ErrorBuilder[WACCError] with tokenextractors.MatchParserDemand {
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

      override def source(sourceName: Option[String]): Source = sourceName.map(name => s"file '$name'")

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
        Seq(s"$errorLineStart$line", s"${" " * errorLineStart.length}${errorPointer(errorPointsAt, errorWidth)}") ++:
        linesAfter.map(line => s"$errorLineStart$line")
      }

      private val errorLineStart = ">"
      private def errorPointer(caretAt: Int, caretWidth: Int) = s"${" " * caretAt}${"^" * caretWidth}"

      override val numLinesBefore: Int = 1

      override val numLinesAfter: Int = 1

      override def raw(item: String): Raw = item

      override def named(item: String): Named = item

      override val endOfInput: EndOfInput = "end of input"

    }
}
