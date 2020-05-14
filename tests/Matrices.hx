@:asserts
class Matrices {
  public function new() {}
  public function equality() {
    var p = new Point(0, 1),
        m = Matrix.IDENTITY;

    asserts.assert(m == m);
    asserts.assert(m != m + p);
    asserts.assert(m == -p + m + p);

    return asserts.done();
  }
}