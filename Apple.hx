import flash.Lib;
import flash.display.Sprite;


// ---------------------------------
// Apple 
// ---------------------------------
// the apple that the snakes eat

class Apple extends Sprite {
  private var color:Int;
  private var radius:Int;

  public function new ( scale:Int ) {
    super();
    this.color = Colors.RED;
    this.radius = Std.int( scale/2 );
    this.graphics.beginFill(this.color);
    this.graphics.drawCircle(0, 0, this.radius);
  }
}