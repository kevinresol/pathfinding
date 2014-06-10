package ;
import com.kevinresol.pathfinding.ds.INode;
import flash.display.Sprite;

/**
 * ...
 * @author Kevin
 */
class DebugTile extends Sprite
{
	public static inline var WIDTH:Int = 20;
	public static inline var HEIGHT:Int = 20;
	
	private var drawWidth:Float;
	private var drawHeight:Float;
	
	public function new(x:Float, y:Float, width:Float, height:Float, color:UInt) 
	{
		super();
		
		this.x = x;
		this.y = y;
		
		drawWidth = width;
		drawHeight = height;
		
		fillColor(color, 1);
	}
	
	override public function toString():String
	{
		return '[Tile: ${x/HEIGHT}, ${y/HEIGHT}]';
	}
	
	public function fillColor(color:UInt, alpha:Float):Void
	{
		graphics.beginFill(color, alpha);
			
		graphics.lineStyle(1, 0xffffff, 1);
		graphics.drawRect(0, 0, drawWidth, drawHeight);
		
		graphics.endFill();
	}
	
	public function drawBorder(color:UInt)
	{
		graphics.clear();
		graphics.lineStyle(1, color, 1);
		graphics.drawRect(0, 0, drawWidth, drawHeight);
	}
	
	public function setAsOrigin():Void
	{
		fillColor(0xff0000, 1);
	}
	
	public function setAsDestination():Void
	{
		fillColor(0x00ff00, 1);
	}
	
}