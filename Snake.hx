import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

class Snake extends Sprite {
  public static var RED = 0xCC0000;
  public static var ORANGE = 0xCC6600;
  public static var YELLOW = 0xCCCC00;
  public static var GREEN = 0x00CC00;
  public static var BLUE = 0x0000CC;
  public static var PURPLE = 0xCC00CC;
  // size of the game board's implicit grid
  public static var scale = 16;

  private var theApple: Sprite;
  private var theSnake: Sprite;
  private var isInitialized = false;
  // the unique apple

  private function keyUp (event:KeyboardEvent){
    switch( event.keyCode ) {
    case 38: // KEY_UP
      theSnake.y -= scale;
    case 40: // KEY_DOWN
      theSnake.y += scale;
    case 39: // KEY_RIGHT
      theSnake.x += scale;
    case 37: // KEY_LEFT
      theSnake.x -= scale;
    }
  };

  function init() {
    if (isInitialized) return;
    isInitialized = true;

    theApple = new Sprite();
    theApple.graphics.beginFill(RED);
    theApple.graphics.drawCircle(0, 0, scale/2);
    theApple.x = (stage.stageWidth - scale) / 2;
    theApple.y = (stage.stageHeight - scale) / 2;

    Lib.current.stage.addChild(theApple);

    theSnake = new Sprite();
    theSnake.graphics.beginFill(GREEN);
    theSnake.graphics.drawCircle(0, 0, scale/2);
    theSnake.x = (stage.stageWidth - scale) / 2;
    theSnake.y = (stage.stageHeight - scale) / 2;

    Lib.current.stage.addChild(theSnake);
    

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
