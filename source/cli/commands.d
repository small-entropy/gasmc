module cli.commands;
import std.stdio : writeln;
import jcli : CommandDefault, Command, ArgPositional;
import compiler.gasm : GasmCompiler;

@CommandDefault("The default command.")
struct DefaultCommand
{
    int onExecute()
    {
        writeln("Default command");
        return 1;
    }
}

@Command("build", "The build bytecode command.")
struct BuildCommand
{
    @ArgPositional
    string pathIn;

    @ArgPositional
    string pathOut;

    int onExecute()
    {
        auto gc = new GasmCompiler();
        int statusCode = gc.read(pathIn);
        return statusCode;
    }
}

@Command("vbuild", "The build bytecode command.")
struct VerboseBuildCommand
{
    @ArgPositional
    string pathIn; 

    @ArgPositional
    string pathOut;

    int onExecute()
    {
        writeln("Run build .gasm to bytecode");
        writeln("Path to input file: ", pathIn);
        writeln("Path to output file: ", pathOut);
        auto gc = new GasmCompiler(true);
        int statusCode = gc.read(pathIn);
        return statusCode;
    }
}