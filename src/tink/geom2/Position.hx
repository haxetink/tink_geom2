package tink.geom2;

@:enum abstract Position(String) {
  
  var Start = 'start';
  var End = 'end';

  public inline function extent(start:Float, end:Float):Extent 
    return switch this {
      case End: new Extent(end, start);
      default: new Extent(start, end);
    }

  public function isBeyond(pos:Float, bound:Float)
    return switch this {
      case End: pos > bound;
      default: pos < bound;
    }

  public inline function closest(a:Float, b:Float)
    return switch this {
      case End: Math.min(a, b);
      default: Math.max(a, b);
    }

  public inline function expand(value:Float, delta:Float):Float
    return value + switch this {
      case End: delta;
      default: -delta;
    }

  @:op(!a) 
  public inline function flip():Position
    return switch this {
      case End: Start;
      default: End;
    }

}