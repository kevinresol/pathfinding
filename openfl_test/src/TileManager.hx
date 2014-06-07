package ;
import com.kevinresol.pathfinding.ds.INodeManager;

/**
 * ...
 * @author Kevin
 */
class TileManager implements INodeManager<Tile>
{
	public var tiles:Array<Tile>;

	public function new() 
	{
		
	}
	
	public function init(gridWidth:Int, gridHeight:Int)
	{
		tiles = [];
		
		for (y in 0...gridHeight)
		{
			for (x in 0...gridWidth)
			{
				var walkable = Math.random() > 0.2;
				tiles.push(new Tile(x, y, walkable));
			}
		}
	}
	
	public function getNeighbours(tile:Tile):Array<Tile>
	{
		var result = [];
		for (t in tiles)
		{
			if (t == tile) continue;
			//if (Math.abs(t.gridX - tile.gridX) <= 1 && Math.abs(t.gridY - tile.gridY) <= 1)
			if (Math.abs(t.gridX - tile.gridX) + Math.abs(t.gridY - tile.gridY) == 1)
				result.push(t);
		}
		return result;
	}
	
	public function distanceBetween(tile1:Tile, tile2:Tile):Int 
	{
		var dx = Math.abs(tile1.gridX - tile2.gridX);
		var dy = Math.abs(tile1.gridY - tile2.gridY);
		
		if (dx == 1 && dy == 1) 
			return 141;
		else 
			return 100;
	}
}