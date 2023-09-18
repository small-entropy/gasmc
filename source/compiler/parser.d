module compiler.parser;

import compiler.lexer : LineLexer;
import compiler.symbols : ReservedSymbols;
import std.array : appender;
import std.stdio : writeln, File;

public class Parser 
{
  private ulong numberOfLines;
  private ulong numberOfOperations;
  private LineLexer lineLexer;

  this()
  {
    numberOfLines = 0;
    numberOfOperations = 0;
    lineLexer = new LineLexer();
  }

  private void parseLine(char[]* line) {
    char[] instruction;
    char[] value;

    auto iapp = appender(&instruction);
    auto vapp = appender(&value);
    foreach (ch; *line)
    {
      if (ch ==  ReservedSymbols.Comment) {
        break;
      }
      else
      {
        if (ch == ReservedSymbols.Space) {
          iapp.put(ch);
        }
        else
        {
          if (ch != ReservedSymbols.Carret) {
            vapp.put(ch);
          }
        }
      }
    }
    lineLexer.addOperation(instruction, value);
    numberOfLines++;
    numberOfOperations = lineLexer.getSize();
  }

  public void parse(File* file) {
    auto range = file.byLine();
    foreach (line; range)
    {
      parseLine(&line);
    }
  }

  public ulong getNumberOfOperations()
  {
    return numberOfOperations;
  }

  public ulong getNumberOfLines() 
  {
    return numberOfLines;
  }
}