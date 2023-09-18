module compiler.gasm;

import std.stdio : File, writeln;
import std.string;
import compiler.parser : Parser;

public class GasmCompiler {
  private string pathIn;
  private string pathOut;
  private Parser parser;

  this(string pathIn, string pathOut)
  {
    this.pathIn = pathIn;
    this.pathOut = pathOut;
    parser = new Parser();
  }

  this()
  {
    this.pathIn = null;
    this.pathOut = null;
    parser = new Parser();
  }

  public void read() {
    auto file = File(pathIn);
    parser.parse(file);
  }

  @safe public void setPathIn(string pathIn) 
  {
    this.pathIn = pathIn;
  }

  @safe public void setPathOut(string pathOut)
  {
    this.pathOut = pathOut;
  }

  @safe public string* getPathIn()
  {
    return &pathIn;
  }

  @safe public string* getPathOut()
  {
    return &pathOut;
  }
}