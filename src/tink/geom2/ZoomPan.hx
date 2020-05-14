package tink.geom2;

private class ZoomPanData {
  public var scale(default, null):Float;
  public var tx(default, null):Float;
  public var ty(default, null):Float;

  public function new(scale, tx, ty) {
    this.scale = scale;
    this.tx = tx;
    this.ty = ty;
  }
}

@:forward
abstract ZoomPan(ZoomPanData) {
  static public var ZERO(default, never):ZoomPan = 1.0;

  public inline function new(scale, tx, ty)
    this = new ZoomPanData(scale, tx, ty);

  @:op(m * n) static public function concat(m:ZoomPan, n:ZoomPan)
    return new ZoomPan(
      n.scale * m.scale,
      n.scale * m.tx + n.tx,
      n.scale * m.ty + n.ty
    );

  @:to public function toString()
    return 'scale(${this.scale}) translate(${this.tx}px, ${this.ty}px)';

  @:commutative @:op(m * p) static public function transformPoint(t:ZoomPan, p:Point)
    return new Point(t.scale * p.x + t.tx, t.scale * p.y + t.ty);

  @:to public inline function toMatrix():Matrix
    return new Matrix(this.scale, 0, 0, this.scale, this.tx, this.ty);

  @:from static public inline function zoom(f:Float)
    return new ZoomPan(f, 0, 0);

  static public inline function pan(p:Point)
    return new ZoomPan(1, p.x, p.y);

}