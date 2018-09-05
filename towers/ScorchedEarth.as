package towers
{

	import flash.events.Event;
	import flash.geom.ColorTransform;
	import debuffs.*;

	public class ScorchedEarth extends Tower
	{

		


		public function ScorchedEarth()
		{
			tName = "Scorched Earth";
			super();
			
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