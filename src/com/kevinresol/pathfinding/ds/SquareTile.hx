package com.kevinresol.pathfinding.ds;

/**
 * ...
 * @author Kevin
 */
class SquareTile implements INode<SquareTile>
{
	public var x:Int;
	
	public var walkable:Bool;
	public var neighbours(get, never):Array<SquareTile>;
	public var parent(default, null):SquareGrid;

	public function new(x:Int, y:Int,) 
	{
		
	}
	
	private function get_neighbours():Array<SquareTile> 
	{
		return _neighbours;
	}	
	
	public function distanceBetween(tile:SquareTile):Int 
	{
		
	}
	
}