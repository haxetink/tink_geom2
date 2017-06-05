package tink.geom2;

using tink.CoreApi;

typedef Constraint = {
  side:Side, 
  ?align:Float, 
  ?alignOnAnchor:Float, 
  ?withoutSideDrift:Bool,
}

typedef FitRectFunc = Rect->Rect->Size->Option<Rect>;

@:callable
abstract FitRect(FitRectFunc) from FitRectFunc to FitRectFunc {

  @:from static public function ofSide(side:Side):FitRect
    return ofConstraint({ side: side });

  @:from static public function ofConstraint(c:Constraint):FitRect
    return checkSide.bind(_, _, _, c);
  
  @:from static public function compound(fitters:Array<FitRect>):FitRect 
    return function (area:Rect, anchor:Rect, required:Size) {
      for (s in fitters)
        switch s(area, anchor, required) {
          case None:
          case v: return v;
        }
      return None;
    }  
  static var ALL:Array<Side> = [Above, Below, Lefthand, Righthand];

  static public function allSides(?preferences:Array<Side>):FitRect {
    var ret = [],
        added = new Map();

    function add(sides:Array<Side>)
      if (sides != null)
        for (s in sides)
          if (!added[s]) {
            added[s] = true;
            ret.push(checkSide.bind(_, _, _, { side: s }));
          }

    add(preferences);
    add(ALL);
    return ret;
  }    

  static public function checkSide(area:Rect, anchor:Rect, required:Size, c:Constraint):Option<Rect> {
    var normal = c.side.toDimension(),
        origin = c.side.toPos();

    var sidewards = !normal,
        dest = !origin;

    inline function val(f:Float, dFault:Float) 
      return if (Math.isNaN(f)) dFault else f;

    var alignSelf = val(c.align, .5);
    var alignOnAnchor = val(c.alignOnAnchor, alignSelf);

    return 
      if (origin.isBeyond(origin.expand(anchor[normal][origin], required[normal]), area[normal][origin])) None;
      else {
        var anchorPos = anchor[sidewards][alignOnAnchor] - alignSelf * required[sidewards];

        var contact = dest.closest(area[normal][dest], anchor[normal][origin]),
            sideDrift = Math.min(area[sidewards].end - required[sidewards], Math.max(area[sidewards].start, anchorPos));
        
        if (c.withoutSideDrift && anchorPos != sideDrift) None;
        else Some(normal.rect(
          origin.extent(origin.expand(contact, required[normal]), contact),
          new Extent(sideDrift, sideDrift + required[sidewards])
        ));
      }
  }  
}