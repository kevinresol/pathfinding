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
	public var width:Int;
	public var height:Int;
	
	public var nodes:Array<SquareTile>;

	public function new(x:Int, y:Int, width:Int, height:Int, nodes:Array<SquareTile>) 
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.nodes = nodes;
	}
	
	/**
	 * 
	 * @param	node
	 * @return	neighbours within the cluster
	 */
	public function getNeighbours(node:SquareTile):Array<SquareTile>
	{
		var neighbours = [];
		for (n in nodes)
		{
			if (n != node && distanceBetween(n, node) <= 141)
				neighbours.push(n);
		}
		return neighbours;
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
		for (n in nodes)
			if (n.y == y) result.push(n);
		return result;
	}
	
	public function getColumn(x:Int):Array<SquareTile>
	{
		var result = [];
		for (n in nodes)
			if (n.x == x) result.push(n);
		return result;
	}
	
	public function contains(tile:SquareTile):Bool
	{
		return tile.x >= x * width && tile.x < (x + 1) * width
			&& tile.y >= y * height && tile.y < (y + 1) * height;
	}
}
