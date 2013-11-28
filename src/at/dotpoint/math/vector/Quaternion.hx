package at.dotpoint.math.vector;

import at.dotpoint.math.MathUtil;

/**
 * Unit-Quaternion is a Vector4 like Object for interpolateable and gimbal-lock-free rotations;
 * note - this class does not guarantee to be a unit quaternion but some methodes may rely on it.
 * 
 * @author Gerald Hattensauer
 */
class Quaternion
{

	public var x:Float; // imaginary
	public var y:Float; // imaginary
	public var z:Float;	// imaginary
	public var w:Float; // real
	
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
	
	public function clone():Quaternion
	{
		return new Quaternion( this.x, this.y, this.z, this.w );
	}
	
	// ************************************************************************ //
	// Methodes
	// ************************************************************************ //	
	
	/**
	 * [x:0,y:0,z:0,w:1]
	 */
	public function toIdentity():Void
	{
		this.x = 0;
		this.y = 0;
		this.z = 0;
		this.w = 1;
	}
	
	/**
	 * conjungates the quaternion the imaginary components x,y,z
	 */
	public function conjugate():Void
	{
		this.x = -this.x;
		this.y = -this.y;
		this.z = -this.z;
	}
	
	/**
	 * 
	 */
	public function invert():Void
	{
		var k:Float = 1. / this.lengthSq(); 
		
		this.conjugate();
		
		this.x *= k;
		this.y *= k;
		this.z *= k;
		this.w *= k;	
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
		this.z *= k;
		this.w *= k;
	}
	
	/** 
	 * @return length of the Vector
	 */
	inline public function length():Float
	{
		return Math.sqrt( this.lengthSq() );
	}
	
	/** 
	 * @return squared length of the Vector
	 */
	inline public function lengthSq():Float
	{
		return this.x * this.x + this.y * this.y + this.z * this.z + this.w * this.w;
	}
	
	// ************************************************************************ //
	// static Operations
	// ************************************************************************ //	
	
	/**
	 * adds the x,y,z and w components (a+b)
	 * outcome will be stored into output; 
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	inline public static function add( a:Quaternion, b:Quaternion, output:Quaternion ):Quaternion
	{
		output.x = a.x + b.x;
		output.y = a.y + b.y;
		output.z = a.z + b.z;	
		output.w = a.w + b.w;	
		
		return output;
	}
	
	/**
	 * substracts the x,y,z and w components (a-b) 
	 * outcome will be stored into output;
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	inline public static function subtract( a:Quaternion, b:Quaternion, output:Quaternion ):Quaternion
	{
		output.x = a.x - b.x;
		output.y = a.y - b.y;
		output.z = a.z - b.z;
		output.w = a.w - b.w;
		
		return output;
	}
	
	/**
	 * scales the x,y,z and w components by a scalar; 
	 * outcome will be stored into output; 
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	inline public static function scale( a:Quaternion, scalar:Float, output:Quaternion ):Quaternion
	{
		output.x = a.x * scalar;
		output.y = a.y * scalar;
		output.z = a.z * scalar;
		output.w = a.w * scalar;
		
		return output;
	}
	
	/**
	 * calculates the product of 2 quaternions; use to compose quaternions together;
	 * outcome will be stored into output; not communtative (a*b != b*a); 
	 * 
	 * @param	output 	object the outcome will be stored to (does not change the current object)
	 * @return			given output object
	 */
	inline public static function multiply( a:Quaternion, b:Quaternion, output:Quaternion ):Quaternion
	{
		#if debug
			if ( a == output || b == output ) throw "you can't use input as output for this methode";
		#end
		
		output.x = a.w * b.x + a.x * b.w + a.y * b.z - a.z * b.y; // cross - dot (to remove real)
		output.y = a.w * b.y - a.x * b.z + a.y * b.w + a.z * b.x; // short version
		output.z = a.w * b.z + a.x * b.y - a.y * b.x + a.z * b.w;
		output.w = a.w * b.w - a.x * b.x - a.y * b.y - a.z * b.z;
		
		return output; 
	}
	
