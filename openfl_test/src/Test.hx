package ;

import com.kevinresol.pathfinding.algorithm.astar.AStar;
import com.kevinresol.pathfinding.algorithm.hpastar.HPAStar;
import flash.display.Sprite;

/**
 * ...
 * @author Kevin
 */
class Test extends Sprite
{
	

	public function new() 
	{
		super();
		
		var m = new TileManager();
		m.init(25, 15);
		
		for (t in m.tiles)
			addChild(t);
			
		
		var p = new AStar(m);
		var pp = new HPAStar();
		
		var origin;
		var destination;
		
		do 
		{
			origin = m.tiles[Std.int(Math.random() * m.tiles.length)];
		}
		while (!origin.walkable);
			
			
		do
		{
			destination = m.tiles[Std.int(Math.random() * m.tiles.length)];
		}
		while  (!destination.walkable);
		
		
		origin.setAsOrigin();
		destination.setAsDestination();
		
		trace(origin, destination);
		var path = p.findPath(origin, destination);
		
		if(path != null)
		for (tile in path)
		{
			if(tile != origin && tile != destination)
				tile.fillColor(0x0000ff, 1);
		}
	}
	
}