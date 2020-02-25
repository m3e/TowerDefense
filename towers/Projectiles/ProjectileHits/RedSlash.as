package towers.Projectiles.ProjectileHits
{

	import flash.display.MovieClip;


	public class RedSlash extends ProjectileHit
	{

		public function RedSlash(eTarget:Object,angle:Number)
		{
			super(eTarget,angle,true);
			eAlivePlay = false;
		}
	}

}