package towers {
	
	
	
	
	public class Woodsman extends Tower {
		
		
		public function Woodsman() {
			super();
			tBaseColor = 0x66a843
			tRange = 95
			tDmg = 60;
			tAtkSpeed = 24;
			tbSpeed = 20;
			tCost = 120;
			tType = "earth"
			bFrame = 5;
			tNumberOfTargets = 1
			tDescription = "The Woodsman.  Shoots Earth arrows, poisons 5 dps + slow 35% for 2 seconds.  Single target. Cost: " + tCost.toString();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffType:Array = new Array;
			
			var debuffsArray:Array = new Array;
			
			debuffType.push("poison",.35,5,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
