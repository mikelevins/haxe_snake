import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

class Snake extends Sprite {
  public static var RED = 0xCC0000;
  public static var ORANGE = 0xCC6600;
  public static var YELLOW = 0xCCCC00;
  public static var GREEN = 0x00CC00;
  public static var CYAN = 0x00CCCC;
  public static var BLUE = 0x0000CC;
  public static var PURPLE = 0xCC00CC;
  // size of the game board's implicit grid
  public static var scale = 16;

  private var theApple: Sprite;
  private var greenSnake: Sprite;
  private var cyanSnake: Sprite;

  private var isInitialized = false;
  // the unique apple

  private function keyUp (event:KeyboardEvent){
    switch( event.keyCode ) {
      // greenSnake
    case 38: // KEY_UP
      greenSnake.y -= scale;
    case 40: // KEY_DOWN
      greenSnake.y += scale;
    case 39: // KEY_RIGHT
      greenSnake.x += scale;
    case 37: // KEY_LEFT
      greenSnake.x -= scale;

      // cyanSnake
    case 87: // w
      cyanSnake.y -= scale;
    case 83: // s
      cyanSnake.y += scale;
    case 68: // d
      cyanSnake.x += scale;
    case 65: // s
      cyanSnake.x -= scale;

    default:
      trace(event.keyCode);
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

    greenSnake = new Sprite();
    greenSnake.graphics.beginFill(GREEN);
    greenSnake.graphics.drawCircle(0, 0, scale/2);
    greenSnake.x = (stage.stageWidth - scale) / 2;
    greenSnake.y = (stage.stageHeight - scale) / 2;    
    Lib.current.stage.addChild(greenSnake);

    cyanSnake = new Sprite();
    cyanSnake.graphics.beginFill(CYAN);
    cyanSnake.graphics.drawCircle(0, 0, scale/2);
    cyanSnake.x = (stage.stageWidth - scale) / 2;
    cyanSnake.y = (stage.stageHeight - scale) / 2;    
    Lib.current.stage.addChild(cyanSnake);    

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