	/**
	 * dotproduct between a and b; calculates the cosine angle between a and b;
	 * [ignores the homogenous component]
	 */
	inline public static function dot( a:Quaternion, b:Quaternion ):Float
	{
		return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
	}
	
	// ************************************************************************ //
	// Rotation specific:
	// ************************************************************************ //	
	
	/**
	 * set rotation around a vector.
	 * 
	 * @param 	axis	The vector in space it rotates around 
	 * @param	angle	The angle in radians of the rotation.
	 */
	inline public static function setAxisAngle( axis:IVector3, radians:Float, output:Quaternion ):Quaternion
	{
		radians = radians * 0.5;
		
		var sin_a:Float = Math.sin( radians );
		var cos_a:Float = Math.cos( radians );
		
		output.x = axis.x * sin_a;
		output.y = axis.y * sin_a;
		output.z = axis.z * sin_a;
		output.w = cos_a;
		
		output.normalize();
		
		return output;
	}
	
	/**
	 * 
	 * @param	euler
	 * @param	output
	 * @return
	 */
	inline public static function setEuler( euler:IVector3, output:Quaternion ):Quaternion
	{
		var fSinPitch:Float       = Math.sin( euler.x * 0.5 );
		var fCosPitch:Float       = Math.cos( euler.x * 0.5 );
		var fSinYaw:Float         = Math.sin( euler.y * 0.5 );
		var fCosYaw:Float         = Math.cos( euler.y * 0.5 );
		var fSinRoll:Float        = Math.sin( euler.z * 0.5 );
		var fCosRoll:Float        = Math.cos( euler.z * 0.5 );
		var fCosPitchCosYaw:Float = fCosPitch * fCosYaw;
		var fSinPitchSinYaw:Float = fSinPitch * fSinYaw;
		
		output.x = fSinRoll * fCosPitchCosYaw     - fCosRoll * fSinPitchSinYaw;
		output.y = fCosRoll * fSinPitch * fCosYaw + fSinRoll * fCosPitch * fSinYaw;
		output.z = fCosRoll * fCosPitch * fSinYaw - fSinRoll * fSinPitch * fCosYaw;
		output.w = fCosRoll * fCosPitchCosYaw     + fSinRoll * fSinPitchSinYaw;
		
		return output;
	}
	
	/**
	 * 
	 * @param	input
	 * @param	output
	 * @return
	 */
	inline public static function toEuler( input:Quaternion, output:IVector3 ):IVector3
	{
		var test:Float = input.x * input.y + input.z * input.w;
		
		if (test > 0.499) 	// singularity at north pole
		{ 
			output.x = 2 * Math.atan2(input.x, input.w);
			output.y = Math.PI / 2;
			output.z = 0;
		}
		if (test < -0.499) 	// singularity at south pole
		{ 
			output.x = -2 * Math.atan2(input.x, input.w);
			output.y = -Math.PI / 2;
			output.z = 0;
		}
		else
		{
			var sqx:Float = input.x * input.x;
			var sqy:Float = input.y * input.y;
			var sqz:Float = input.z * input.z;
			
			output.x = Math.atan2(2 * input.y * input.w - 2 * input.x * input.z , 1 - 2 * sqy - 2 * sqz);			
			output.z = Math.atan2(2 * input.x * input.w - 2 * input.y * input.z , 1 - 2 * sqx - 2 * sqz);
			output.y = Math.asin(2 * test);
		}
		
		return output;
	}
	
	/**
	 * 
	 * @param	input
	 * @param	output
	 * @return
	 */
	inline public static function toMatrix( input:Quaternion, output:IMatrix33 ):IMatrix33 
	{
		var xx:Float = input.x * input.x;
		var xy:Float = input.x * input.y;
		var xz:Float = input.x * input.z;
		var xw:Float = input.x * input.w;
		
		var yy:Float = input.y * input.y;
		var yz:Float = input.y * input.z;
		var yw:Float = input.y * input.w;
		
		var zz:Float = input.z * input.z;
		var zw:Float = input.z * input.w;		
		
		output.m11 = 1 - 2 * ( yy + zz );
		output.m21 =     2 * ( xy + zw );
		output.m31 =     2 * ( xz - yw );
		
		output.m12 =     2 * ( xy - zw );
		output.m22 = 1 - 2 * ( xx + zz );
		output.m32 =     2 * ( yz + xw );
		
		output.m13 =     2 * ( xz + yw );
		output.m23 =     2 * ( yz - xw );
		output.m33 = 1 - 2 * ( xx + yy );
		
		return output;
	}
	
