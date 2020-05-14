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

      )
    ).handle(Runner.exit);
  }
}