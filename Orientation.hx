
// ---------------------------------
// Orientation 
// ---------------------------------
// convenient representation of
// directions snakes can move
// to move a snake up, we can do this:
//    var nextX = head.x+GameBoard.scale*orientation.x;
//    var nextY = head.y+GameBoard.scale*orientation.y;


class Orientation {
  public static var UP = new Orientation(0,-1);
  public static var DOWN = new Orientation(0,1);
  public static var LEFT = new Orientation(-1,0);
  public static var RIGHT = new Orientation(1,0);

  public var x:Int;
  public var y:Int;

  public function new(x:Int, y:Int){
    this.x = x;
    this.y = y;
  }
}

