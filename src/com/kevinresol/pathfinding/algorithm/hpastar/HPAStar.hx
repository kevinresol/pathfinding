package com.kevinresol.pathfinding.algorithm.hpastar;
import com.kevinresol.pathfinding.algorithm.astar.AStar;
import com.kevinresol.pathfinding.ds.ICluster;
import com.kevinresol.pathfinding.ds.IClusterManager;
import com.kevinresol.pathfinding.ds.INode;
import com.kevinresol.pathfinding.ds.INodeManager;

/**
 * ...
 * @author Kevin
 */
class HPAStar<TCluster:ICluster<TNode>, TNode:INode> implements IPathfinder<TNode> 
{
	public var level:Int;
	private var nodes:Array<TNode>;
	private var edges:Array<Edge<TNode>>;
	public var clusters(default, null):Map<Int, Array<TCluster>>;
	private var entrances:Array<Entrance<TNode>>;
	private var clusterManager:IClusterManager<TCluster, TNode>;
	private var aStar:AStar<TNode>;

	public function new(maxLevel:Int, clusterManager:IClusterManager<TCluster, TNode>) 
	{
		this.clusterManager = clusterManager;
		level = maxLevel;
		aStar = new AStar();
		
		preprocess(level);
	}
	
	public function findPath(origin:TNode, destination:TNode):Array<TNode>
	{
		// origin and destination are in the same cluster
		var originCluster = determineCluster(origin, level);
		if (originCluster.contains(destination))
		{
			aStar.nodeManager = originCluster;
			return aStar.findPath(origin, destination);
		}
		
		insertNode(origin, level);
		insertNode(destination, level);
		
		aStar.nodeManager = new EdgeManager(edges.filter(function(e) return e.level == level));
		var highLevelPath = aStar.findPath(origin, destination);
		return highLevelPath;
	}
	
	private function insertNode(node:TNode, maxLevel:Int):Void
	{
		for (l in 0...maxLevel)
		{
			var c = determineCluster(node, l + 1);
			connectToBorder(node, c);
		}
		node.level = maxLevel;
		
	}
	
	private function connectToBorder(node:TNode, cluster:TCluster):Void
	{
		var l = cluster.level;
		for (n in cluster.entranceNodes)
		{
			if (n.level >= l)
			{
				aStar.nodeManager = cluster;
				var path = aStar.findPath(node, n);
				if (path != null)
				{
					edges.push(new Edge(node, n, l, path.length, EIntra));
				}
			}
		}
	}
	
	private function determineCluster(node:TNode, level:Int):TCluster
	{
		for (c in clusters[level])
		{
			if (c.contains(node)) 
				return c;
		}
		return null;
	}
	
	private function preprocess(maxLevel:Int):Void 
	{
		abstractMaze();
		buildGraph();
		
		for (i in 2...maxLevel + 1)
			addLevelToGraph(i);
	}
	
	private function abstractMaze():Void 
	{
		entrances = [];
		edges = [];
		clusters = new Map();
		
		clusters[1] = clusterManager.buildClusters(1);
		for (i in 0...clusters[1].length)
		{
			for (j in i + 1...clusters[1].length)
			{
				var c1 = clusters[1][i];
				var c2 = clusters[1][j];
				if (clusterManager.isAdjacent(c1, c2))
				{
					for(e in clusterManager.buildEntrances(c1, c2))
						entrances.push(e);
				}
			}
		}
	}
	
	private function buildGraph():Void 
	{
		for (e in entrances)
		{
			var nodePositions;
			if (e.nodes.a.length <= 3)
			{
				nodePositions = [Std.int((e.nodes.a.length - 1) / 2)];
			}
			else
			{
				nodePositions = [0, e.nodes.a.length - 1];
			}
			for (i in nodePositions)
			{
				var n1 = e.nodes.a[i];
				var n2 = e.nodes.b[i];
				n1.level = n2.level = 1;
				
				for (c in clusters[1])
				{
					if (c.contains(n1) && c.entranceNodes.indexOf(n1) == -1) c.entranceNodes.push(n1);
					if (c.contains(n2) && c.entranceNodes.indexOf(n2) == -1) c.entranceNodes.push(n2);
				}
				edges.push(new Edge(n1, n2, 1, 1, EInter));
			}
		}
		
		for (c in clusters[1])
		{
			for (i in 0...c.entranceNodes.length)
			{
				for (j in i + 1...c.entranceNodes.length)
				{
					var n1 = c.entranceNodes[i];
					var n2 = c.entranceNodes[j];
					aStar.nodeManager = c;
					var path = aStar.findPath(n1, n2);
					if (path != null)
					{
						edges.push(new Edge(n1, n2, 1, path.length, EIntra));
					}
				}
			}
		}
	}
	
	private function addLevelToGraph(level:Int):Void
	{
		clusters[level] = clusterManager.buildClusters(level);
		for (i in 0...clusters[level].length)
		{
			for (j in i + 1...clusters[level].length)
			{
				var c1 = clusters[level][i];
				var c2 = clusters[level][j];
				if (clusterManager.isAdjacent(c1, c2))
				{
					for (e in clusterManager.getEntrances(c1, c2))
					{
						for (i in 0...e.nodes.a.length)
						{
							var n1 = e.nodes.a[i];
							var n2 = e.nodes.b[i];
							n1.level = n2.level = level;
							getEdge(n1, n2).level = level;
						}
					}
				}
			}
		}
		
		for (c in clusters[level])
		{
			for (i in 0...c.entranceNodes.length)
			{
				for (j in i + 1...c.entranceNodes.length)
				{
					var n1 = c.entranceNodes[i];
					var n2 = c.entranceNodes[j];
					aStar.nodeManager = c;
					var path = aStar.findPath(n1, n2);
					if (path != null)
					{
						edges.push(new Edge(n1, n2, level, path.length, EIntra));
					}
				}
			}
		}
	}
	
	private function getEdge(node1:TNode, node2:TNode):Edge<TNode>
	{
		for (e in edges)
		{
			if (e.nodes.a == node1 && e.nodes.b == node2)
				return e;
			if (e.nodes.a == node2 && e.nodes.b == node1)
				return e;
		}
		return null;
	}	
}



private class EdgeManager<TNode:INode> implements INodeManager<TNode>
{
	private var edges:Array<Edge<TNode>>;
	
	public function new(edges:Array<Edge<TNode>>)
	{
		this.edges = edges;
	}
	
	public function distanceBetween(node1:TNode, node2:TNode):Int
	{
		for (e in edges)
		{
			if ((e.nodes.a == node1 && e.nodes.b == node2) || (e.nodes.b == node1 && e.nodes.a == node2))
			{
				trace(node1, node2, e.distance, e.type);
				return e.distance;
			}
		}
		
		return 0;
	}
	
	public function getNeighbours(node:TNode):Array<TNode>
	{
		var result = [];
		for (e in edges)
		{
			if (e.nodes.a == node) result.push(e.nodes.b);
			if (e.nodes.b == node) result.push(e.nodes.a);
		}
		return result;
	}
}