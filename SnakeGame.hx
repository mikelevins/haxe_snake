import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

// ---------------------------------
// Apple 
// ---------------------------------

class Apple extends Sprite {
  public var color: Int;
  private var isInitialized = false;

  function init() {
    if (!isInitialized) {
      isInitialized = true;
      this.graphics.beginFill(SnakeGame.RED);
      this.graphics.drawCircle(0, 0, SnakeGame.scale/2);
      this.x = (Lib.current.stage.stageWidth - SnakeGame.scale) / 2;
      this.y = (Lib.current.stage.stageHeight - SnakeGame.scale) / 2;
    };
  }
  
  function added(e) 
  {
    removeEventListener(Event.ADDED_TO_STAGE, added);
    init();
  };

  public function new(aColor:Int){
    super();
    this.color = aColor;
    addEventListener(Event.ADDED_TO_STAGE, added);
  }
}

// ---------------------------------
// Snake 
// ---------------------------------

class Snake {
}

// ---------------------------------
// the main class: SnakeGame 
// ---------------------------------

class SnakeGame {
  // public 
  // ----------------
  // colors
  public static var RED = 0xCC0000;
  public static var GREEN = 0x00CC00;
  public static var CYAN = 0x00CCCC;
  public static var BLUE = 0x0000CC;

  // orientations
  public static var NORTH = [0,-1];
  public static var SOUTH = [0,1];
  public static var EAST = [1,0];
  public static var WEST = [-1,0];

  public static function orientationX(orient:Array<Int>) {return orient[0];}
  public static function orientationY(orient:Array<Int>) {return orient[1];}

  // size of the game board's implicit grid
  public static var scale = 16;

  // private 
  // ----------------

  // the apple
  private static var apple:Apple;
  public static function theApple():Apple {return apple;};

  // the apple
  private static var snakes:Array<Snake>;
  public static function theSnakes():Array<Snake> {return snakes;};

  // main entry point
  // ----------------
  public static function main() 
  {
    apple = new Apple(RED);
    
    Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
    Lib.current.addChild(apple);
  };

}