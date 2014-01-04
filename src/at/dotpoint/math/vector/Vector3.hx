package at.dotpoint.math.vector;

import at.dotpoint.math.MathUtil;


/**
 * Vector with 3 Components (x,y,z) + Homogenous (w: 0 = Direction; 1 = Point)
 * @author Gerald Hattensauer
 */
class Vector3 implements IVector3
{

	public var x:Float;
	public var y:Float;
	public var z:Float;
	
	public var w:Float; // Homogenous: 0 = Direction; 1 = Point;
	
	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //	
	
	public function new( x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 1 ) 
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}
	
	public function clone():Vector3
	{
		return new Vector3( this.x, this.y, this.z, this.w );
	}	
	
	// ************************************************************************ //
	// Methodes
	// ************************************************************************ //	
	
	/**
	 * rescales each component between 0 and 1 without changing its ratio to each other
	 * [ignores the homogenous component]
	 */
	public function normalize():Void
	{
		var l:Float = this.length();
		if( l == 0 ) return;
		
		var k:Float = 1. / l;
		
		this.x *= k;
		this.y *= k;
		this.z *= k;
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
		return this.x * this.x + this.y * this.y + this.z * this.z;
	}
	
	// ---------------------------------------- //
	// ---------------------------------------- //

	public function toArray( ?w:Bool = false ):Array<Float>
	{
		var output:Array<Float> = new Array<Float>();		
			output[0] = this.x;
			output[1] = this.y;
			output[2] = this.z;
		
		if( w )
			output[3] = this.w;
		
		return output;
	}
	
	/**
	 * 
	 * @param	index
	 * @return
	 */
	public function getIndex( index:Int ):Float
	{
		switch( index )
		{
			case 0: return this.x;
			case 1: return this.y;
			case 2: return this.z;
			case 3: return this.w;
			
			default:
				throw "out of bounds";
		}
	}
	
	public function setIndex( index:Int, value:Float )
	{
		switch( index )
		{
			case 0: this.x = value;
			case 1: this.y = value;
			case 2: this.z = value;
			case 3: this.w = value;
			
			default:
				throw "out of bounds";
		}
	}
	
	public function set( x:Float, y:Float, z:Float, ?w:Float ):Void
	{
		this.x = x;
		this.y = y;
		this.z = z;
		
		if( w != null )
			this.w = w;
	}
	
	// ---------------------------------------- //
	// ---------------------------------------- //
	
	public function toString():String
	{
		return "[Vector3;" + this.x + ", " + this.y + ", " + this.z + ", " + this.w + "]";
	}
	
	// ************************************************************************ //
	// static Operations
	// ************************************************************************ //	
	
	/**
	 * adds the x,y and z components (a+b)
	 * outcome will be stored into output; [ignores the homogenous component]
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	public static function add( a:Vector3, b:Vector3, ?output:Vector3 = null ):Vector3
	{
		if ( output == null ) output = new Vector3();
		
		output.x = a.x + b.x;
		output.y = a.y + b.y;
		output.z = a.z + b.z;	
		
		return output;
	}
	
	/**
	 * substracts the x,y and z components (a-b) 
	 * outcome will be stored into output; [ignores the homogenous component]
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	public static function subtract( a:Vector3, b:Vector3, ?output:Vector3 = null ):Vector3
	{
		if ( output == null ) output = new Vector3();
		
		output.x = a.x - b.x;
		output.y = a.y - b.y;
		output.z = a.z - b.z;
		
		return output;
	}
	
	/**
	 * scales the x,y and z components by a scalar 
	 * outcome will be stored into output; [ignores the homogenous component]
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	public static function scale( a:Vector3, scalar:Float, ?output:Vector3 = null ):Vector3
	{
		if ( output == null ) output = new Vector3();
		
		output.x = a.x * scalar;
		output.y = a.y * scalar;
		output.z = a.z * scalar;
		
		return output;
	}
	
	/**
	 * crossproduct between a and b; calculates the normal of the plane spanned between a and b
	 * outcome will be stored into output; not communtative (a*b != b*a); [ignores the homogenous component]
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	public static function cross( a:Vector3, b:Vector3, ?output:Vector3 = null ):Vector3
	{
		if ( output == null ) output = new Vector3();
		
		#if debug
			if ( a == output || b == output ) throw "you can't use input as output for this methode";
		#end
		
		output.x = a.y * b.z - a.z * b.y;
		output.y = a.z * b.x - a.x * b.z;
		output.z = a.x * b.y - a.y * b.x;
		
		return output;
	}
	
	/**
	 * dotproduct between a and b; calculates the cosine angle between a and b
	 * [ignores the homogenous component]
	 */
	public static function dot( a:Vector3, b:Vector3 ):Float
	{
		return a.x * b.x + a.y * b.y + a.z * b.z;
	}
	
	/**
	 * Colomn Vector Multiplication (matrix * vector = vector)
	 * outcome will be stored into output
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	public static function multiplyMatrix( a:Vector3, b:Matrix44, ?output:Vector3 = null ):Vector3
	{
		if ( output == null ) output = new Vector3();
		
		var x:Float = a.x;
		var y:Float = a.y;
		var z:Float = a.z;
		var w:Float = a.w;
		
		output.x = b.m11 * x + b.m12 * y + b.m13 * z + b.m14 * w;
		output.y = b.m21 * x + b.m22 * y + b.m23 * z + b.m24 * w;
		output.z = b.m31 * x + b.m32 * y + b.m33 * z + b.m34 * w;
		output.w = b.m41 * x + b.m42 * y + b.m43 * z + b.m44 * w;
		
		return output;
	}
	
	/**
	 * compares each component for equality using ZERO_TOLERANCE
	 * ignores homogenous component (just x-z)
	 * 
	 * @param	output 	true when all components are equal
	 * @return			given output object
	 */
	public static function isEqual( a:Vector3, b:Vector3 ):Bool
	{
		if ( !MathUtil.isEqual(a.x, b.x) ) return false;		
		if ( !MathUtil.isEqual(a.y, b.y) ) return false;
		if ( !MathUtil.isEqual(a.z, b.z) ) return false;
		
		return true;
	}
	
	
	/**
	 * 
	 */
	public static function project( a:Vector3, b:Vector3, ?output:Vector3 ):Vector3
	{
		if ( output == null ) output = new Vector3();
		
		var l:Float = a.lengthSq();
		if( l == 0 ) throw "undefined result";
		
		var d:Float = Vector3.dot( a, b );
		var d_div:Float = d / l;
		
		return Vector3.scale( a, d_div, output );
	}
	 
	/**
	 * Applies Gram-Schmitt Ortho-normalization to the given set of input objects.
	 */
	/*
	    for (int i = 0; i < vecs.length; ++ i) {
			Vector3 accum = new Vector3(0.0, 0.0, 0.0);
	
			for(int j = 0; j < i; ++ j)
				accum.add(Vector3.projectAndCreate(vecs[i], vecs[j]));
	
			vecs[i].subtract(accum).normalize();
		}
	 * 
	 */
	public static function orthoNormalize( vectors:Array<Vector3> ):Void 
	{
		for( i in 0...vectors.length )
		{
			var sum:Vector3 = new Vector3(); 
			
			for( j in 0...i )
			{
				var projected:Vector3 = Vector3.project( vectors[i], vectors[j] );
				Vector3.add( sum, projected, sum );
			}
			
			Vector3.subtract( vectors[i], sum, vectors[i] ).normalize();			
		}	
	}

	
}