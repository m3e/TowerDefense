package towers {
	
	
	public class IceTower extends Tower {
		
		
		public function IceTower() {
			super()
			tBaseColor = 0x330099
			tRange = 100
			tDmg = 0;
			tAtkSpeed = 24;
			tAoe = 25
			tbSpeed = 20;
			// constructor code
		}
		override internal function fire():void
		{
			var newBullet:Bullet = new IceTowerBullet(enemyList);
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
