package towers {
	
	import flash.display.MovieClip;
	
	
	public class Mars extends Tower {
		
		
		public function Mars() {
			tName = "Mars"
			super()
			targeting = "All"
			// constructor code
		}
		override internal function fire():void
		{

			var newBullet:FlameGroundBullet;
			for (var i:int=0; i < tTarget.length; i++)
			{
				tTarget[i].takeDmg(tDmg * (1 + tDmgBuff),tType);
				newBullet = new FlameGroundBullet(tTarget[i]);
				newBullet.x = tTarget[i].x;
				newBullet.y = tTarget[i].y;
				_root.addChild(newBullet);
			}
			tTarget.length = 0
			
		}
	}
	
}
