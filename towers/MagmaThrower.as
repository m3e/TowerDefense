package towers {
	
	
	
	
	public class MagmaThrower extends Tower {
		
		
		public function MagmaThrower() {
			super();
			tBaseColor = 0xFF9900
			tRange = 625
			tDmg = 25;
			tAtkSpeed = 60;
			tbSpeed = 36;
			tAoe = 50;
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
