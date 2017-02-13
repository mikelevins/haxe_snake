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

  private var isInitialized = false;
  private var scale:Int;
  private var columnCount:Int;
  private var rowCount:Int;
  private var theApple:Apple;

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
  
  // event handling
  // --------------------------------------------
  
  private function keyUp (event:KeyboardEvent){
    trace(event.keyCode);
  };

  // construction, initialization
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

    Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, keyUp );
  };

  public function new ( scale:Int, columnCount:Int, rowCount:Int ){
    super();
    this.scale = scale;
    this.columnCount = columnCount;
    this.rowCount = rowCount;
    addEventListener(Event.ADDED_TO_STAGE, added);
 }
}