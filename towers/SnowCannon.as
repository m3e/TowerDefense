package towers
{

	import flash.events.Event;
	import flash.geom.ColorTransform;
	import debuffs.*;

	public class SnowCannon extends Tower
	{

		public function SnowCannon()
		{
			tName = "Snow Cannon";
			super();
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.25,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
		

	}

}