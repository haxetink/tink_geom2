@:asserts
class Extents {
  public function new() {

  }
  public function name() {
    return asserts.done();
  }

  public function equality() {
    for (i in 0...5) {
      var start = Math.random(),
          end = Math.random();

      asserts.assert(new Extent(start, end) == new Extent(start, end));
    }

    return asserts.done();
  }
}