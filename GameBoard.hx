import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

class GameBoard extends Sprite {
  private var isInitialized = false;
  private var scale:Int;
  private var columnCount:Int;
  private var rowCount:Int;

  private function keyUp (event:KeyboardEvent){
    trace(event.keyCode);
  };

  function init() {
    if (isInitialized) return;
    isInitialized = true;

    Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, keyUp );
  };
  
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
  
  public function new ( scale:Int, columnCount:Int, rowCount:Int ){
    super();
    this.scale = scale;
    this.columnCount = columnCount;
    this.rowCount = rowCount;
    addEventListener(Event.ADDED_TO_STAGE, added);
 }
}