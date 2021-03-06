package tink.geom2;

import tink.core.Pair;

@:jsonStringify((p:tink.geom2.Point) -> { x: p.x, y: p.y })
@:jsonParse(o -> new tink.geom2.Point(o.x, o.y))
@:pure
abstract Point(Pair<Float, Float>) from Pair<Float, Float> to Pair<Float, Float> {

  static public var ZERO(default, null) = new Point(0, 0);

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
    return switch length {
      case 0: this;
      case v: scale(this, l / v);
    }

  public function makeRect(size:Size)
    return new Rect(
      new Extent(x, x + size.width),
      new Extent(y, y + size.height)
    );

  @:op(a...b) public function makeRectTo(p:Point)
    return new Rect(
      new Extent(x, p.x),
      new Extent(y, p.y)
    );


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

  @:op(p / f) static public inline function unscale(p:Point, f:Float)
    return scale(p, 1 / f);

  @:from static inline function ofObj(obj: { var x(default, null):Float; var y(default, null):Float; }):Point
    return new Point(obj.x, obj.y);

  @:op(a == b) static inline function eq(a:Point, b:Point)
    return !(a != b);

  @:op(a != b) static inline function neq(a:Point, b:Point)
    return a.x != b.x || a.y != b.y;
}
