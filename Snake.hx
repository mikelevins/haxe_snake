import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

class AppleActor {
  private var sprite:Sprite;

  public function new() 
  {
    sprite = new Sprite();
    Lib.current.stage.addChild(sprite);
    sprite.graphics.beginFill(Snake.RED);
    sprite.graphics.drawCircle(0, 0, Snake.scale/2);
    sprite.x = (Lib.current.stage.stageWidth - Snake.scale) / 2;
    sprite.y = (Lib.current.stage.stageHeight - Snake.scale) / 2;
  };
}

class SnakeActor {
  public var head:Sprite;
  public function new() 
  {
    head = new Sprite();
    Lib.current.stage.addChild(head);
    head.graphics.beginFill(Snake.GREEN);
    head.graphics.drawCircle(0, 0, Snake.scale/2);
    head.x = (Lib.current.stage.stageWidth - Snake.scale) / 2;
    head.y = (Lib.current.stage.stageHeight - Snake.scale) / 2;
  };
  
}

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

  private var theApple: AppleActor;
  private var greenSnake: SnakeActor;
  private var cyanSnake: SnakeActor;

  private var isInitialized = false;
  // the unique apple

  private function keyUp (event:KeyboardEvent){
    switch( event.keyCode ) {
      // greenSnake
    case 38: // KEY_UP
      greenSnake.head.y -= scale;
    case 40: // KEY_DOWN
      greenSnake.head.y += scale;
    case 39: // KEY_RIGHT
      greenSnake.head.x += scale;
    case 37: // KEY_LEFT
      greenSnake.head.x -= scale;

      // cyanSnake
    case 87: // w
      cyanSnake.head.y -= scale;
    case 83: // s
      cyanSnake.head.y += scale;
    case 68: // d
      cyanSnake.head.x += scale;
    case 65: // s
      cyanSnake.head.x -= scale;

    default:
      trace(event.keyCode);
    }
  };

  function init() {
    if (isInitialized) return;
    isInitialized = true;

    theApple = new AppleActor();
    greenSnake = new SnakeActor();
    cyanSnake = new SnakeActor();

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
