package com.kevinresol.pathfinding.ds;
import com.kevinresol.pathfinding.algorithm.hpastar.Entrance;
import com.kevinresol.pathfinding.ds.IClusterManager;

/**
 * ...
 * @author Kevin
 */
class SquareGrid implements IGrid<SquareTile> implements IClusterManager<SquareTile>
{

	public function new() 
	{
		
	}
	
	public function getTile(x:Int, y:Int):SquareTile
	{
		return null;
	}
	
	public function buildFromGrid(grid:IGrid<TNode>, level:Int):Array<ICluster<TNode>> 
	{
		return [];
	}
	
	public function isAdjacent(cluster1:ICluster<TNode>, cluster2:ICluster<TNode>):Bool 
	{
		return false;
	}
	
	public function buildEntrances(cluster1:ICluster<TNode>, cluster2:ICluster<TNode>):Array<Entrance<TNode>> 
	{
		return [];
	}
	
	public function getEntrances(cluster1:ICluster<TNode>, cluster2:ICluster<TNode>):Array<Entrance<TNode>> 
	{
		return [];
	}
	
}