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
  
  public function die() {
    GameBoard.theGameBoard.discardASnake(this);
  }
  
  public function advanceHeadAndTail() {
    var i = tail.length;

    if ( i > 0 ) {
      while (--i > 0) {
        var segment = tail[i];
        var next_segment = tail[i-1];
        segment.x = next_segment.x;
        segment.y = next_segment.y;
      }    

      var segment = tail[0];
      segment.x = head.x;
      segment.y = head.y;
    }

    head.x += GameBoard.scale*orientation.x;
    head.y += GameBoard.scale*orientation.y;
  }
  
  public function advanceAndDie() {
    advanceHeadAndTail();
    die();
  }
  
  public function eatApple() {
    var newSegmentX = head.x;
    var newSegmentY = head.y;
    head.x += GameBoard.scale*orientation.x;
    head.y += GameBoard.scale*orientation.y;
    GameBoard.theGameBoard.removeTheApple();
    addSegment(newSegmentX,newSegmentY);
    GameBoard.theGameBoard.stageTheApple();
  }

  public function advance (board:GameBoard) {
    var nextX = head.x+GameBoard.scale*orientation.x;
    var nextY = head.y+GameBoard.scale*orientation.y;

    if ( GameBoard.theGameBoard.isOnASnake(nextX,nextY) ) {
      advanceAndDie();
    } else if ( GameBoard.theGameBoard.isOnBoundary(nextX,nextY) ) {
      advanceAndDie();
    } else if ( GameBoard.theGameBoard.isOnTheApple(nextX,nextY) ) {
      eatApple();
    } else {
      advanceHeadAndTail();
    }
  }

  private function addSegment(x:Float,y:Float) {
    var sprite = new Sprite();
    sprite.graphics.beginFill(color);
    sprite.graphics.drawCircle(0, 0, GameBoard.scale/2);
    sprite.x = x;
    sprite.y = y;
    this.tail.insert(0,sprite);
    GameBoard.theGameBoard.addChild(sprite);        
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