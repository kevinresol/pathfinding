package ;
import com.kevinresol.pathfinding.ds.INode;
import flash.display.Sprite;

/**
 * ...
 * @author Kevin
 */
class Tile extends Sprite implements INode
{
	public static inline var WIDTH:Int = 20;
	public static inline var HEIGHT:Int = 20;
	
	public var gridX:Int;
	public var gridY:Int;
		
	public var level:Int;
	public var walkable:Bool;
	
	
	public function new(gridX:Int, gridY:Int, walkable:Bool) 
	{
		super();
		
		this.gridX = gridX;
		this.gridY = gridY;
		this.walkable = walkable;
		
		x = gridX * WIDTH;
		y = gridY * HEIGHT;
		
		fillColor(0xffffff, walkable ? 0 : 1);
	}
	
	override public function toString():String
	{
		return '[Tile: $gridX, $gridY, $walkable]';
	}
	
	public function fillColor(color:UInt, alpha:Float):Void
	{
		graphics.beginFill(color, alpha);
			
		graphics.lineStyle(1, 0xffffff, 1);
		graphics.drawRect(0, 0, WIDTH, HEIGHT);
		
		graphics.endFill();
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