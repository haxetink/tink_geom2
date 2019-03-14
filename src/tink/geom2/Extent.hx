package tink.geom2;

using tink.CoreApi;

@:pure
abstract Extent(Pair<Float, Float>) {

  public var start(get, never):Float;
    inline function get_start() 
      return this.a;

  public var end(get, never):Float;
    inline function get_end()
      return this.b;

  public var size(get, never):Float;
    inline function get_size()
      return end - start;

  public function new(start, end) 
    this = new Pair(start, end);

  public inline function intersects(that:Extent) 
    return Math.max(start, that.start) < Math.min(end, that.end);

  @:to public inline function toString() 
    return '($start - $end)';

  @:op(a * b) static function rect(a:Extent, b:Extent)
    return new Rect(a, b);

  @:arrayAccess 
  public inline function getBound(pos:Position)
    return switch pos {
      case Start: start;
      case End: end;
    }

  @:arrayAccess 
  public inline function interpolate(factor:Float) 
    return this.a + factor * (this.b - this.a);

}