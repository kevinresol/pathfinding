package com.kevinresol.pathfinding.ds;
import com.kevinresol.pathfinding.algorithm.hpastar.Entrance;
import com.kevinresol.pathfinding.ds.IClusterManager;
import com.kevinresol.pathfinding.util.Distance;

/**
 * ...
 * @author Kevin
 */
class SquareGrid implements INodeManager<SquareTile>
{
	public var width:Int;
	public var height:Int;
	public var tiles:Array<SquareTile>;

	public function new(map:Array<Array<Int>>) 
	{
		tiles = [];
		
		width = map[0].length;
		height = map.length;
		
		for (y in 0...height)
		{
			for (x in 0...width)
			{
				var walkable = map[y][x] != 0;
				var tile = new SquareTile(x, y, walkable);
				setTile(x, y, tile);
			}
		}
	}
	
	public inline function setTile(x:Int, y:Int, tile:SquareTile):Void
	{
		tiles[y * width + x] = tile;
	}
	
	public inline function getTile(x:Int, y:Int):SquareTile
	{
		if (x < 0 || x >= width || y < 0 || y >= height)
			return null;
		else 
			return tiles[y * width + x];
	}
	
	public function getTiles(offsetX:Int, offsetY:Int, width:Int, height:Int):Array<SquareTile>
	{
		var result = [];
		for (x in offsetX...offsetX + width)
		{
			for (y in offsetY...offsetY + height)
			{
				result.push(getTile(x, y));
			}
		}
		return result;
	}
	
	
	public function distanceBetween(node1:SquareTile, node2:SquareTile):Int 
	{
		var dx = node1.x - node2.x;
		var dy = node1.y - node2.y;
		
		return Distance.onlyStraightAndDiagonal(dx, dy);
	}
	
	public function getNeighbours(tile:SquareTile):Array<SquareTile> 
	{
		var result = [];
		
		var t = getTile(tile.x, tile.y - 1);
		var b = getTile(tile.x, tile.y + 1);
		var l = getTile(tile.x - 1, tile.y);
		var r = getTile(tile.x + 1, tile.y);
		var tl = getTile(tile.x - 1, tile.y - 1);
		var bl = getTile(tile.x - 1, tile.y + 1);
		var tr = getTile(tile.x + 1, tile.y - 1);
		var br = getTile(tile.x + 1, tile.y + 1);
		
		if(t != null)
			result.push(t);
		if(b != null)
			result.push(b);
		if(l != null)
			result.push(l);
		if(r != null)
			result.push(r);
		if (tr != null && t.walkable && r.walkable)
			result.push(tr);
		if (tl != null && t.walkable && l.walkable)
			result.push(tl);
		if (br != null && b.walkable && r.walkable)
			result.push(br);
		if (bl != null && b.walkable && l.walkable)
			result.push(bl);
		
		return result;
	}
	
}