package towers
{

	import flash.events.Event;
	import flash.geom.ColorTransform;
	import debuffs.*;

	public class ScorchedEarth extends Tower
	{

		


		public function ScorchedEarth()
		{
			super();
			
			tBaseColor = 0x660000;
			tRange = 50;
			tDmg = 10;
			tAtkSpeed = 8;
			tbSpeed = 50;
			tCost = 220;
			tType = "fire"
			tFrame = 14
			targeting = "All"
			tDescription = "Burns the ground in a 1 block AoE (very short range!) dealing 50 damage a second to anything in its range.  Strong.  Cost: "+tCost.toString();
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