package ;

import com.kevinresol.pathfinding.algorithm.astar.AStar;
import com.kevinresol.pathfinding.algorithm.hpastar.HPAStar;
import com.kevinresol.pathfinding.ds.SquareClusterManager;
import com.kevinresol.pathfinding.ds.SquareGrid;
import flash.display.GradientType;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Kevin
 */
class Test extends Sprite
{
	private var visualTiles:Array<DebugTile>;
	
	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	public function init(_) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		var map = [];
		
		// Random map
		var mapWidth = Std.int(stage.stageWidth / DebugTile.WIDTH);
		var mapHeight = Std.int(stage.stageHeight / DebugTile.HEIGHT);		
		for (y in 0...mapHeight)
		{
			map[y] = [];
			for (x in 0...mapWidth)
			{
				map[y][x] = Math.random() > 0.2 ? 1 : 0;
			}
		}
		
		//map = [
		//[1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		//[1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		//[1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		//[1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		//[1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		//[1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		//[1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		//[1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		//[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		//[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		//];
		
		
		
		var grid = new SquareGrid(map);
		visualTiles = [];
		for (t in grid.tiles)
		{
			var tile = new DebugTile(t.x * DebugTile.WIDTH, t.y * DebugTile.HEIGHT, DebugTile.WIDTH, DebugTile.HEIGHT, t.walkable ? 0 : 0xffffff);
			visualTiles.push(tile);
			addChild(tile);
		}
		
		var p = new HPAStar(1, new SquareClusterManager(grid, 10, 10));
		for (c in p.clusters[1])
		{
			var clusterTile = new DebugTile(c.offsetX * DebugTile.WIDTH, c.offsetY * DebugTile.HEIGHT,
				c.width * DebugTile.WIDTH, c.height * DebugTile.HEIGHT, 0);
			clusterTile.drawBorder(0x00ff00);
			addChild(clusterTile);
			for (n in c.entranceNodes)
			{
				if(c.x==0 && c.y==0)
					trace(n);
				getVisualTile(n.x, n.y).fillColor(0xff00ff, 0.5);
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
		
		//origin = grid.getTile(0, 0);
		//destination = grid.getTile(3, 0);
		
		getVisualTile(origin.x, origin.y).setAsOrigin();
		getVisualTile(destination.x, destination.y).setAsDestination();
		
		
		var path = p.findPath(origin, destination);
		
		trace(path);
		
		if (path != null)
		{
			for (tile in path)
			{
				if (tile != origin && tile != destination)
					getVisualTile(tile.x, tile.y).fillColor(0x0000ff, 1);
				
			}	
			
			var line = new Shape();			
			line.graphics.lineStyle(2, 0x00ffff);
			addChild(line);
			for (i in 0...path.length)
			{
				var from = path[i];
				var to = path[i + 1];
				
				if (from == null || to == null) continue;
				
				var fromX = (from.x + 0.5) * DebugTile.WIDTH;
				var fromY = (from.y + 0.5) * DebugTile.HEIGHT;
				
				var toX = (to.x + 0.5) * DebugTile.WIDTH;
				var toY = (to.y + 0.5) * DebugTile.HEIGHT;
				trace(i, fromX, fromY, toX, toY);
				line.graphics.moveTo(fromX, fromY);
				line.graphics.lineTo(toX, toY);
				
			}
		}
	}
	
	
	private function getVisualTile(x:Int, y:Int):DebugTile
	{
		for (t in visualTiles)
			if (t.x / DebugTile.WIDTH == x && t.y / DebugTile.HEIGHT == y) return t;
		return null;
	}
}