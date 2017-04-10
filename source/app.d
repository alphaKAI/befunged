module app;
import befunged.interpreter;
import std.stdio,
       std.file;

void main(string[] args) {
  if (args.length >= 2) {
    string fpath = args[1];

    if (!exists(fpath)) {
      writeln("No such file - ", fpath);
    } else {
      Interpreter itpr = new Interpreter(readText(fpath));

      itpr.execute;
    }
  } else if (args.length == 1) {
    string code,
           line;

    while ((line = readln()) !is null) {
      code ~= line;
    }

    Interpreter itpr = new Interpreter(code);
    itpr.execute();
  } else {
    writeln("error"); // this error comment needs improving
  }
}
