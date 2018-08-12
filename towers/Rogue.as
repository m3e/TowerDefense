package towers {
	

	
	
	public class Rogue extends Tower {
		
		
		public function Rogue() {
			super();
			tBaseColor = 0x5f5e77
			tRange = 100
			tDmg = 25;
			tAtkSpeed = 20;
			tbSpeed = 30;
			tNumberOfTargets = 2;
			tCost = 175;
			tType = "phys"
			tFrame = 9
			tDescription = "The Rogue.  Hits two targets at once.  Applies 1 dmg every second for 5 seconds per hit and slows by 15%.  Cost: "+ tCost.toString();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("poison",.15,5,1)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
