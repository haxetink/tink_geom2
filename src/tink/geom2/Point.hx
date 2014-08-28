package tink.geom2;

using tink.CoreApi;

abstract Point(Pair<Float, Float>) {
  public var x(get, never):Float;
  public var y(get, never):Float;
  public var length(get, never):Float;
  public var angle(get, never):Float;
  
  inline function get_x() return this.a;
  inline function get_y() return this.b;
  inline function get_angle() return Math.atan2(y, x);
  inline function get_length() return Math.sqrt(x * x + y * y);
  
  public inline function new(x, y) this = new Pair(x, y);
  
  @:to public inline function toString() 
    return '($x, $y)';    
  
  @:op(a + b) static public inline function add(a:Point, b:Point)
    return new Point(a.x + b.x, a.y + b.y);

  @:op(a - b) static public inline function subtract(a:Point, b:Point)
    return new Point(a.x - b.x, a.y - b.y);

  @:op(-p) static public inline function invert(p:Point)
    return new Point(-p.x, -p.y);
}
