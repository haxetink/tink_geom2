#if haxe4
  import haxe.ds.ReadOnlyArray as Array;
#end

@:asserts
class Points {
  public function new() {

  }

  static public final grid:Array<Array<Point>> = [for (x in -1...2)
    [for (y in -1...2)
      new Point(x, y)
    ]
  ];

  public function test() {

    function eq(a:Float, b:Float, ?pos) {
      a = Std.int(a * 10000) / 10000;
      b = Std.int(b * 10000) / 10000;
      return asserts.assert(a == b, null, pos);
    }

    eq(grid[0][0].length, Math.sqrt(2));
    eq(grid[2][0].length, Math.sqrt(2));
    eq(grid[0][2].length, Math.sqrt(2));
    eq(grid[2][2].length, Math.sqrt(2));

    eq(grid[0][1].length, 1);
    eq(grid[1][0].length, 1);
    eq(grid[1][2].length, 1);
    eq(grid[2][1].length, 1);

    eq(grid[1][1].length, 0);

    for (x in 0...3)
      for (y in 0...3)
        eq(grid[x][y].normalize(10).length, if (x * y == 1) 0 else 10);

    function angle(x, y, expect:Float, ?pos)
      eq(grid[x][y].angle, expect * Math.PI, pos);

    angle(0, 0, -3 / 4);
    angle(0, 1, 1);
    angle(0, 2, 3 / 4);

    angle(1, 0, -1 / 2);
    angle(1, 1, 0);
    angle(1, 2, 1 / 2);

    angle(2, 0, -1 / 4);
    angle(2, 1, 0);
    angle(2, 2, 1 / 4);

    return asserts.done();
  }

  public function equality() {
    for (x in 0...3)
      for (y in 0...3) {
        var p = grid[x][y];
        asserts.assert(p == new Point(p.x, p.y));
      }

    return asserts.done();
  }

  public function inversion() {
    for (x in 0...3)
      for (y in 0...3)
        asserts.assert(grid[2-x][2-y] == -grid[x][y]);

    return asserts.done();
  }

}