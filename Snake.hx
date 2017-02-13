import flash.Lib;
import flash.display.Sprite;

// ---------------------------------
// Snake 
// ---------------------------------
// representation of player snakes

class Snake {
  private var color: Int;
  private var orientation: Orientation;
  private var head: Sprite;
  private var tail: Array<Sprite>;

  public function getColor(){ return color; };
  public function getOrientation(){ return orientation; };
  public function setOrientation(orientation:Orientation){ this.orientation=orientation; };
  public function getHead(){ return head; };
  public function getTail(){ return tail; };

  public function advance () {
    head.x += GameBoard.scale*orientation.x;
    head.y += GameBoard.scale*orientation.y;
  }
  
  public function new (color:Int, orientation:Orientation){
    this.color = color;
    this.orientation = orientation;
    this.head = new Sprite();
    this.tail = [];

    var radius = Std.int( GameBoard.scale/2 );
    this.head.graphics.beginFill(this.color);
    this.head.graphics.drawCircle(0, 0, radius);
  }
}