package at.dotpoint.math.vector;

/**
 * Vector with 2 Components (x,y)
 * @author Gerald Hattensauer
 */
class Vector2 implements IVector2
{

	public var x:Float;
	public var y:Float;
	
	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //	
	
	public function new( x:Float = 0, y:Float = 0 ) 
	{
		this.x = x;
		this.y = y;
	}
	
	public function clone():Vector2
	{
		return new Vector2( this.x, this.y );
	}
	
	// ************************************************************************ //
	// Methodes
	// ************************************************************************ //	
	
	/**
	 * 
	 * @param	x
	 * @param	y
	 * @param	z
	 * @param	?w
	 */
	public function set( x:Float, y:Float ):Void
	{
		this.x = x;
		this.y = y;
	}
	
	public function copyFrom( vector:IVector2 ):Void
	{
		this.x = vector.x;
		this.y = vector.y;
	}
	
	/**
	 * rescales each component between 0 and 1 without changing its ratio to each other
	 * [ignores the homogenous component]
	 */
	public function normalize():Void
	{
		var k:Float = 1. / this.length();
		
		this.x *= k;
		this.y *= k;
	}
	
	/** 
	 * @return length of the Vector
	 */
	public function length():Float
	{
		return Math.sqrt( this.lengthSq() );
	}
	
	/** 
	 * @return squared length of the Vector
	 */
	public function lengthSq():Float
	{
		return this.x * this.x + this.y * this.y;
	}
	
	// ---------------------------------------- //
	// ---------------------------------------- //
	
	public function toString():String
	{
		return "[Vector2;" + this.x + ", " + this.y + "]";
	}
	
	// ************************************************************************ //
	// static Operations
	// ************************************************************************ //	
	
	/**
	 * adds the x,y components (a+b)
	 * outcome will be stored into output;
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	public static function add( a:Vector2, b:Vector2, ?output:Vector2 = null ):Vector2
	{
		if ( output == null ) output = new Vector2();
		
		output.x = a.x + b.x;
		output.y = a.y + b.y;
		
		return output;
	}
	
	/**
	 * substracts the x,y components (a-b) 
	 * outcome will be stored into output;
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	public static function subtract( a:Vector2, b:Vector2, ?output:Vector2 = null ):Vector2
	{
		if ( output == null ) output = new Vector2();
		
		output.x = a.x - b.x;
		output.y = a.y - b.y;
		
		return output;
	}
	
	/**
	 * scales the x,y components by a scalar 
	 * outcome will be stored into output;
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	public static function scale( a:Vector2, scalar:Float, ?output:Vector2 = null ):Vector2
	{
		if ( output == null ) output = new Vector2();
		
		output.x = a.x * scalar;
		output.y = a.y * scalar;
		
		return output;
	}
}