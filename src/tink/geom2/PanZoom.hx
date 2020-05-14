package tink.geom2;

private class PanZoomData {
  public #if haxe4 final #else var #end zoom:Float;
  public #if haxe4 final #else var #end panX:Float;
  public #if haxe4 final #else var #end panY:Float;

  public function new(panX, panY, zoom) {
    this.panX = panX;
    this.panY = panY;
    this.zoom = zoom;
  }
}

abstract PanZoom(PanZoomData) {

  public var zoom(get, never):Float;
    inline function get_zoom()
      return this.zoom;

  public var panX(get, never):Float;
    inline function get_panX()
      return this.panX;

  public var panY(get, never):Float;
    inline function get_panY()
      return this.panY;

  static public var ZERO(default, never):PanZoom = 1.0;

  public inline function new(panX, panY, zoom)
    this = new PanZoomData(panX, panY, zoom);

  public inline function with(o:{ ?panX:Float, ?panY:Float, ?zoom:Float })
    return new PanZoom(
      switch o.panX {
        case null: panX;
        case v: v;
      },
      switch o.panY {
        case null: panY;
        case v: v;
      },
      switch o.zoom {
        case null: zoom;
        case v: v;
      }
    );

  public function blend(that:PanZoom, ?method:BlendMethod)
    return switch method {
      case null: blend(that, .5);
      case f: new PanZoom(f(this.panX, that.panX), f(this.panY, that.panY), f(this.zoom, that.zoom));
    }

  @:commutative @:op(m * p) static public function transformPoint(t:PanZoom, p:Point)
    return new Point(t.zoom * p.x + t.panX, t.zoom * p.y + t.panY);

  @:op(m * f) static function scale(m:PanZoom, f:Float) //TODO: all these ops are easy enough to inline instead of requiring a generic concat
    return m * (f:PanZoom);

  @:op(f * m) static function rscale(f:Float, m:PanZoom)
    return (f:PanZoom) * m;

  @:op(m + p) static function move(m:PanZoom, p:Point)
    return m * (p:PanZoom);

  @:op(p + m) static function rmove(p:Point, m:PanZoom)
    return (p:PanZoom) * m;

  @:op(m - p) static inline function moveback(m:PanZoom, p:Point)
    return move(m, -p);

  @:op(m * n) static function concat(m:PanZoom, n:PanZoom)
    return new PanZoom(
      n.zoom * m.panX + n.panX,
      n.zoom * m.panY + n.panY,
      n.zoom * m.zoom
    );

  @:to public function toString()
    return 'translate(${panX}px, ${panY}px) scale($zoom)';

  @:to public inline function toMatrix():Matrix
    return new Matrix(zoom, 0, 0, zoom, panX, panY);

  @:from static public inline function zoomBy(f:Float)
    return new PanZoom(0, 0, f);

  @:from static public inline function pan(p:Point)
    return new PanZoom(p.x, p.y, 1);

  @:op(!t) static public function invert(t:PanZoom) {
    var a = 1 / t.zoom;
    return new PanZoom(-(a * t.panX), -(a * t.panY), a);
  }

}

@:callable
abstract BlendMethod(Float->Float->Float) from Float->Float->Float {
  @:from static inline function ofFloat(f:Float):BlendMethod
    return function (a, b) return (a * (f - 1) + b * f) / (1 + f);
}