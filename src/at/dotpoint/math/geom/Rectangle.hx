package at.dotpoint.math.geom;

import at.dotpoint.math.vector.Vector2;

/**
 * ...
 * @author RK
 */
class Rectangle
{

	private var position:Vector2;
	private var size:Vector2;
	
	// -------------------- //
	
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	public var width(get, set):Float;
	public var height(get, set):Float;
	
	// -------------------- //
	
	public var top(get, set):Float;
	public var bottom(get, set):Float;
	
	public var left(get, set):Float;
	public var right(get, set):Float;
	
	// -------------------- //
	
	public var topLeft(get, set):Vector2;
	public var bottomRight(get, set):Vector2;	
	public var dimension(get, set):Vector2;
	
	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //	
	
	public function new( x:Float = 0, y:Float = 0, w:Float = 0, h:Float = 0 ) 
	{
		this.position = new Vector2( x, y );
		this.size = new Vector2( w, h );
	}
	
	public function clone():Rectangle
	{
		return new Rectangle( this.x, this.y, this.width, this.height );
	}
	
	// ************************************************************************ //
	// Methodes
	// ************************************************************************ //
	
	/**
	 * X
	 */
	inline private function get_x():Float { return this.position.x; }
	
	inline private function set_x( value:Float ):Float 
	{ 
		return this.position.x = value; 
	}
	
	/**
	 * Y
	 */
	inline private function get_y():Float { return this.position.y; }
	
	inline private function set_y( value:Float ):Float 
	{ 
		return this.position.y = value; 
	}
	
	/**
	 * W
	 */
	inline private function get_width():Float { return this.size.x; }
	
	inline private function set_width( value:Float ):Float 
	{ 
		if( value < 0 )
			throw "dimension below zero";
		
		return this.size.x = value; 
	}
	
	/**
	 * H
	 */
	inline private function get_height():Float { return this.size.y; }
	
	inline private function set_height( value:Float ):Float 
	{ 
		if( value < 0 )
			throw "dimension below zero";
		
		return this.size.y = value; 
	}
	
	// ---------------------------------------------------- //
	// ---------------------------------------------------- //

	/**
	 * Y/TOP
	 */
	inline private function get_top():Float { return this.y; }
	
	inline private function set_top( value:Float ):Float 
	{ 
		this.height -= value - this.y;
		this.y = value;
		
		return value; 
	}
	
	/**
	 * Y/BOTTOM
	 */
	inline private function get_bottom():Float { return this.y + this.height; }
	
	inline private function set_bottom( value:Float ):Float 
	{ 
		this.height = value - this.y;		
		return value; 
	}
	
	/**
	 * X/LEFT
	 */
	inline private function get_left():Float { return this.x; }
	
	inline private function set_left( value:Float ):Float 
	{ 
		this.width -= value - this.x;
		this.x = value;
		
		return value; 
	}
	
	/**
	 *  X/RIGHT
	 */
	inline private function get_right():Float { return this.x + this.width; }
	
	inline private function set_right( value:Float ):Float 
	{ 
		this.width = value - this.x;		
		return value; 
	}
	
	// ---------------------------------------------------- //
	// ---------------------------------------------------- //
	
	/**
	 * XY/TOP+LEFT
	 */
	inline private function get_topLeft():Vector2 { return this.position.clone(); }
	
	inline private function set_topLeft( value:Vector2 ):Vector2 
	{ 
		this.top = value.y;
		this.left = value.x;
		
		return value; 
	}
	
	/**
	 * XY/BOTTOM+RIGHT
	 */
	inline private function get_bottomRight():Vector2 { return Vector2.add( this.position, this.size ); }
	
	inline private function set_bottomRight( value:Vector2 ):Vector2 
	{ 
		this.bottom = value.y;
		this.right = value.x;
		
		return value; 
	}
	
	/**
	 *  XY/WIDTH+HEIGHT
	 */
	inline private function get_dimension():Vector2 { return this.size.clone(); }
	
	inline private function set_dimension( value:Vector2 ):Vector2 
	{ 
		this.size.copyFrom( value );		
		return value; 
	}
	
	// ************************************************************************ //
	// Methodes
	// ************************************************************************ //
	
	/**
	 * 
	 * @return
	 */
	public function toString():String
	{
		return "x:" + this.x + " y:" + this.y + " w:" + this.width + " h:" + this.height;
	}
}