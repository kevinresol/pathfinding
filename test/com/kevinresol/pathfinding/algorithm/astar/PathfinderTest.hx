package com.kevinresol.pathfinding.algorithm.astar;

import com.kevinresol.pathfinding.ds.INodeManager;
import massive.munit.Assert;
import com.kevinresol.pathfinding.ds.INode;

/**
* Auto generated ExampleTest for MassiveUnit. 
* This is an example test class can be used as a template for writing normal and async tests 
* Refer to munit command line tool for more information (haxelib run munit)
*/
class PathfinderTest 
{
	public function new() 
	{
		
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
		
		
	}
	
	@AfterClass
	public function afterClass():Void
	{
		
	}
	
	@Before
	public function setup():Void
	{
		
	}
	
	@After
	public function tearDown():Void
	{
		
	}	
	
	@Test
	public function testExample():Void
	{
		var map = [
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],		
			[1, 1, 1, 0, 0, 0, 3, 1, 1, 1, 1, 1],		
			[1, 1, 1, 0, 2, 0, 9, 1, 1, 1, 1, 1],		
			[1, 1, 1, 0, 9, 0, 9, 1, 1, 1, 1, 1],		
			[1, 1, 1, 0, 9, 0, 9, 1, 1, 1, 1, 1],		
			[1, 1, 1, 0, 9, 0, 9, 1, 1, 1, 1, 1],		
			[1, 1, 1, 1, 9, 9, 9, 1, 1, 1, 1, 1],
		];
			
		var tileManager = new TileManager();
		tileManager.init(map);
		
		var origin = tileManager.getTile(4, 2);
		var destination = tileManager.getTile(6, 0);
		
		var pathfinder = new AStar(tileManager);
		var path = pathfinder.findPath(origin, destination);
		
		Assert.isTrue(path.length == 11);
	}
	
}

private class TileManager implements INodeManager<Tile>
{
	private var tiles:Array<Array<Tile>>;
	
	public function new() 
	{ 
		
	}
	
	public function init(map:Array<Array<Int>>):Void
	{
		tiles = [];
		for (y in 0...map.length)
		{
			tiles[y] = [];
			for (x in 0...map[y].length)
			{
				var isWalkable = map[y][x] != 0;
				tiles[y][x] = new Tile(x, y, isWalkable, this);
			}
		}
	}
	
	public function getNeighbours(tile:Tile):Array<Tile>
	{
		var result = [];
		
		result.push(getTile(tile.x, tile.y - 1));		
		result.push(getTile(tile.x, tile.y + 1));
		result.push(getTile(tile.x - 1, tile.y - 1));
		result.push(getTile(tile.x - 1, tile.y ));
		result.push(getTile(tile.x - 1, tile.y + 1));
		result.push(getTile(tile.x + 1, tile.y - 1));
		result.push(getTile(tile.x + 1, tile.y ));
		result.push(getTile(tile.x + 1, tile.y + 1));
		
		return result.filter(function(r) return r != null);
		
	}
	
	
	public function distanceBetween(tile1:Tile, tile2:Tile):Int
	{
		//TODO now only calculate neighbours
		return Math.abs(tile1.x - tile2.x) + Math.abs(tile1.y - tile2.y) == 2 ? 141 : 100;
	}
	
	public function getTile(x:Int, y:Int):Tile
	{
		if (x < 0 || y < 0 || y >= tiles.length || x >= tiles[0].length)
			return null;
		else 
			return tiles[y][x];
		
	}
}

private class Tile implements INode
{
	public var x:Int;
	public var y:Int;
	public var level:Int;
	public var walkable:Bool;
	public var tileManager:TileManager;
	
	public function new(x:Int, y:Int, walkable:Bool, tileManager:TileManager)
	{
		this.x = x;
		this.y = y;
		this.walkable = walkable;
		this.tileManager = tileManager;
	}
	
	public function toString():String
	{
		return '[Tile: $x, $y]';
	}
}