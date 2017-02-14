import flash.Lib;
import flash.display.Sprite;

// ---------------------------------
// Snake 
// ---------------------------------
// representation of player snakes
// The snake is not itself a sprite; it's
// a container for several other sprites
// used to draw the snake, plus some
// other parameters.
// a snake stores a sprite representing its head,
// an array of sprites representing its tail,
// a command map that defines the keys that
// control its direction, a color, and
// a current orientation (the direction)
// it moves.

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

  // control-event handlers
  // --------------------------------------------
  // how we handle control keys:
  // the GameBoard asks each snake in turn to
  // handle the keystroke. Each snake
  // searches its command map to see whether
  // the presented keycode exists in its map.
  // if so, the snake calls the function associated
  // with the keycode in the command map
  // (see the new() implementation for the
  // control functions). If we found and
  // executed a command then we return true.
  // If not, we return false, enabling the
  // calling code to dispatch to the next snake.
  //
  // TODO: define the command functions as
  //       ordinary named functions instead of
  //       anonymous lambdas. Since there are
  //       just four of them, we can define them
  //       once and reuse them.
  
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

  // remove a dead snake from the game
  // --------------------------------------------
  
  public function die() {
    GameBoard.theGameBoard.discardASnake(this);
  }

  // snake movement
  // --------------------------------------------
  
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

  // high-level snake movement control
  // --------------------------------------------

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

  // lengthen the tail when eating an apple
  // --------------------------------------------  
  // (see eatApple() above)
  // we lengthen the tail by inserting a new sprite
  // at the front of the tail, but behind the head
  // this is preferable to adding the segment to
  // the end of the tail because it doesn't require us
  // to know whether the end of the tail should bend,
  // and if so, which direction. Instead, when
  // the snake eats an apple and therefore grows longer,
  // we move the head forward one space and then insert
  // the new segment into the space the head formerly
  // occupied, leaving the rest of the tail in place.
  // in this way the tail always ends up the right
  // shape and length, and we don't have to know
  // anything about the direction of bend at the
  // tip of the tail.
  
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