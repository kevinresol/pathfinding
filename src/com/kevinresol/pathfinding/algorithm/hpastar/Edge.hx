package com.kevinresol.pathfinding.algorithm.hpastar;
import com.kevinresol.pathfinding.ds.INode;
using tink.CoreApi;

/**
 * ...
 * @author Kevin
 */
class Edge<TNode:INode>
{
	public var nodes:Pair<TNode, TNode>;
	public var distance:Int;
	public var level:Int;
	public var type:EdgeType;

	
	public function new(node1:TNode, node2:TNode, level:Int, distance:Int, type:EdgeType) 
	{
		this.nodes = new Pair(node1, node2);
		this.distance = distance;
		this.level = level;
		this.type = type;
	}
	
}

enum EdgeType
{
	EIntra;
	EInter;
}