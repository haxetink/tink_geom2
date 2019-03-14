package tink.geom2;

using tink.CoreApi;

@:pure
abstract Size(Pair<Float, Float>) {

  public var width(get, never):Float;
    inline function get_width()
      return this.a;

  public var height(get, never):Float;
    inline function get_height()
      return this.b;

  public var total(get, never):Float;
    inline function get_total()
      return width * height;

  public inline function new(width, height)
    this = new Pair(width, height);

  @:arrayAccess public inline function size(dim:Dimension)
    return if (dim == Horizontal) width else height;

  public function contains(that:Size)
    return width >= that.width && height > that.height;

  @:commutative 
  @:op(a * b) 
  static inline function scale(size:Size, factor:Float)
    return new Size(size.width * factor, size.height * factor);

  @:op(a + b) 
  static inline function add(a:Size, b:Size)
    return new Size(a.width + b.width, a.height + b.height);

}