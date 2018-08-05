package towers {
	
	
	
	
	public class RoyalBowman extends Tower {
		
		
		public function RoyalBowman() {
			super();
			tBaseColor = 0xcd61f4
			tRange = 125
			tDmg = 10;
			tAtkSpeed = 4;
			tbSpeed = 20;
			tCost = 180;
			tType = "phys"
			bFrame = 5;
			tDescription = "The Royal Bowman.  Shoots 6 shots a second.  Applies -3 armor for 3 seconds on the enemy it hits.  Larger range.  Cost: "+tCost.toString()
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//brittle
			debuffType.push("brittle",3,3)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
