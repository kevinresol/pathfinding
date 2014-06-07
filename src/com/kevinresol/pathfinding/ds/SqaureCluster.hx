package com.kevinresol.pathfinding.ds;
import com.kevinresol.pathfinding.ds.ICluster;
import com.kevinresol.pathfinding.ds.INode;

/**
 * ...
 * @author Kevin
 */
class SqaureCluster<TNode:INode> implements ICluster<TNode>
{
	public var nodes:Array<TNode>;

	public function new() 
	{
		
	}
	
	/**
	 * 
	 * @param	node
	 * @return	neighbours within the cluster
	 */
	public function getNeighbours(node:TNode):Array<TNode>
	{
		var neighbours = [];
		for (n in nodes)
		{
			if (n != node && n.distanceBetween(node) <= 1.41)
				neighbours.push(n);
		}
		return neighbours;
	}
	
}