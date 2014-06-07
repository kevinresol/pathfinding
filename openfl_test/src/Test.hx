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
		var visualTiles = [];
		for (t in grid.tiles)
		{
			var tile = new Tile(t.x, t.y, t.walkable);
			visualTiles.push(tile);
			addChild(tile);
		}
		
		var p = new AStar(grid);
		
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
		
		for (vt in visualTiles)
		{
			if (vt.gridX == origin.x && vt.gridY == origin.y) vt.setAsOrigin();
			if (vt.gridX == destination.x && vt.gridY == destination.y) vt.setAsDestination();
		}
		
		var path = p.findPath(origin, destination);
		
		if (path != null)
			for (tile in path)
				if (tile != origin && tile != destination)
					for (vt in visualTiles)
						if (vt.gridX == tile.x && vt.gridY == tile.y) vt.fillColor(0x0000ff, 1);
	}
	
	
	
}