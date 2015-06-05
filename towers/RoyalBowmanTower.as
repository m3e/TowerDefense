﻿package towers {
	
	
	
	
	public class RoyalBowmanTower extends Tower {
		
		
		public function RoyalBowmanTower() {
			super();
			tBaseColor = 0xCC33FF
			tRange = 125
			tDmg = 10;
			tAtkSpeed = 4;
			tbSpeed = 20;
			tCost = 280;
			tType = "phys"
			bFrame = 5;
			tDescription = "The Royal Bowman.  Shoots 6 shots a second.  Applies -5 armor on the enemy it hits.  Larger range.  Cost: "+tCost.toString()
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//brittle
			debuffType.push("brittle",5,4)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
