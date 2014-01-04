package math;

import at.dotpoint.math.vector.Vector2;
import at.dotpoint.math.vector.Vector3;
import massive.munit.Assert;

/**
 * ...
 * @author RK
 */
class Vector2Test
{

	public function new() {		
	}
	
	/**
	 * 
	 */
	@Test
	public function testSubstract():Void
	{
		var v1:Vector2 = new Vector2( 1, 2 );
		var v2:Vector2 = new Vector2( 1, 2 );
		
		var v3:Vector2 = Vector2.subtract( v1, v2 );
		
		Assert.areEqual( 0, v3.x );
		Assert.areEqual( 0, v3.y );
	}
	
	/**
	 * 
	 */
	@Test
	public function testAdd():Void
	{
		var v1:Vector2 = new Vector2( 1, 2 );
		var v2:Vector2 = new Vector2( 1, 2 );
		
		var v3:Vector2 = Vector2.add( v1, v2 );
		
		Assert.areEqual( 2, v3.x );
		Assert.areEqual( 4, v3.y );
	}
	
	/**
	 * 
	 */
	@Test
	public function testScale():Void
	{
		var v1:Vector2 = new Vector2( 2, 3 );
		var v3:Vector2 = Vector2.scale( v1, 2 );		
		
		Assert.areEqual( 4, v3.x );
		Assert.areEqual( 6, v3.y );
		
		//
		var v2:Vector2 = new Vector2( 0, 1 );
		var v4:Vector2 = Vector2.scale( v2, 2 );
		
		Assert.areEqual( 0, v4.x );
		Assert.areEqual( 2, v4.y );
	}
	
	/**
	 * 
	 */
	@Test
	public function testNormalize():Void
	{
		var v1:Vector2 = new Vector2( 1, 2 );
			v1.normalize();
		
		Assert.areEqual( 0.4472135954999579, v1.x );	
		Assert.areEqual( 0.8944271909999159, v1.y );		
	}
	
}