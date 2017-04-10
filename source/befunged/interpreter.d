module befunged.interpreter;
import befunged.sourcestream,
       befunged.stack;

import std.random,
       std.string,
       std.stdio,
       std.regex,
       std.conv;

auto nrgx = ctRegex!"[0-9]";

class Interpreter {
  SourceStream ss;
  Stack!int stack;

  bool exit_flag;
  bool read_string;
  bool skip_flag;

  this (string code) {
    this.ss = new SourceStream(code);
  }

  void execute() {
    foreach (ch; this.ss) {
      if (exit_flag) {
        break;
      }

      if (this.skip_flag) {
        this.skip_flag = false;

        continue;
      }

      if (ch != '"' && this.read_string) {
        this.stack.push(ch.to!int);

        continue;
      }

      switch (ch) {
        case '<':
          this.ss.changeDirection(Direction.LEFT);

          continue;
        case '>':
          this.ss.changeDirection(Direction.RIGHT);

          continue;
        case '^':
          this.ss.changeDirection(Direction.UP);

          continue;
        case 'v':
          this.ss.changeDirection(Direction.DOWN);

          continue;
        case '_':
          int x = this.stack.pop;
          Direction dir;

          if (x == 0) {
            dir = Direction.RIGHT;
          } else {
            dir = Direction.LEFT;
          }

          this.ss.changeDirection(dir);

          continue;
        case '|':
          int x = this.stack.pop;
          Direction dir;

          if (x == 0) {
            dir = Direction.DOWN;
          } else {
            dir = Direction.UP;
          }

          this.ss.changeDirection(dir);

          continue;
        case '?':
          Direction dir = cast(Direction)uniform(0, 5);

          this.ss.changeDirection(dir);

          continue;
        case ' ':
          continue;
        case '#':
          this.skip_flag = true;

          continue;
        case '@':
          this.exit_flag = true;

          continue;
        case '"':
          this.read_string = !this.read_string;

          continue;
        case '&':
          int x = readln.chomp.to!int;

          this.stack.push(x);

          continue;
        case '~':
          char x = readln.chomp.to!char;

          this.stack.push(x.to!int);

          continue;
        case '.':
          int x = this.stack.pop;

          writef("%d ", x);

          continue;
        case ',':
          int x = this.stack.pop;

          writef("%c", cast(char)x);

          continue;
        case '+':
          int y = this.stack.pop,
              x = this.stack.pop;
          int z = x + y;

          this.stack.push(z);

          continue;
        case '-':
          int y = this.stack.pop,
              x = this.stack.pop;
          int z = x - y;

          this.stack.push(z);

          continue;
        case '*':
          int y = this.stack.pop,
              x = this.stack.pop;
          int z = x * y;

          this.stack.push(z);

          continue;
        case '/':
          int y = this.stack.pop,
              x = this.stack.pop;
          int z = x / y;

          this.stack.push(z);

          continue;
        case '%':
          int y = this.stack.pop,
              x = this.stack.pop;
          int z = x % y;

          this.stack.push(z);

          continue;
        case '`':
          int y = this.stack.pop,
              x = this.stack.pop;
          int z = x > y ? 1 : 0;

          this.stack.push(z);

          continue;
        case '!':
          int x = this.stack.pop;
          int y;

          if (x == 0) {
            y = 1;
          } else {
            y = 0;
          }

          this.stack.push(y);

          continue;
        case ':':
          int x = this.stack.pop;

          this.stack.push(x);
          this.stack.push(x);

          continue;
        case '\\':
          int y = this.stack.pop,
              x = this.stack.pop;

          foreach (z; [y, x]) {
            this.stack.push(z);
          }

          continue;
        case '$':
          this.stack.pop;

          continue;
        case 'g':
          int y = this.stack.pop,
              x = this.stack.pop;
          char c = this.ss.getChar(x, y);

          this.stack.push(cast(int)c);

          continue;
        case 'p':
          int y = this.stack.pop,
              x = this.stack.pop,
              v = this.stack.pop;

          this.ss.changeChar(x, y, cast(char)v);

          continue;
        default:
          if (ch.to!string.match(nrgx)) {
            this.stack.push(ch.to!string.to!int);

            continue;
          }
      }
    }
  }
}
