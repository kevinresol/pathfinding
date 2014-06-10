package com.kevinresol.pathfinding.ds;
import com.kevinresol.pathfinding.algorithm.hpastar.Entrance;
import com.kevinresol.pathfinding.ds.ICluster;
import com.kevinresol.pathfinding.ds.INode;

/**
 * @author Kevin
 */

interface IClusterManager<TCluster:ICluster<TNode>, TNode:INode>
{
	function buildClusters(level:Int):Array<TCluster>;
	function isAdjacent(cluster1:TCluster, cluster2:TCluster):Bool;
	function buildEntrances(cluster1:TCluster, cluster2:TCluster):Array<Entrance<TNode>>;
	function getEntrances(cluster1:TCluster, cluster2:TCluster):Array<Entrance<TNode>>;
	
}