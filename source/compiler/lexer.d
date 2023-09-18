module compiler.lexer;

import std.stdio : writeln;
import std.container : DList;
import std.array : appender;

public struct Operation {
  char[] optCode;
  char[] value;
}

public class LineLexer {
  private DList!Operation operations;
  private ulong size;
  this()
  {
    operations = DList!Operation();
  }

  public void addOperation(ref char[] instruction, ref char[] value) {
    auto oper = Operation(instruction, value);
    operations.insertFront(oper);
    size++;
  }

  public ulong getSize()
  {
    return size; 
  }
}