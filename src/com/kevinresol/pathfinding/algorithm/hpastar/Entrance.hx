package com.kevinresol.pathfinding.algorithm.hpastar;
import com.kevinresol.pathfinding.ds.INode;
using tink.CoreApi;

/**
 * A pair of array of continously walkable nodes, at the border of two clusters
 * @author Kevin
 */
class Entrance<TNode:INode>
{
	public var nodes:Pair<Array<TNode>, Array<TNode>>;

	public function new() 
	{
		nodes = new Pair([], []);
	}
	
	public function toString():String
	{
		return '[Entrance: ${nodes.a.toString()}, ${nodes.b.toString()}]';
	}
	
}