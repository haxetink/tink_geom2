package tink.geom2;

@:enum abstract Dimension(String) {
  var Vertical = 'vertical';
  var Horizontal = 'horizontal';

  @:op(!a)
  public inline function flip():Dimension
    return switch (cast this:Dimension) {
      case Vertical: Horizontal;
      default: Vertical;
    }

  public inline function rect(normal, sidewards)
    return switch (cast this:Dimension) {
      case Vertical: new Rect(sidewards, normal);
      default: new Rect(normal, sidewards);
    }
}