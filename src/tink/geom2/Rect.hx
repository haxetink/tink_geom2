package tink.geom2;

class RectData {
  public var top(default, null):Float;
  public var left(default, null):Float;
  public var right(default, null):Float;
  public var bottom(default, null):Float;
  
  public inline function new(top, left, right, bottom) {
    this.top = top;
    this.left = left;
    this.right = right;
    this.bottom = bottom;
  }
}

@:forward
abstract Rect(RectData) from RectData {
  
  public var width(get, never):Float;
    inline function get_width()
      return this.right - this.left;
      
  public var height(get, never):Float;
    inline function get_height()
      return this.bottom - this.top;
      
  public inline function new(top, left, right, bottom)
    this = new RectData(top, left, right, bottom);
    
  #if pixijs
  @:from static function ofPixi(r:pixi.core.math.shapes.Rectangle) {
    return ofFlashlike(r);
  }
  #end
  
  public inline function intersects(that:Rect)
    return 
      this != null && that != null 
      && Math.max(this.left, that.left) < Math.min(this.right, that.right) 
      && Math.max(this.top, that.top) < Math.min(this.bottom, that.bottom);
  
  static public function ofFlashlike<N:Float, R:Flashlike<N>>(r:R) 
    return new Rect(r.x, r.y, r.x + r.width, r.y + r.height);
    
    
 
}

private typedef Flashlike<N:Float> = {
  var x(default, null):N;
  var y(default, null):N;
  var width(default, null):N;
  var height(default, null):N;
}