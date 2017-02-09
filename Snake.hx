import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

class Snake  extends Sprite {

  private var isInitialized = false;

  private function keyUp (event:KeyboardEvent) {
    
  }

  function resize(e) 
  {
    if (!isInitialized) init();
    // else handle a resize
  }

  function init() {
    if (isInitialized) return;
    isInitialized = true;
    var stage = Lib.current.stage;

    // create the apple
    var the_apple = new Sprite();
    the_apple.graphics.beginFill(0xCC0000);

    the_apple.graphics.drawCircle(0, 0, 5);
    the_apple.x = (stage.stageWidth - 10) / 2;
    the_apple.y = (stage.stageHeight - 10) / 2;

    stage.addChild(the_apple);
    
    Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, keyUp );
  }

  public function new() 
  {
    super();	
    addEventListener(Event.ADDED_TO_STAGE, added);
  }

  function added(e) 
  {
    removeEventListener(Event.ADDED_TO_STAGE, added);
    stage.addEventListener(Event.RESIZE, resize);
    init();
  }

  // main entry point
  public static function main() {
    Lib.current.addChild(new Snake());
  }
}
