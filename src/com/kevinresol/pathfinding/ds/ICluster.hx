package com.kevinresol.pathfinding.ds;

/**
 * @author Kevin
 */

interface ICluster<TNode:INode> extends INodeManager<TNode>
{
	var entranceNodes:Array<TNode>;
	function contains(node:TNode):Bool;
}