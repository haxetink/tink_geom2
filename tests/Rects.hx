@:asserts
class Rects {
  public function new() {}

  public function equality() {
    var r = new Rect(0...10, 0...20);

    asserts.assert(r == r);
    asserts.assert(r == r.expand(0, 0));
    asserts.assert(r != r.expand(10, 10));
    asserts.assert(r == r.expand(10, 10).expand(-10, -10));

    return asserts.done();
  }
}