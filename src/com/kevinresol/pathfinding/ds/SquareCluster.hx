package com.kevinresol.pathfinding.ds;
import com.kevinresol.pathfinding.ds.ICluster;
import com.kevinresol.pathfinding.ds.INode;
import com.kevinresol.pathfinding.util.Distance;

/**
 * ...
 * @author Kevin
 */
class SquareCluster implements ICluster<SquareTile>
{
	public var x:Int;
	public var y:Int;
	public var offsetX:Int;
	public var offsetY:Int;
	public var width:Int;
	public var height:Int;
	
	public var entranceNodes:Array<SquareTile>;
	public var tiles:Array<SquareTile>;

	public function new(x:Int, y:Int, offsetX:Int, offsetY:Int, width:Int, height:Int, tiles:Array<SquareTile>) 
	{
		this.x = x;
		this.y = y;
		this.offsetX = offsetX;
		this.offsetY = offsetY;
		this.width = width;
		this.height = height;
		this.tiles = tiles;
		this.entranceNodes = [];
	}
	
	public function getTile(x:Int, y:Int):SquareTile
	{
		var relativeX = x - offsetX;
		var relativeY = y - offsetY;
		
		if (relativeX < 0 || relativeX >= width || relativeY < 0 || relativeY >= height)
			return null;
		else
			return tiles[relativeY * width + relativeX];
	}
	
	public function setTile(x:Int, y:Int, tile:SquareTile):Void
	{
		var relativeX = x - offsetX;
		var relativeY = y - offsetY;		
		
		tiles[relativeY * width + relativeX] = tile;
	}
	
	/**
	 * 
	 * @param	node
	 * @return	neighbours within the cluster
	 */
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
	
	public function distanceBetween(node1:SquareTile, node2:SquareTile):Int 
	{
		var dx = node1.x - node2.x;
		var dy = node1.y - node2.y;
		
		return Distance.onlyStraightAndDiagonal(dx, dy);
	}
	
	public function getRow(y:Int):Array<SquareTile>
	{
		var result = [];
		y += offsetY;
		for (t in tiles)
			if (t.y == y) result.push(t);
		return result;
	}
	
	public function getColumn(x:Int):Array<SquareTile>
	{
		var result = [];
		x += offsetX;
		for (t in tiles)
			if (t.x == x) result.push(t);
		return result;
	}
	
	public function contains(tile:SquareTile):Bool
	{
		return tile.x >= offsetX && tile.x < offsetX + width
			&& tile.y >= offsetY && tile.y < offsetY + height;
	}
	
	public function toString():String
	{
		return '[SquareCluster: x=$x, y=$y, width=$width, height=$height]';
	}
}
