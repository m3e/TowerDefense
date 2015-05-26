package towers {
	

	
	
	public class IceSpike extends Tower {
		
		
		public function IceSpike() {
			super();
			tBaseColor = 0x3399FF
			tRange = 600
			tDmg = 15;
			tAtkSpeed = 5;
			tbSpeed = 15;
			tAoe = 0;
			// constructor code
		}
		override internal function fire():void
		{
			var newBullet:IceSpikeBullet = new IceSpikeBullet(enemyList);
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
