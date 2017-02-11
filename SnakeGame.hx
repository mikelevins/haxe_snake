import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

// ---------------------------------
// Apple 
// ---------------------------------

class Apple extends Sprite {
  
  private var color: Int;
  private var initialized = false;

  public function getColor () { return this.color; }
  
  private function init() {
    if (!initialized) {
      initialized = true;
      this.graphics.beginFill(SnakeGame.RED);
      this.graphics.drawCircle(0, 0, SnakeGame.scale/2);
      this.x = (Lib.current.stage.stageWidth - SnakeGame.scale) / 2;
      this.y = (Lib.current.stage.stageHeight - SnakeGame.scale) / 2;
    };
  }
  
  private function added(e) 
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
  private var color: Int;
  private var initialized = false;
  private var head:Sprite;
  private var tail:Array<Sprite>;

  public function getColor () { return this.color; }

  public function addToStage(x:Float, y:Float) {
    this.head.x = x;
    this.head.y = y;
    Lib.current.addChild(head);    
  }
  
  public function new(aColor:Int){
    this.color = aColor;
    this.head = new Sprite();
    this.tail = [];
    this.head.graphics.beginFill(aColor);
    this.head.graphics.drawCircle(0, 0, SnakeGame.scale/2);
  }
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

  public static function orientationX(orient:Array<Int>) { return orient[0]; }
  public static function orientationY(orient:Array<Int>) { return orient[1]; }

  // size of the game board's implicit grid
  public static var scale = 16;
  
  // private 
  // ----------------

  // the apple
  private static var apple:Apple;
  public static function theApple():Apple {return apple;};

  // the apple
  private static var snakes:Array<Snake>;
  public static function theSnakes():Array<Snake> { return snakes; };

  // main entry point
  // ----------------
  public static function main() 
  {
    var startX = (Lib.current.stage.stageWidth - scale) / 2;
    var startY = (Lib.current.stage.stageHeight - scale) / 2;
    
    apple = new Apple(RED);
    snakes = [(new Snake(GREEN)),
              (new Snake(CYAN)),
              (new Snake(BLUE))];

    var locations = [[startX-2*scale, startY+2*scale],
                     [startX, startY+2*scale],
                     [startX+2*scale, startY+2*scale]];

    for (i in 0...3) {
      var snake = snakes[i];
      var loc = locations[i];
      snake.addToStage(loc[0],loc[1]);
    }
    
    Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
    Lib.current.addChild(apple);

    
  };

}