package tink.geom2;

private class ZoomPanData {
  public #if haxe4 final #else var #end zoom:Float;
  public #if haxe4 final #else var #end panX:Float;
  public #if haxe4 final #else var #end panY:Float;

  public function new(zoom, panX, panY) {
    this.zoom = zoom;
    this.panX = panX;
    this.panY = panY;
  }
}

abstract ZoomPan(ZoomPanData) {

  public var zoom(get, never):Float;
    inline function get_zoom()
      return this.zoom;

  public var panX(get, never):Float;
    inline function get_panX()
      return this.panX;

  public var panY(get, never):Float;
    inline function get_panY()
      return this.panY;

  static public var ZERO(default, never):ZoomPan = 1.0;

  inline function new(zoom, panX, panY)
    this = new ZoomPanData(zoom, panX, panY);

  @:commutative @:op(m * p) static public function transformPoint(t:ZoomPan, p:Point)
    return new Point(t.zoom * p.x + t.panX, t.zoom * p.y + t.panY);

  @:op(m * f) static function scale(m:ZoomPan, f:Float) //TODO: all these ops are easy enough to inline instead of requiring a generic concat
    return m * (f:ZoomPan);

  @:op(f * m) static function rscale(f:Float, m:ZoomPan)
    return (f:ZoomPan) * m;

  @:op(m + p) static function move(m:ZoomPan, p:Point)
    return m * (p:ZoomPan);

  @:op(p + m) static function rmove(p:Point, m:ZoomPan)
    return (p:ZoomPan) * m;

  @:op(m - p) static inline function moveback(m:ZoomPan, p:Point)
    return move(m, -p);

  @:op(m * n) static function concat(m:ZoomPan, n:ZoomPan)
    return new ZoomPan(
      n.zoom * m.zoom,
      n.zoom * m.panX + n.panX,
      n.zoom * m.panY + n.panY
    );

  @:to public function toString()
    return 'translate(${panX}px, ${panY}px) scale($zoom)';

  @:to public inline function toMatrix():Matrix
    return new Matrix(zoom, 0, 0, zoom, panX, panY);

  @:from static public inline function zoomBy(f:Float)
    return new ZoomPan(f, 0, 0);

  @:from static public inline function pan(p:Point)
    return new ZoomPan(1, p.x, p.y);

  @:op(!t) static public function invert(t:ZoomPan) {
    var a = 1 / t.zoom;
    return new ZoomPan(a, -(a * t.panX), -(a * t.panY));
  }

}