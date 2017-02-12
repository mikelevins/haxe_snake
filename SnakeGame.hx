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

  // apple color
  public static var RED = 0xCC0000;

  // color constructor
  public static function rgb(r:Int,g:Int,b:Int) { return (r*256*256)+(g*256)+b; };
  
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
    var snakeCount = 4; // can be any nonnegative integer, but smaller is better
    var startX = (Lib.current.stage.stageWidth - scale) / 2;
    var startY = (Lib.current.stage.stageHeight - scale) / 2;
    
    apple = new Apple(RED);

    for (i in 0...snakeCount) {
      var xIncrement = Lib.current.stage.stageWidth/(1+snakeCount);
      var locX = xIncrement+(i*xIncrement);
      var locY = 3*scale+(Lib.current.stage.stageHeight - scale) / 2;
      var color:Int = rgb((128+Std.random(96)),(128+Std.random(96)),(128+Std.random(96)));
      var snake = new Snake(color);
      snake.addToStage(locX,locY);
    }
    
    Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
    Lib.current.addChild(apple);

    
  };

}