module befunged.stack;
import std.exception,
       std.array,
       std.range;

// Need to be tuned
struct Stack(T) {
  private T[] stack;

  @property T pop() {
    T t = stack[$ - 1];
    stack.length--;
    return t;
  }
  
  @property size_t length() {
    return stack.length;
  }

  @property void push(T value) {
    stack ~= value;
  }

  @property bool empty() {
    return stack.empty;
  }

  @property T front() {
    return pop;
  }

  @property void popFront() {
    pop;
  }

  @property void popAll() {
    foreach (_; this) {}
  }
}
