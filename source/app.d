import std.stdio;
import jcli : CommandLineInterface, CommandDefault, ArgPositional;
import cli.commands;

int main(string[] args)
{
	auto executor = new CommandLineInterface!(cli.commands)();
	const statusCode = executor.parseAndExecute(args);

	writefln("Program exited with status code %s", statusCode);

	return 0;
}