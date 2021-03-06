package ;

import tink.geom2.Matrix;
import tink.geom2.Point;
import tink.geom2.Rect;

import tink.unit.TestBatch;
import tink.testrunner.*;

class RunTests {
  static function main() {
    Runner.run(
      TestBatch.make(
        new Points(),
        new Extents(),
        new PanZooms(),
        new Matrices(),
        new Rects(),
        new Sizes()
      )
    ).handle(Runner.exit);
  }
}