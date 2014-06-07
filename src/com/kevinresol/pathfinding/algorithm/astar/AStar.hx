package com.kevinresol.pathfinding.algorithm.astar;
import com.kevinresol.pathfinding.ds.INodeManager;
import com.kevinresol.pathfinding.ds.INode;
import com.kevinresol.pathfinding.IPathfinder;

/**
 * ...
 * @author Kevin
 */
typedef Costs = { f:Int, g:Int, h:Int };

class AStar<TNode:INode> implements IPathfinder<TNode> 
{
	public var nodeManager:INodeManager<TNode>;
	
	private var closedList:Array<TNode>;
	private var openList:Array<TNode>;
	private var data:Map<TNode, NodeData<TNode>>;

	public function new(?nodeManager:INodeManager<TNode>) 
	{
		this.nodeManager = nodeManager;
	}
	
	public function findPath(origin:TNode, destination:TNode):Array<TNode>
	{
		if (nodeManager == null)
			throw "Please provide a nodeManger";
		
		openList = [];
		closedList = [];
		data = new Map();
		
		//start path finding			
		openList.push(origin);
		var data = getData(origin);
		data.costG = 0;
		data.costF = estimateHeuristicCost(origin, destination);
		
		
		while (openList.length > 0)
		{						
			var current = getMinCostNode();
			var currentData = getData(current);
			
			if(current == destination)
			{
				//path found
				return reconstructPath(current); 
			}
			
			closedList.push(current);
			openList.remove(current);
			
			for (neighbour in nodeManager.getNeighbours(current))
			{
				if (neighbour.walkable && closedList.indexOf(neighbour) == -1)
				{
					var neighbourData = getData(neighbour);
					var tempMovementCost = currentData.costG + distanceBetween(current, neighbour);
					var neighbourInOpenList = (openList.indexOf(neighbour) > -1);
					
					if (!neighbourInOpenList || tempMovementCost < neighbourData.costG)
					{
						if(!neighbourInOpenList)
							openList.push(neighbour);
						
						neighbourData.cameFrom = current;
						neighbourData.costF = tempMovementCost + estimateHeuristicCost(destination, neighbour);
						neighbourData.costG = tempMovementCost;
					}
				}
			}				
		} //wend
		
		//No path is found
		return null;
	}
	
	private inline function distanceBetween(node1:TNode, node2:TNode):Int
	{
		return nodeManager.distanceBetween(node1, node2);
	}
	
	private inline function estimateHeuristicCost(node1:TNode, node2:TNode):Int
	{
		return distanceBetween(node1, node2);
	}
	
	private function getMinCostNode():TNode
	{
		var result = openList[0];
		var minCost = getData(result).costF;
			
		for (n in openList)
		{
			var data = getData(n);
			
			if (data.costF < minCost)
			{
				result = n;
				minCost = data.costF;
			}
		}			
		return result;
		
		//remarks: sorting openList is much more time consuming than simply finding out the smallest
	}
	
	private function reconstructPath(current:TNode):Array<TNode>
	{
		var prev:TNode = getData(current).cameFrom;
		if(prev != null)
		{
			var path = reconstructPath(prev);
			path.push(current);
			return path;
		}
		else
			return [current];
	}
	
	private inline function getData(node:TNode):NodeData<TNode>
	{
		var d = data.get(node);
		if (d == null)
		{
			d = new NodeData();
			data.set(node, d);
		}
		return d;
	}
}

private class NodeData<TNode:INode>
{
	public var costF:Int;
	public var costG:Int;
	public var costH:Int;
	public var cameFrom:TNode;
	public function new(){}
}

