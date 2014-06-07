package com.kevinresol.pathfinding.algorithm.hpastar;
import com.kevinresol.pathfinding.algorithm.astar.AStar;
import com.kevinresol.pathfinding.ds.ICluster;
import com.kevinresol.pathfinding.ds.IClusterManager;
import com.kevinresol.pathfinding.ds.IGrid;
import com.kevinresol.pathfinding.ds.INode;

/**
 * ...
 * @author Kevin
 */
class HPAStar<TNode:INode> implements IPathfinder<TNode> 
{
	private var nodes:Array<TNode>;
	private var edges:Array<Edge<TNode>>;
	private var clusters:Map<Int, Array<ICluster<TNode>>>;
	private var entrances:Array<Entrance<TNode>>;
	private var clusterManager:IClusterManager<TNode>;
	private var grid:IGrid<TNode>;
	private var aStar:AStar<TNode>;

	public function new(?clusterManager:IClusterManager<TNode>, ?grid:IGrid<TNode>) 
	{
		this.clusterManager = clusterManager;
		aStar = new AStar();
	}
	
	public function findPath(origin:TNode, destination:TNode):Array<TNode>
	{
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
		
		clusters[1] = clusterManager.buildFromGrid(grid, 1);
		for (i in 0...clusters[1].length)
		{
			for (j in i + 1...clusters[1].length)
			{
				var c1 = clusters[1][i];
				var c2 = clusters[1][j];
				if (clusterManager.isAdjacent(c1, c2))
				{
					clusterManager.buildEntrances(c1, c2);
				}
			}
		}
	}
	
	private function buildGraph():Void 
	{
		for (e in entrances)
		{
			var n1 = e.nodes.a;
			var n2 = e.nodes.b;
			if (nodes.indexOf(n1) == -1) nodes.push(n1);
			if (nodes.indexOf(n2) == -1) nodes.push(n2);
			edges.push(new Edge(n1, n2, 1, 1, EInter));
		}
		
		for (c in clusters[1])
		{
			for (i in 0...c.nodes.length)
			{
				for (j in i + 1...c.nodes.length)
				{
					var n1 = c.nodes[i];
					var n2 = c.nodes[j];
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
		clusters[level] = clusterManager.buildFromGrid(grid, level);
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
						var n1 = e.nodes.a;
						var n2 = e.nodes.b;
						n1.level = n2.level = level;
						getEdge(n1, n2).level = level;
					}
				}
			}
		}
		
		for (c in clusters[level])
		{
			for (i in 0...c.nodes.length)
			{
				for (j in i + 1...c.nodes.length)
				{
					var n1 = c.nodes[i];
					var n2 = c.nodes[j];
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
		return null;
	}
	
	
}