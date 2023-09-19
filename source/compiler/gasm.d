module compiler.gasm;

import std.stdio : File, writeln;
import std.string;
import compiler.parser : Parser;

public class GasmCompiler
{
  private string pathIn;
  private string pathOut;
  private Parser parser;
  private bool verbose;

 this(string pathIn, string pathOut, bool verbose)
  {
    this.pathIn = pathIn;
    this.pathOut = pathOut;
    parser = new Parser();
    this.verbose = verbose;
  }

  this(string pathIn, string pathOut)
  {
    this.pathIn = pathIn;
    this.pathOut = pathOut;
    parser = new Parser();
    verbose = false;
  }

  this()
  {
    this.pathIn = null;
    this.pathOut = null;
    parser = new Parser();
    verbose = false;
  }

  this(bool verbose)
  {
    this.pathIn = null;
    this.pathOut = null;
    parser = new Parser();
    this.verbose = verbose;
  }

  public int read(string pathIn) 
  {
    auto file = File(pathIn);
    parser.parse(file);

    if(verbose) 
    {
      writeln("Comliled lines:", parser.getNumberOfLines);
      writeln("Get operations: ", parser.getNumberOfOperations);
    }
    
    auto lexer = parser.getLexer();
    auto ops = lexer.getOperations();

    if (verbose) {
      writeln("Builded operations:" );
      foreach (op; ops[])
      {
        writeln("Operation: ", op);
      }
    }
    
    return 1;
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