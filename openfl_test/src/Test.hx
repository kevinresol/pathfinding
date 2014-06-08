package ;

import com.kevinresol.pathfinding.algorithm.astar.AStar;
import com.kevinresol.pathfinding.algorithm.hpastar.HPAStar;
import com.kevinresol.pathfinding.ds.SquareClusterManager;
import com.kevinresol.pathfinding.ds.SquareGrid;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Kevin
 */
class Test extends Sprite
{
	private var visualTiles:Array<Tile>;
	
	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	public function init(_) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		var map = [];
		var mapWidth = Std.int(stage.stageWidth / Tile.WIDTH);
		var mapHeight = Std.int(stage.stageHeight / Tile.HEIGHT);
		
		for (y in 0...mapHeight)
		{
			map[y] = [];
			for (x in 0...mapWidth)
			{
				map[y][x] = Math.random() > 0.2 ? 1 : 0;
			}
		}
		
		var grid = new SquareGrid(map);
		visualTiles = [];
		for (t in grid.tiles)
		{
			var tile = new Tile(t.x, t.y, t.walkable);
			visualTiles.push(tile);
			addChild(tile);
		}
		
		var p = new HPAStar(1, new SquareClusterManager(grid, 10, 10));
		for (c in p.clusters[1])
		{
			
			for (n in c.entranceNodes)
			{
				
				getVisualTile(n.x, n.y).fillColor(0xff0000, 0.5);
			}
		}
		
		var origin;
		var destination;
		
		do 
		{
			origin = grid.tiles[Std.int(Math.random() * grid.tiles.length)];
		}
		while (!origin.walkable);
			
			
		do
		{
			destination = grid.tiles[Std.int(Math.random() * grid.tiles.length)];
		}
		while  (!destination.walkable);
		
		getVisualTile(origin.x, origin.y).setAsOrigin();
		getVisualTile(destination.x, destination.y).setAsDestination();
		
		
		var path = p.findPath(origin, destination);
		
		if (path != null)
			for (tile in path)
				if (tile != origin && tile != destination)
					getVisualTile(tile.x, tile.y).fillColor(0x0000ff, 1);
	}
	
	
	private function getVisualTile(x:Int, y:Int):Tile
	{
		for (t in visualTiles)
			if (t.gridX == x && t.gridY == y) return t;
		return null;
	}
}