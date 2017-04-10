module app;
import befunged.interpreter;

void main() {
  string src = 
`5 100p:v
v *g00:_00g.@
>00p1-:^`;

  Interpreter itpr = new Interpreter(src);

  itpr.execute;
}
