import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

// ---------------------------------
// GameBoard 
// ---------------------------------
// the playgin field for the game

class GameBoard extends Sprite {

  // private vars
  // --------------------------------------------

  public static var scale:Int;
  public static var columnCount:Int;
  public static var rowCount:Int;

  private var isInitialized = false;
  private var theApple:Apple;
  private var theSnakes:Array<Snake>;

  // gameboard dimensions
  // --------------------------------------------

  private function coordinateForColumn (column:Int) {
    return ((2*column)+1)*scale/2;
  };

  private function coordinateForRow (row:Int) {
    return ((2*row)+1)*scale/2;
  };
  
  // managing the apple
  // --------------------------------------------

  // TODO: find a place that doesn't have a snake in it
  private function placeForTheApple() {
    var row = Std.random(rowCount);
    var column = Std.random(columnCount);
    return [column,row];
  }
  
  private function stageTheApple(){
    var place = placeForTheApple();
    var x = coordinateForColumn(place[0]);
    var y = coordinateForRow(place[1]);
    theApple.x = x;
    theApple.y = y;
    this.addChild(theApple);
  }

  private function removeTheApple(){
    this.removeChild(theApple);
  }

  // managing the snakes
  // --------------------------------------------

  // TODO: find a place that doesn't have a snake in it
  private function placeForASnake() {
    var row = Std.random(rowCount);
    var column = Std.random(columnCount);
    return [column,row];
  }

  // TODO: this version of stageASnake assumes
  //       that the tail is empty and will not
  //       work properly if it isn't. Either
  //       ensure that snakes can only be staged
  //       with empty tails, or reimplement to
  //       position a snake while preserving the
  //       shape of its tail
  private function stageASnake(snake:Snake){
    var place = placeForASnake();
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
  
  // game updates
  // --------------------------------------------

  private function advance() {
    for (snake in theSnakes) {
      snake.advance();
    }
  }
  
  // event handling
  // --------------------------------------------

  private function keyUp (event:KeyboardEvent){
    var handled = false;

    if ( event.keyCode == " ".code ) {
      handled = true;
      advance();
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

    theSnakes = [new Snake(Colors.GREEN,Orientation.UP,[Keys.UP,Keys.DOWN,Keys.RIGHT,Keys.LEFT]),
                 new Snake(Colors.CYAN,Orientation.UP,["W".code, "S".code, "D".code, "A".code]),
                 new Snake(Colors.BLUE,Orientation.UP,["I".code, "K".code, "L".code, "J".code])
                 ];
    stageTheSnakes();
    
    Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, keyUp );
  };

  public function new ( scale:Int, columnCount:Int, rowCount:Int ){
    super();
    GameBoard.scale = scale;
    GameBoard.columnCount = columnCount;
    GameBoard.rowCount = rowCount;
    addEventListener(Event.ADDED_TO_STAGE, added);
 }
}