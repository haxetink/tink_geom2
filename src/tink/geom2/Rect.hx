package tink.geom2;

using tink.CoreApi;

@:jsonStringify((r:tink.geom2.Rect) -> { top: r.top, left: r.left, right: r.right, bottom: r.bottom })
@:jsonParse(r -> new tink.geom2.Rect(new tink.geom2.Extent(r.left, r.right), new tink.geom2.Extent(r.top, r.bottom)))
@:pure
abstract Rect(Pair<Extent, Extent>) {

  public var top(get, never):Float;
    inline function get_top()
      return vertical.start;

  public var bottom(get, never):Float;
    inline function get_bottom()
      return vertical.end;

  public var left(get, never):Float;
    inline function get_left()
      return horizontal.start;

  public var right(get, never):Float;
    inline function get_right()
      return horizontal.end;

  public var width(get, never):Float;
    inline function get_width()
      return horizontal.size;

  public var height(get, never):Float;
    inline function get_height()
      return vertical.size;

  public var horizontal(get, never):Extent;
    inline function get_horizontal()
      return this.a;

  public var vertical(get, never):Extent;
    inline function get_vertical()
      return this.b;

  public var aspectRatio(get, never):Float;
    inline function get_aspectRatio()
      return width / height;

  public var tr(get, never):Point;
    inline function get_tr()
      return new Point(right, top);

  public var tl(get, never):Point;
    inline function get_tl()
      return new Point(left, top);

  public var br(get, never):Point;
    inline function get_br()
      return new Point(right, bottom);

  public var bl(get, never):Point;
    inline function get_bl()
      return new Point(left, bottom);

  public inline function new(horizontal, vertical)
    this = new Pair(horizontal, vertical);

  public var size(get, never):Size;
    @:to inline function get_size()
      return new Size(width, height);

  #if pixijs
  @:from static function ofPixi(r:pixi.core.math.shapes.Rectangle) {
    return ofFlashlike(r);
  }
  #end

  @:arrayAccess public function extent(dimension:Dimension):Extent
    return switch dimension {
      case Horizontal: horizontal;
      case Vertical: vertical;
    }

  public inline function intersects(that:Rect)
    return
      this != null && that != null
      && horizontal.intersects(that.horizontal)
      && vertical.intersects(that.vertical);

  public inline function contains(that:Rect)
    return
      this != null && that != null
      && horizontal.contains(that.horizontal)
      && vertical.contains(that.vertical);

  public function expand(h:Float, v:Float)
    return horizontal.expand(h) * vertical.expand(v);

  @:from static public inline function ofJslike(r:Jslike)
    return new Rect(
      new Extent(r.left, r.right),
      new Extent(r.top, r.bottom)
    );

  @:from static public inline function ofFlashlike(r:Flashlike)
    return new Rect(
      new Extent(r.x,  r.x + r.width),
      new Extent(r.y, r.y + r.height)
    );

  @:to public inline function toString()
    return 'Rect(hor: $horizontal, ver: $vertical)';

  @:op(a == b) static inline function eq(a:Rect, b:Rect)
    return !(a != b);

  @:op(a != b) static function neq(a:Rect, b:Rect)
    return a.horizontal != b.horizontal || a.vertical != b.vertical;

}

private typedef Jslike = {
  var left(default, null):Float;
  var right(default, null):Float;
  var top(default, null):Float;
  var bottom(default, null):Float;
}
private typedef Flashlike = {
  var x(default, null):Float;
  var y(default, null):Float;
  var width(default, null):Float;
  var height(default, null):Float;
}