	/**
	 * 
	 * @param	input
	 * @param	output
	 * @return
	 */
	inline public static function setMatrix( input:IMatrix44, output:Quaternion ):Quaternion 
	{
		var t:Float = input.m11 + input.m22 + input.m33 + input.m44;
		
		var m0:Float = input.m11; 
		var m5:Float = input.m22; 
		var m10:Float = input.m33;
		
		var s:Float;
		
		if( t > 0.0000001 )
		{
			s = Math.sqrt( t ) * 2;
			
			output.x = ( input.m32 - input.m23 ) / s;
			output.y = ( input.m13 - input.m31 ) / s;
			output.z = ( input.m21 - input.m12 ) / s;
			output.w = 0.25 * s;
		}
		else if( m0 > m5 && m0 > m10 )
		{
			s = Math.sqrt( 1 + m0 - m5 - m10 ) * 2;
			
			output.x = 0.25 * s;
			output.y = ( input.m21 + input.m12 ) / s; // transpose!
			output.z = ( input.m13 + input.m31 ) / s;
			output.w = ( input.m32 - input.m23 ) / s;
		}
		else if( m5 > m10 )
		{
			s = Math.sqrt( 1 + m5 - m0 - m10 ) * 2;			
			
			output.x = ( input.m21 + input.m12 ) / s;
			output.y = 0.25 * s;
			output.z = ( input.m32 + input.m23 ) / s;
			output.w = ( input.m13 - input.m31 ) / s;			
		}
		else
		{
			s = Math.sqrt( 1 + m10 - m5 - m0 ) * 2;			
			
			output.x = ( input.m13 + input.m31 ) / s;
			output.y = ( input.m32 + input.m23 ) / s;
			output.z = 0.25 * s;
			output.w = ( input.m21 - input.m12 ) / s;
		}
		
		return output;
	}
	
	// ---------------------------------- //
	// ---------------------------------- //
	
	/**
	* Returns the Yaw (pan) in Radians. Yaw, pitch and roll values of a Quaternion are
	* arbitrary compared to input.
	*
	* @return Yaw value in radians.
	*/
	inline public function getYaw( q:Quaternion ):Float 
	{
		return Math.asin( -2. * (q.x * q.z - q.y * q.w) );
	}
	
	/**
	* Returns the pitch in radians. Yaw, pitch and roll values of a Quaternion are
	* arbitrary compared to input.
	*
	* @return Pitch value in radians
	*/
	inline public function getPitch( q:Quaternion ):Float
	{
		return Math.atan2( 2.*(q.y * q.z + q.x * q.w), q.w * q.w - q.x * q.x - q.y * q.y + q.z * q.z );
	}

	/**
	* Returns the roll in radians. Yaw, pitch and roll values of a Quaternion are
	* arbitrary compared to input.
	*
	* @return Roll value in radians.
	*/
	inline public function getRoll( q:Quaternion ):Float
	{
		return Math.atan2( 2.*(q.x * q.y + q.z * q.w), q.w * q.w + q.x * q.x - q.y * q.y - q.z * q.z );
	}
	
	/**
	 * compares each component for equality using ZERO_TOLERANCE
	 * 
	 * @param	output 	true when all components are equal
	 * @return			given output object
	 */
	inline public static function isEqual( a:Quaternion, b:Quaternion ):Bool
	{
		if ( !MathUtil.isEqual(a.x, b.x) ) return false;		
		if ( !MathUtil.isEqual(a.y, b.y) ) return false;
		if ( !MathUtil.isEqual(a.z, b.z) ) return false;
		if ( !MathUtil.isEqual(a.w, b.w) ) return false;		
		
		return true;
	}
}