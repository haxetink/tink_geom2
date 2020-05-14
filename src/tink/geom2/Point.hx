package tink.geom2;

import tink.core.Pair;

@:pure
abstract Point(Pair<Float, Float>) from Pair<Float, Float> to Pair<Float, Float> {
  public var x(get, never):Float;
  public var y(get, never):Float;
  public var length(get, never):Float;
  public var angle(get, never):Float;

  inline function get_x() return this.a;
  inline function get_y() return this.b;

  inline function get_angle() return Math.atan2(y, x);
  inline function get_length() return Math.sqrt(x * x + y * y);

  @:op([]) public inline function component(d:Dimension)
    return switch d {
      case Horizontal: x;
      default: y;
    }

  public inline function new(x, y) this = new Pair(x, y);

  public function snap(unit = 1.0)
    return new Point(Math.round(x / unit) * unit, Math.round(y / unit) * unit);

  public inline function normalize(l:Float = 1):Point
    return scale(this, l / length);

  public inline function dot(that:Point):Float
    return x * that.x + y * that.y;

  public inline function isLeftOf(from:Point, to:Point)
    return (to.x - from.x) * (y - from.y) > (to.y - from.y) * (x - from.x);

  @:to public inline function toString()
    return '($x, $y)';

  @:op(a + b) static public inline function add(a:Point, b:Point)
    return new Point(a.x + b.x, a.y + b.y);

  @:op(a - b) static public inline function subtract(a:Point, b:Point)
    return new Point(a.x - b.x, a.y - b.y);

  @:op(-p) static public inline function invert(p:Point)
    return new Point(-p.x, -p.y);

  @:commutative @:op(p * f) static public inline function scale(p:Point, f:Float)
    return new Point(p.x * f, p.y * f);

  @:from static inline function ofObj(obj: { var x(default, null):Float; var y(default, null):Float; }):Point
    return new Point(obj.x, obj.y);

  @:op(a == b) static inline function eq(a:Point, b:Point)
    return a.x == b.x && a.y == b.y;
}
