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
  private var commandMap:Map<Int, (Void -> Void)>;

  public function getColor(){ return color; };
  public function getOrientation(){ return orientation; };
  public function setOrientation(orientation:Orientation){ this.orientation=orientation; };
  public function getHead(){ return head; };
  public function getTail(){ return tail; };

  public function canHandleKey(key:Int) {
    return commandMap.exists(key);
  }

  public function handleKey(key:Int) {
    var canHandle = canHandleKey(key);
    if ( canHandle ) {
      var cmd = commandMap.get(key);
      cmd();
      return true;
    } else {
      return false;
    }
  }
  
  public function advance () {
    head.x += GameBoard.scale*orientation.x;
    head.y += GameBoard.scale*orientation.y;
  }
  
  public function new (color:Int, orientation:Orientation, commandKeys:Array<Int>){
    this.color = color;
    this.orientation = orientation;
    this.head = new Sprite();
    this.tail = [];
    this.commandMap = [commandKeys[0] => function (){ this.setOrientation(Orientation.UP); },
                       commandKeys[1] => function (){ this.setOrientation(Orientation.DOWN); },
                       commandKeys[2] => function (){ this.setOrientation(Orientation.RIGHT); },
                       commandKeys[3] => function (){ this.setOrientation(Orientation.LEFT); }];

    var radius = Std.int( GameBoard.scale/2 );
    this.head.graphics.beginFill(this.color);
    this.head.graphics.drawCircle(0, 0, radius);

  }
}