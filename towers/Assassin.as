package towers {
	

	
	
	public class Assassin extends Tower {
		
		
		public function Assassin() {
			super();
			tBaseColor = 0x003333
			tRange = 100
			tDmg = 7;
			tAtkSpeed = 3;
			tbSpeed = 30;
			tCost = 320;
			tType = "phys"
			tDescription = "Attacks 8 times a second.  Applies 1 dmg every second for 5 seconds per hit and slows by 15%.  Cost: "+ tCost.toString();
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
