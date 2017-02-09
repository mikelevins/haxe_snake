import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

class Snake extends Sprite {

  private var isInitialized = false;
  private var theApple: Sprite;

  private function keyUp (event:KeyboardEvent){
    switch( event.keyCode ) {
    case 38: // KEY_UP
      trace('up');
    case 40: // KEY_DOWN
      trace('down');
    case 39: // KEY_RIGHT
      trace('right');
    case 37: // KEY_LEFT
      trace('left');
    }
  }

  function init() {
    if (isInitialized) return;
    isInitialized = true;

    theApple = new Sprite();

    theApple.graphics.beginFill(0xCC0000);
    theApple.graphics.drawCircle(0, 0, 5);
    theApple.x = (stage.stageWidth - 10) / 2;
    theApple.y = (stage.stageHeight - 10) / 2;

    Lib.current.stage.addChild(theApple);
    Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, keyUp );
  };

  function resize(e) 
  {
    if (!isInitialized) init();
    // else handle a resize
  };

  public function new() 
  {
    super();	
    addEventListener(Event.ADDED_TO_STAGE, added);
  };

  function added(e) 
  {
    removeEventListener(Event.ADDED_TO_STAGE, added);
    stage.addEventListener(Event.RESIZE, resize);
    init();
  };

  // main entry point
  public static function main() 
  {
    // static entry point
    Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
    Lib.current.addChild(new Snake());
    //
  };

}
