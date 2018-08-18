package towers
{

	import flash.events.Event;
	import flash.geom.ColorTransform;
	import debuffs.*;

	public class SnowMachine extends Tower
	{

		
		private var firing:Boolean;

		public function SnowMachine()
		{
			super();
			firing = false;
			tBaseColor = 0x66FFFF;
			tRange = 50;
			tDmg = 0;
			tAtkSpeed = 2;
			tCost = 220;
			tType = "ice";
			tFrame = 16
			targeting = "All"
			tDescription = "Slows all units passing through by 30% but deals no damage.";
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.3,.5)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
		

	}

}