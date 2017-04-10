module befunged.sourcestream;

import std.string;

enum Direction {
  UP,
  DOWN,
  RIGHT,
  LEFT
}

class SourceStream {
  Direction dir = Direction.RIGHT;
  char[][] source;
  size_t pcx,
         pcy;

  this (string code) {
    foreach (li, line; code.split("\n")) {
      source ~= cast(char[])line;
    }
  }

  void changeDirection(Direction dir) {
    this.dir = dir;
  }

  @property bool empty() {
    return false;// FIXME
  }

  @property char front() {
    return this.source[pcy][pcx];
  }

  @property void popFront() {
    final switch (this.dir) with (Direction) {
      case UP:
        if (pcy == 0) {
          pcy = this.source.length - 1;
        } else {
          pcy--;
        }
        break;
      case DOWN:
        if (pcy == this.source.length - 1) {
          pcy = 0;
        } else {
          pcy++;
        }
        break;
      case RIGHT:
        if (pcx == this.source[pcy].length - 1) {
          pcx = 0;
        } else {
          pcx++;
        }
        break;
      case LEFT:
        if (pcx == 0) {
          pcx = this.source[pcy].length - 1;
        } else {
          pcx--;
        }
        break;
    }
  }

  char getChar(int x, int y) {
    return this.source[y][x];
  }

  void changeChar(int x, int y, char z) {
    char[] line = this.source[y];
    char[] tmp;

    foreach (i, c; line) {
      if (i == x) {
        tmp ~= z;
      } else {
        tmp ~= c;
      }
    }

    this.source[y] = tmp;
  }
}
