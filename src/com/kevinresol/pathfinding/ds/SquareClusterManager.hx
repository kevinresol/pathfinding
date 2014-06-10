package com.kevinresol.pathfinding.ds;
import com.kevinresol.pathfinding.algorithm.hpastar.Entrance;
using tink.CoreApi;
/**
 * ...
 * @author Kevin
 */
class SquareClusterManager implements IClusterManager<SquareCluster, SquareTile>
{
	private var grid:SquareGrid;
	private var clusterWidth:Int;
	private var clusterHeight:Int;
	private var entrances:Array<Entrance<SquareTile>>;

	public function new(grid:SquareGrid, clusterWidth:Int, clusterHeight:Int) 
	{
		this.grid = grid;
		this.clusterWidth = clusterWidth;
		this.clusterHeight = clusterHeight;
	}
	
	public function buildClusters(level:Int):Array<SquareCluster> 
	{
		var width = Math.ceil(grid.width / clusterWidth);
		var height = Math.ceil(grid.height / clusterHeight);
		var widthRemainder = grid.width - (width - 1) * clusterWidth;
		var heightRemainder = grid.height - (height - 1) * clusterHeight;
		
		var result = [];
		trace(width, height);
		for (x in 0...width)
		{
			for (y in 0...height)
			{
				var offsetX = x * clusterWidth;
				var offsetY = y * clusterHeight;
				var cw = x == width - 1 ? widthRemainder : clusterWidth;
				var ch = y == height - 1 ? heightRemainder : clusterHeight;
				var nodes = grid.getTiles(offsetX, offsetY, cw, ch);
				var cluster = new SquareCluster(x, y, offsetX, offsetY, cw, ch, nodes, level);
				result.push(cluster);
			}
		}
		return result;
	}
	
	public function isAdjacent(cluster1:SquareCluster, cluster2:SquareCluster):Bool 
	{
		var dx = cluster1.x > cluster2.x ? cluster1.x - cluster2.x : cluster2.x - cluster1.x;
		var dy = cluster1.y > cluster2.y ? cluster1.y - cluster2.y : cluster2.y - cluster1.y;
		
		if (dx == 0 && dy == 1) return true;
		if (dy == 0 && dx == 1) return true;
		return false;
	}
	
	public function buildEntrances(cluster1:SquareCluster, cluster2:SquareCluster):Array<Entrance<SquareTile>> 
	{
		var border = getBorder(cluster1, cluster2);
		
		entrances = [];
		var entrance = null;
		for (i in 0...border.a.length)
		{
			var n1 = border.a[i];
			var n2 = border.b[i];
			if (n1.walkable && n2.walkable)
			{
				if (entrance == null)
					entrance = new Entrance();
				
				entrance.nodes.a.push(n1);
				entrance.nodes.b.push(n2);
			}
			else
			{
				if (entrance != null)
				{
					entrances.push(entrance);
					entrance = null;
				}
			}
		}
		
		// push last entrance
		if (entrance != null)
		{
			entrances.push(entrance);
			entrance = null;
		}
		
		return entrances;
	}
	
	public function getEntrances(cluster1:SquareCluster, cluster2:SquareCluster):Array<Entrance<SquareTile>> 
	{
		var result = [];
		for (e in entrances)
		{
			var n1 = e.nodes.a[0];
			var n2 = e.nodes.b[0];
			
			if ((cluster1.contains(n1) && cluster2.contains(n2)) || (cluster2.contains(n1) && cluster1.contains(n2)))
				result.push(e);
		}
		return result;
	}
	
	/**
	 * 
	 * @param	cluster1
	 * @param	cluster2
	 * @return	two arrays of tiles, representing the contacting border of the two clusters
	 */
	private function getBorder(cluster1:SquareCluster, cluster2:SquareCluster):Pair<Array<SquareTile>, Array<SquareTile>>
	{
		var dx = cluster1.x - cluster2.x;
		var dy = cluster1.y - cluster2.y;
		
		if (dx == 0) // Vertically aligned
		{
			switch (dy) 
			{
				case 1: //c1 below c2
					return new Pair(cluster1.getRow(0), cluster2.getRow(cluster2.height - 1));
				case -1: //c2 below c1
					return new Pair(cluster1.getRow(cluster1.height - 1), cluster2.getRow(0));
				default: 
					throw "Clusters are not adjacent";
					
			}
		}
		else if (dy == 0) // Horizontally aligned
		{
			switch (dx) 
			{
				case 1: //c1 to the right of c2
					return new Pair(cluster1.getColumn(0), cluster2.getColumn(cluster2.width - 1));
				case -1: //c1 to the left of c2
					return new Pair(cluster1.getColumn(cluster1.width - 1), cluster2.getColumn(0));
				default: 
					throw "Clusters are not adjacent";
					
			}
		}
		else 
			throw "Clusters are not adjacent";
	}
}