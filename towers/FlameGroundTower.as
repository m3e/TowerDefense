package towers
{

	import flash.geom.ColorTransform;

	public class FlameGroundTower extends Tower
	{


		public function FlameGroundTower()
		{
			super();
			tBaseColor = 0x660000;
			tRange = 100;
			tDmg = 5;
			tAtkSpeed = 5;
			tbSpeed = 20;
			// constructor code
		}
		override internal function fire():void
		{
			loaded = false;
			loadedTimer = 0;

			var fireFlash:ColorTransform = new ColorTransform();
			fireFlash.color = 0xFF0000;
			this.transform.colorTransform = fireFlash;

			var newBullet:Bullet = new FlameGroundBullet(enemyList);
			newBullet.x = this.x;
			newBullet.y = this.y;
			newBullet.bTarget = tTarget;
			newBullet.bDmg = tDmg;
			newBullet.bSpeed = tbSpeed;
			newBullet.bAoe = tAoe;
			rootAddChild(newBullet);
		}
	}

}