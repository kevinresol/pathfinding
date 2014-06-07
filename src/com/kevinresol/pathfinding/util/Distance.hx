package com.kevinresol.pathfinding.util;

/**
 * ...
 * @author Kevin
 */
class Distance
{

	public static inline function onlyStraightAndDiagonal(dx:Int, dy:Int):Int
	{
		if (dx < 0) dx *= -1;
		if (dy < 0) dy *= -1;
		
		var straightLength = dx > dy ? dx - dy : dy - dx;
		var diagonalLength = dx > dy ? dy  : dx;
		
		return straightLength * 100 + diagonalLength * 141;
	}
	
	public static inline function manhattan(dx:Int, dy:Int):Int
	{
		if (dx < 0) dx *= -1;
		if (dy < 0) dy *= -1;
		return dx + dy;
	}
	
}