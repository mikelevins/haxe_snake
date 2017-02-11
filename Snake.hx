import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

enum Orientation {
  North;
  East;
  South;
  West;
}

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
  public var tail:Array<Sprite>;
  public var orientation = Orientation.North;
  public var color: Int;

  public function new( aColor: Int ) {
    this.color = aColor;
    head = new Sprite();
    tail = [new Sprite()];
    
    Lib.current.stage.addChild(head);
    
    head.graphics.beginFill(this.color);
    head.graphics.drawCircle(0, 0, Snake.scale/2);
    head.x = (Lib.current.stage.stageWidth - Snake.scale) / 2;
    head.y = (Lib.current.stage.stageHeight - Snake.scale) / 2;
  };

  function borderCrossing(x:Float,y:Float):Bool {return false;};
  function alreadySnakeActor(x:Float,y:Float):Bool{return false;};
  function killSnakeActor(){return;};
  function maybeAddCell(x:Float,y:Float,oldX:Float,oldY:Float){return;};
  
  public function advance(){
    var previousX = head.x;
    var previousY = head.y;
    head.x += Snake.scale*Snake.orientationX(orientation);
    head.y += Snake.scale*Snake.orientationY(orientation);
    if (borderCrossing(head.x,head.y)) killSnakeActor();
    if (alreadySnakeActor(head.x,head.y)) killSnakeActor();
    maybeAddCell(head.x,head.y,previousX,previousY);
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

  public static function orientationX(orient:Orientation){
    switch ( orient ) {
    case Orientation.North: return 0;
    case Orientation.East: return 1;
    case Orientation.South: return 0;
    case Orientation.West: return -1;
    }
  }

  public static function orientationY(orient:Orientation){
    switch ( orient ) {
    case Orientation.North: return -1;
    case Orientation.East: return 0;
    case Orientation.South: return 1;
    case Orientation.West: return 0;
    }
  }
  
  private function keyUp (event:KeyboardEvent){
    switch( event.keyCode ) {
      // greenSnake
    case 38: // KEY_UP
      greenSnake.orientation=Orientation.North;
    case 40: // KEY_DOWN
      greenSnake.orientation=Orientation.South;
    case 39: // KEY_RIGHT
      greenSnake.orientation=Orientation.East;
    case 37: // KEY_LEFT
      greenSnake.orientation=Orientation.West;

      // cyanSnake
    case 87: // w
      cyanSnake.orientation=Orientation.North;
    case 83: // s
      cyanSnake.orientation=Orientation.South;
    case 68: // d
      cyanSnake.orientation=Orientation.East;
    case 65: // a
      cyanSnake.orientation=Orientation.West;

      // blueSnake
    case 73: // i
      blueSnake.orientation=Orientation.North;
    case 75: // k
      blueSnake.orientation=Orientation.South;
    case 74: // j
      blueSnake.orientation=Orientation.West;
    case 76: // l
      blueSnake.orientation=Orientation.East;

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
