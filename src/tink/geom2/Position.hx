package tink.geom2;

@:enum abstract Position(String) {

  var Start = 'start';
  var End = 'end';

  public var sign(get, never):Int;
    inline function get_sign():Int
      return if ((cast this) == Start) -1 else 1;

  public inline function to01():Int
    return if ((cast this) == Start) 0 else 1;

  public inline function extent(start:Float, end:Float):Extent
    return switch (cast this:Position) {
      case End: new Extent(end, start);
      default: new Extent(start, end);
    }

  public function isBeyond(pos:Float, bound:Float)
    return switch (cast this:Position) {
      case End: pos > bound;
      default: pos < bound;
    }

  public inline function closest(a:Float, b:Float)
    return switch (cast this:Position) {
      case End: Math.min(a, b);
      default: Math.max(a, b);
    }

  public inline function expand(value:Float, delta:Float):Float
    return value + switch (cast this:Position) {
      case End: delta;
      default: -delta;
    }

  @:op(!a)
  public inline function flip():Position
    return switch (cast this:Position) {
      case End: Start;
      default: End;
    }

}