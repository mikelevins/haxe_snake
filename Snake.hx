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
  public static var NORTH = [0,-1];
  public static var EAST = [1,0];
  public static var SOUTH = [0,1];
  public static var WEST = [-1,0];

  public var head:Sprite;
  public var orientation = NORTH;
  public var color: Int;

  public function new( aColor: Int ) {
    this.color = aColor;
    head = new Sprite();
    Lib.current.stage.addChild(head);
    head.graphics.beginFill(this.color);
    head.graphics.drawCircle(0, 0, Snake.scale/2);
    head.x = (Lib.current.stage.stageWidth - Snake.scale) / 2;
    head.y = (Lib.current.stage.stageHeight - Snake.scale) / 2;
  };

  private function orientationX (){return orientation[0];}
  private function orientationY (){return orientation[1];}

  public function advance(){
    head.x += Snake.scale*orientationX();
    head.y += Snake.scale*orientationY();
  }
  
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
  private var blueSnake: SnakeActor;

  private var isInitialized = false;
  // the unique apple

  private function keyUp (event:KeyboardEvent){
    switch( event.keyCode ) {
      // greenSnake
    case 38: // KEY_UP
      greenSnake.orientation=SnakeActor.NORTH;
    case 40: // KEY_DOWN
      greenSnake.orientation=SnakeActor.SOUTH;
    case 39: // KEY_RIGHT
      greenSnake.orientation=SnakeActor.EAST;
    case 37: // KEY_LEFT
      greenSnake.orientation=SnakeActor.WEST;

      // cyanSnake
    case 87: // w
      cyanSnake.orientation=SnakeActor.NORTH;
    case 83: // s
      cyanSnake.orientation=SnakeActor.SOUTH;
    case 68: // d
      cyanSnake.orientation=SnakeActor.EAST;
    case 65: // a
      cyanSnake.orientation=SnakeActor.WEST;

      // blueSnake
    case 73: // i
      blueSnake.orientation=SnakeActor.NORTH;
    case 75: // k
      blueSnake.orientation=SnakeActor.SOUTH;
    case 74: // j
      blueSnake.orientation=SnakeActor.WEST;
    case 76: // l
      blueSnake.orientation=SnakeActor.EAST;

      // advance snakes
    case 32: // space
      greenSnake.advance();
      cyanSnake.advance();
      blueSnake.advance();
      
    default:
      trace(event.keyCode);
    }
  };

  function init() {
    if (isInitialized) return;
    isInitialized = true;

    theApple = new AppleActor();
    greenSnake = new SnakeActor(GREEN);
    cyanSnake = new SnakeActor(CYAN);
    blueSnake = new SnakeActor(BLUE);

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
