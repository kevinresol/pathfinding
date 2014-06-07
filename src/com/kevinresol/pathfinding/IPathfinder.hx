package com.kevinresol.pathfinding;
import com.kevinresol.pathfinding.ds.INodeManager;
import com.kevinresol.pathfinding.ds.INode;

/**
 * @author Kevin
 */

interface IPathfinder<TNode:INode> 
{
	function findPath(origin:TNode, destination:TNode):Array<TNode>;
}