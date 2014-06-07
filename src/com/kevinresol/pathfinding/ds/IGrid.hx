package com.kevinresol.pathfinding.ds;

/**
 * @author Kevin
 */

interface IGrid<TNode:INode>
{
	function getTile(x:Int, y:Int):TNode;
}