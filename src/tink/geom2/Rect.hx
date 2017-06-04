package tink.geom2;

using tink.CoreApi;

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