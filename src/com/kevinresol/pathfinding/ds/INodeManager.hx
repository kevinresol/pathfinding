package com.kevinresol.pathfinding.ds;

/**
 * @author Kevin
 */

interface INodeManager<TNode:INode>
{
	function distanceBetween(node1:TNode, node2:TNode):Int;
	function getNeighbours(node:TNode):Array<TNode>;
}