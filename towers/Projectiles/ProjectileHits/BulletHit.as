package towers.Projectiles.ProjectileHits {
	
	import flash.display.MovieClip;
	
	
	public class BulletHit extends ProjectileHit {
		
		
		public function BulletHit(eTarget:Object,angle:Number) {
			super(eTarget,angle)
			eAlivePlay = false;
			// constructor code
		}
		override protected function specialFrame():void
		{
			this.x += (4 - (Math.random()*8))
			this.y += (3 - (Math.random()*6))
		}
	}
	
}
