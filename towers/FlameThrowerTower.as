package towers {
	
	
	
	
	public class FlameThrowerTower extends Tower {
		
		
		public function FlameThrowerTower() {
			super()
			tBaseColor = 0xFF3300
			tRange = 85
			tDmg = 5;
			tAtkSpeed = 2;
			tAoe = 0
			tbSpeed = 8;
			// constructor code
		}
		override internal function fire():void
		{
			var newBullet:Bullet = new Bullet(enemyList);
			newBullet.gotoAndStop(2);
			newBullet.x = this.x;
			newBullet.y = this.y;
			newBullet.bTarget = tTarget;
			newBullet.bDmg = tDmg;
			newBullet.bSpeed = tbSpeed;
			newBullet.bAoe = tAoe;
			_root.addChild(newBullet);
		}
	}
	
}
