package com.kevinresol.pathfinding.ds;

/**
 * ...
 * @author Kevin
 */
class SquareTile implements INode
{
	public var x:Int;
	public var y:Int;
	
	public var level:Int;
	public var walkable:Bool;

	public function new(x:Int, y:Int, walkable:Bool) 
	{
		this.x = x;
		this.y = y;
		this.walkable = walkable;
	}
	
	public function toString():String
	{
		return '[SquareTile: x=$x, y=$y, level=$level, walkable=$walkable]';
	}
}