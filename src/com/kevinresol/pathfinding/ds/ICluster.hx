package com.kevinresol.pathfinding.ds;

/**
 * @author Kevin
 */

interface ICluster<TNode:INode> extends INodeManager<TNode>
{
	var nodes:Array<TNode>;
}