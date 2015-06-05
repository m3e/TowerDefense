package towers {
	
	
	
	
	public class Woodsman extends Tower {
		
		
		public function Woodsman() {
			super();
			tBaseColor = 0x33CC33
			tRange = 95
			tDmg = 20;
			tAtkSpeed = 12;
			tbSpeed = 20;
			tCost = 250;
			tType = "earth"
			bFrame = 5;
			tNumberOfTargets = 2
			tDescription = "The Woodsman.  Shoots Earth arrows, can hit two targets, fires twice a second and applies slight poison + 15% slow (poison slow stacks with ice). Cost: "+tCost.toString();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("poison",.15,5,3)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
