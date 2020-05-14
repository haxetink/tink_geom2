@:asserts
class PanZooms {
  public function new() {

  }

  static inline function rnd()
    return Math.random() * 100 - 50;

  public function concat() {

    for (i in 0...5) {
      var t1 = new PanZoom(rnd(), rnd(), rnd()),
          t2 = new PanZoom(rnd(), rnd(), rnd());

      for (row in Points.grid)
        for (p in row)
          asserts.assert(((p * t1) * t2).snap() == (p * (t1 * t2)).snap());
    }

    return asserts.done();
  }

  public function equality() {

    var p = new PanZoom(rnd(), rnd(), rnd());

    asserts.assert(p == p);
    asserts.assert(p == p + new Point(0, 0));
    asserts.assert(p != p + new Point(1, 0));
    asserts.assert(p != p + new Point(0, 1));
    asserts.assert(p == (p + new Point(20, 30)) - new Point(20, 30));

    return asserts.done();
  }
}