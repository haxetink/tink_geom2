@:asserts
class Sizes {

  public function new() {

  }

  public function equality() {
    var size = new Size(2, 2);
    asserts.assert(size == size);
    asserts.assert(size == size * 1);
    asserts.assert(size != size * -1);
    asserts.assert(size == -1 * size * -1);
    return asserts.done();
  }
}