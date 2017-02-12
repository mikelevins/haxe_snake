import flash.Lib;
import flash.display.Sprite;

class SnakeMain {
  private static var theGameBoard:GameBoard;

  // main entry point
  // ----------------
  public static function main() 
  {
    Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;

    var scale = 16;
    var columnCount = 40;
    var rowCount = 40;
    
    theGameBoard = new GameBoard(scale,columnCount,rowCount);
    Lib.current.addChild(theGameBoard);
  };
}
