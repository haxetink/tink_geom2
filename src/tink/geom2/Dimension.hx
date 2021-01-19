package tink.geom2;

@:enum abstract Dimension(String) {
  var Horizontal = 'horizontal';
  var Vertical = 'vertical';


  static public final ALL:#if haxe4 haxe.ds.ReadOnlyArray #else Iterable #end<Dimension> = [Horizontal, Vertical];

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

  public inline function point(normal, sidewards)
    return switch (cast this:Dimension) {
      case Vertical: new Point(sidewards, normal);
      default: new Point(normal, sidewards);
    }
}