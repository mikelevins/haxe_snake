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
  private var orientation: Array<Int>;
  private var initialized = false;
  private var head:Sprite;
  private var tail:Array<Sprite>;

  public function getColor () { return this.color; }

  public function addToStage(x:Float, y:Float) {
    this.head.x = x;
    this.head.y = y;
    Lib.current.addChild(head);    
  }

  private function addSegment(x:Float,y:Float) {
    var sprite = new Sprite();
    sprite.graphics.beginFill(color);
    sprite.graphics.drawCircle(0, 0, SnakeGame.scale/2);
    sprite.x = x;
    sprite.y = y;
    this.tail.insert(0,sprite);
    Lib.current.addChild(sprite);        
  }
  
  public function advance () {
    var lastX = this.head.x;
    var lastY = this.head.y;
    this.head.x += SnakeGame.scale*SnakeGame.orientationX(this.orientation);
    this.head.y += SnakeGame.scale*SnakeGame.orientationY(this.orientation);
    addSegment(lastX,lastY);
  }
  
  public function new(aColor:Int, anOrientation:Array<Int>){
    this.color = aColor;
    this.orientation = anOrientation;
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
  private static var snakes:Array<Snake> = [];
  public static function theSnakes():Array<Snake> { return snakes; };

  // game updates
  private static function advance ( snake:Snake ) {
    snake.advance();
  }
  
  // main entry point
  // ----------------
  public static function main() 
  {
    // we can support any number of colors and snakes, but
    // we must supply sets of control keys for each; picking
    // convenient control keys limits the number of practical
    // choices. I toyed with the idea of implementing a control
    // scheme in which you press one or more number keys to
    // indicate which snake to control, but that contradicted the
    // stated requirements, so instead I supply one color and one
    // set of control keys for each snake

    //snake colors
    var ORANGE = 0xEEAA00;
    var YELLOW = 0xEEEE00;
    var GREEN  = 0x00EE00;
    var CYAN   = 0x00EEEE;
    var BLUE   = 0x0000EE;
    var PURPLE = 0xEE00EE;

    // snakes
    snakes.push(new Snake(ORANGE, NORTH));
    snakes.push(new Snake(GREEN, NORTH));
    snakes.push(new Snake(BLUE, NORTH));

    var snakeCount = snakes.length; // can be any nonnegative integer, but smaller is better
    
    apple = new Apple(RED);

    for (i in 0...snakeCount) {
      var xIncrement = Lib.current.stage.stageWidth/(1+snakeCount);
      var locX = xIncrement+(i*xIncrement);
      var locY = 3*scale+(Lib.current.stage.stageHeight - scale) / 2;
      var color:Int = rgb((128+Std.random(96)),(128+Std.random(96)),(128+Std.random(96)));
      var snake = snakes[i];
      snake.addToStage(locX,locY);
    }
    
    Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
    Lib.current.addChild(apple);
    Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP,
                                        function (event:KeyboardEvent) {
                                          switch( event.keyCode ) {
                                            // advance snakes
                                          case 32: // space
                                            for (snake in snakes) { advance(snake); }
                                          default:
                                            trace(event.keyCode);
                                          }
                                        });

    
  };

}