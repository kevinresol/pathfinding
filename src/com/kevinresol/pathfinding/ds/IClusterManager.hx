package com.kevinresol.pathfinding.ds;
import com.kevinresol.pathfinding.algorithm.hpastar.Entrance;
import com.kevinresol.pathfinding.ds.ICluster;
import com.kevinresol.pathfinding.ds.IGrid;
import com.kevinresol.pathfinding.ds.INode;

/**
 * @author Kevin
 */

interface IClusterManager<TNode:INode>
{
	function buildFromGrid(grid:IGrid<TNode>, level:Int):Array<ICluster<TNode>>;
	function isAdjacent(cluster1:ICluster<TNode>, cluster2:ICluster<TNode>):Bool;
	function buildEntrances(cluster1:ICluster<TNode>, cluster2:ICluster<TNode>):Array<Entrance<TNode>>;
	function getEntrances(cluster1:ICluster<TNode>, cluster2:ICluster<TNode>):Array<Entrance<TNode>>;
}