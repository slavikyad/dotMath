package math;

import at.dotpoint.math.vector.Vector3;
import at.dotpoint.math.vector.Vector3;
import massive.munit.Assert;

/**
 * ...
 * @author RK
 */
class Vector3Test
{

	public function new() {		
	}
	
	/**
	 * 
	 */
	@Test
	public function testSubstract():Void
	{
		var v1:Vector3 = new Vector3( 1, 2, 3 );
		var v2:Vector3 = new Vector3( 1, 2, 3 );
		
		var v3:Vector3 = Vector3.subtract( v1, v2 );
		
		Assert.areEqual( 0, v3.x );
		Assert.areEqual( 0, v3.y );
		Assert.areEqual( 0, v3.z );
		Assert.areEqual( 1, v3.w );
	}
	
	/**
	 * 
	 */
	@Test
	public function testAdd():Void
	{
		var v1:Vector3 = new Vector3( 1, 2, 3 );
		var v2:Vector3 = new Vector3( 1, 2, 3 );
		
		var v3:Vector3 = Vector3.add( v1, v2 );
		
		Assert.areEqual( 2, v3.x );
		Assert.areEqual( 4, v3.y );
		Assert.areEqual( 6, v3.z );
		Assert.areEqual( 1, v3.w );
	}
	
	/**
	 * 
	 */
	@Test
	public function testScale():Void
	{
		var v1:Vector3 = new Vector3( 2, 3, 4 );
		var v3:Vector3 = Vector3.scale( v1, 2 );		
		
		Assert.areEqual( 4, v3.x );
		Assert.areEqual( 6, v3.y );
		Assert.areEqual( 8, v3.z );
		Assert.areEqual( 1, v3.w );
		
		//
		var v2:Vector3 = new Vector3( 0, 1, 3 );
		var v4:Vector3 = Vector3.scale( v2, 2 );
		
		Assert.areEqual( 0, v4.x );
		Assert.areEqual( 2, v4.y );
		Assert.areEqual( 6, v4.z );
		Assert.areEqual( 1, v4.w );
	}
	
	/**
	 * 
	 */
	@Test
	public function testNormalize():Void
	{
		var v1:Vector3 = new Vector3( 1, 2, 3 );
			v1.normalize();
		
		Assert.areEqual( 0.2672612419124244, v1.x );	
		Assert.areEqual( 0.5345224838248488, v1.y );	
		Assert.areEqual( 0.8017837257372732, v1.z );	
		Assert.areEqual( 1, v1.w );	
	}
	
}