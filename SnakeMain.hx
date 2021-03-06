import flash.Lib;
import flash.display.Sprite;

// ---------------------------------
// SnakeMain 
// ---------------------------------
// the main class and entry point
// this code creates the GameBoard
// and adds it to the stage, beginning
// the game.

class SnakeMain {
  private static var theGameBoard:GameBoard;

  // main entry point
  // ----------------
  public static function main() 
  {
    Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;

    // build-time game parameters
    var scale = 16;
    var columnCount = 60;
    var rowCount = 40;
    
    theGameBoard = new GameBoard(scale,columnCount,rowCount);
    Lib.current.addChild(theGameBoard);
  };
}
