package tink.geom2;

using tink.CoreApi;

@:jsonStringify((s:tink.geom2.Size) -> { width: s.width, height: s.height })
@:jsonParse(@:privateAccess tink.geom2.Size.ofObj)
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

  public var aspectRatio(get, never):Float;
    inline function get_aspectRatio()
      return width / height;


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

  @:op(a == b) static inline function eq(a:Size, b:Size)
    return !(a != b);

  @:op(a != b) static inline function neq(a:Size, b:Size)
    return a.width != b.width || a.height != b.height;

  @:from static function ofObj(o:{ var width(default, null):Float; var height(default, null):Float; })
    return new Size(o.width, o.height);

}