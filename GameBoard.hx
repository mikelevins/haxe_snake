import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import haxe.Timer;

// ---------------------------------
// GameBoard 
// ---------------------------------
// the playing field for the game

class GameBoard extends Sprite {

  // private vars
  // --------------------------------------------

  public static var theGameBoard:GameBoard;
  public static var scale:Int;
  public static var columnCount:Int;
  public static var rowCount:Int;

  private var isInitialized = false;
  private var theApple:Apple;
  private var theSnakes:Array<Snake>;
  private var runTimer:Timer=null;

  // gameboard dimensions
  // --------------------------------------------

  private static function coordinateForColumn(columnIndex:Int) { return ((2*columnIndex+1)*scale/2); }
  private static function coordinateForRow(rowIndex:Int) { return ((2*rowIndex+1)*scale/2); }

  private static function columnForCoordinate(coordinate:Int) { return Math.floor(coordinate/scale); }
  private static function rowForCoordinate(coordinate:Int) { return Math.floor(coordinate/scale); }

  public function isOnBoundary (x:Float, y: Float) {
    if (x < 0) return true;
    if (y < 0) return true;
    if (x > scale*columnCount) return true;
    if (y > scale*rowCount) return true;
    return false;
  };
  
  // gameboard children
  // --------------------------------------------

  public function findAnEmptySquare () {
    // we'll start the search at a random square
    // then search from the origin. This ensures
    // that we find randomly-placed squares in order
    // to randomize apple placement
    
    var startX = Std.random(columnCount);
    var startY = Std.random(rowCount);

    // first search from startX,startY to the end
    for (j in startY...rowCount) {
      for (i in startX...columnCount) {
        if (!(isOnASnake(i,j)) && !(isOnTheApple(i,j))) return [i,j];
      }
    }

    // next, search from 0,0 to startX,startY
    for (j in startY...rowCount) {
      for (i in startX...columnCount) {
        if (!(isOnASnake(i,j)) && !(isOnTheApple(i,j))) return [i,j];
      }
    }

    // if we get here then there are no empty squares
    return [-1,-1];
  }
  
  public function isOnSnake (x:Float, y: Float, snake:Snake) {
    var head = snake.getHead();
    var tail = snake.getTail();

    if ( (x == head.x) && (y == head.y)  ) { return true; }

    for ( segment in tail ) {
      if ( (x == segment.x) && (y == segment.y)  ) { return true; }
    }

    return false;
  };

  public function isOnASnake (x:Float, y: Float) {
    if (theSnakes != null){
      for (snake in theSnakes) {
        if (isOnSnake(x,y,snake)) { return true; }
      }
    }
    return false;
  };

  public function isOnTheApple (x:Float, y: Float) {
    return (x == theApple.x) && (y == theApple.y);
  };
  
  // managing the apple
  // --------------------------------------------
  
  public function stageTheApple(){
    var place = findAnEmptySquare();
    var x = coordinateForColumn(place[0]);
    var y = coordinateForRow(place[1]);
    theApple.x = x;
    theApple.y = y;
    this.addChild(theApple);
  }

  public function removeTheApple(){
    this.removeChild(theApple);
  }

  // managing the snakes
  // --------------------------------------------

  // TODO: this version of stageASnake assumes
  //       that the tail is empty and will not
  //       work properly if it isn't. Either
  //       ensure that snakes can only be staged
  //       with empty tails, or reimplement to
  //       position a snake while preserving the
  //       shape of its tail
  private function stageASnake(snake:Snake){
    var place = findAnEmptySquare();
    var x = coordinateForColumn(place[0]);
    var y = coordinateForRow(place[1]);
    var head = snake.getHead();
    head.x = x;
    head.y = y;
    this.addChild(head);
  }
  
  private function stageTheSnakes(){
    for (snake in theSnakes) {
      stageASnake(snake);
    }
  }

  private function removeASnake(snake:Snake){
    this.removeChild(snake.getHead());
    for (segment in snake.getTail()){
      this.removeChild(segment);
    }
  }

  public function discardASnake(snake:Snake){
    this.removeASnake(snake);
    theSnakes.remove(snake);
  }

  public function discardAllSnakes() {
    for (snake in theSnakes) {
      discardASnake(snake);
    }
    
  }
  
  // game updates
  // --------------------------------------------

  private function gameOver(){
    removeTheApple();
    discardAllSnakes();
    trace("Game Over!");
  }

  private function advance() {
    // first see if all the snakes are gone; if so, the game is over
    if (theSnakes.length < 1) {
      gameOver();
    } else {
      // next check for empty squares;
      var emptySquare = findAnEmptySquare();
      // if there are none then the game is over
      if (emptySquare == [-1,-1]) {
        gameOver();
      } else {
        // if there were empty squares then the game continues
        for (snake in theSnakes) {
          snake.advance(this);
        }
      }
    }
  }
  
  // event handling
  // --------------------------------------------

  private function toggleStart() {
    if (runTimer == null) {
      runTimer = new haxe.Timer(500);
      runTimer.run = advance;
    } else {
      runTimer.stop();
      runTimer = null;
    }
  };
  
  private function keyUp (event:KeyboardEvent){
    var handled = false;

    if ( event.keyCode == " ".code ) {
      handled = true;
      toggleStart();
    } else {
      for (snake in theSnakes) {
        handled = snake.handleKey(event.keyCode);
        if (handled) break;
      }
    }
    if (!handled) { trace(event.keyCode); };
  };

  // construction and initialization
  // --------------------------------------------
  
  function resize(e) 
  {
    if (!isInitialized) init();
    // else handle resizing the gameboard
  };
  
  function added(e) 
  {
    removeEventListener(Event.ADDED_TO_STAGE, added);
    stage.addEventListener(Event.RESIZE, resize);
    init();
  };

  function init() {
    if (isInitialized) return;
    isInitialized = true;

    this.graphics.lineStyle(1, Colors.GOLD);
    this.graphics.beginFill(Colors.IVORY, 1);
    for ( i in 0...columnCount ) {
      for (j in 0...rowCount)
        this.graphics.drawRect(i*scale, j*scale, scale, scale);    
    }
    
    theApple = new Apple(scale);
    stageTheApple();

    theSnakes = [new Snake(Colors.GREEN,Orientation.UP,[Keys.UP,Keys.DOWN,Keys.RIGHT,Keys.LEFT])
                 , new Snake(Colors.CYAN,Orientation.UP,["W".code, "S".code, "D".code, "A".code])
                 //, new Snake(Colors.BLUE,Orientation.UP,["I".code, "K".code, "L".code, "J".code])
                 ];
    stageTheSnakes();
    
    Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, keyUp );
  };

  public function new ( scale:Int, columnCount:Int, rowCount:Int ){
    super();
    GameBoard.theGameBoard = this;
    GameBoard.scale = scale;
    GameBoard.columnCount = columnCount;
    GameBoard.rowCount = rowCount;
    addEventListener(Event.ADDED_TO_STAGE, added);
 }
}