import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

// ---------------------------------
// Orientations 
// ---------------------------------

class Orientation {
  public static var UP = [0,-1];
  public static var DOWN = [0,1];
  public static var LEFT = [-1,0];
  public static var RIGHT = [1,0];

  public static function xComponent(orient:Array<Int>) { return orient[0]; };
  public static function yComponent(orient:Array<Int>) { return orient[1]; };
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
    Lib.current.stage.addChild(head);    
  }

  private function addSegment(x:Float,y:Float) {
    var sprite = new Sprite();
    sprite.graphics.beginFill(color);
    sprite.graphics.drawCircle(0, 0, SnakeGame.getScale()/2);
    sprite.x = x;
    sprite.y = y;
    this.tail.insert(0,sprite);
    Lib.current.addChild(sprite);        
  }
  
  public function advance () {
    this.head.x += SnakeGame.getScale()*Orientation.xComponent(orientation);
    this.head.y += SnakeGame.getScale()*Orientation.yComponent(orientation);
  }
  
  public function new(aColor:Int, orient:Array<Int>){
    this.color = aColor;
    this.orientation = orient;
    this.head = new Sprite();
    this.tail = [];
    this.head.graphics.beginFill(aColor);
    this.head.graphics.drawCircle(0, 0, SnakeGame.getScale()/2);
  }
}

// ---------------------------------
// the main class: SnakeGame 
// ---------------------------------

class SnakeGame {
  // colors
  private static var RED    = 0xEE0000;
  private static var ORANGE = 0xEEAA00;
  private static var YELLOW = 0xEEEE00;
  private static var GREEN  = 0x00EE00;
  private static var CYAN   = 0x00EEEE;
  private static var BLUE   = 0x0000EE;
  private static var PURPLE = 0xEE00EE;

  // the game board
  private static var scale = 16;
  public static function getScale() { return scale; };
  
  public static function getColumns() { return Std.int(Lib.current.stage.stageWidth / scale); }
  public static function getRows() { return Std.int(Lib.current.stage.stageHeight / scale); }

  public static function coordinateForColumn(columnIndex:Int) { return ((2*columnIndex+1)*scale/2); }
  public static function coordinateForRow(rowIndex:Int) { return ((2*rowIndex+1)*scale/2); }

  public static function columnForCoordinate(coordinate:Int) { return Math.floor(coordinate/scale); }
  public static function rowForCoordinate(coordinate:Int) { return Math.floor(coordinate/scale); }

  // the apple
  private static var theApple:Sprite;

  private static function makeTheApple():Sprite{
    var apple = new Sprite();
    apple.graphics.beginFill(RED);
    apple.graphics.drawCircle(0, 0, scale/2);
    apple.x = coordinateForColumn(Std.int(getColumns()/2));
    apple.y = coordinateForRow(Std.int(getRows()/2));
    return apple;
  };

  // the snakes
  private static var theSnakes:Array<Snake> = [];
  
  // game updates
  private static function isOccupied(column:Int, row:Int):Bool {
    return false;
  };

  private static function anyRow(){
    return Std.random(getRows());
  }

  private static function anyColumn(){
    return Std.random(getRows());
  }
                                                          
  private static function moveTheApple(){
    var newRow = anyRow();
    var newColumn = anyColumn();
    if (isOccupied(newColumn,newRow)) {
      moveTheApple();
    } else {
      theApple.x = coordinateForColumn(newColumn);
      theApple.y = coordinateForRow(newRow);
    };
  }

  private static function advance( ){
    for (snake in theSnakes) {
      snake.advance();
    }    
  };

  // key events
  private static function keyUp (event:KeyboardEvent ) {
    switch( event.keyCode ) {
      // advance snakes
    case 32: // space
      advance();
    default:
      trace(event.keyCode);
    }
    
  };
  
  // main entry point
  // ----------------
  public static function main() 
  {
    theApple = makeTheApple();
    theSnakes.push(new Snake(GREEN,Orientation.UP));
    Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
    Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, keyUp);
    Lib.current.stage.addChild(theApple);
    for (snake in theSnakes) {
      snake.addToStage(coordinateForColumn(anyColumn()),coordinateForRow(anyRow()));
    }
  };

}