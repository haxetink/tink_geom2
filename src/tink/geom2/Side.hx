package tink.geom2;

@:enum abstract Side(String) {
  
  var Lefthand = 'lefthand';
  var Righthand = 'righthand';
  var Above = 'above';
  var Below = 'below';

  @:to public inline function toPos():Position
    return switch this {
      case Lefthand | Above: Start;
      default: End;
    }

  @:to public inline function toDimension():Dimension
    return switch this {
      case Lefthand | Righthand: Horizontal;
      default: Vertical;
    }
}