package towers {
	
	
	
	
	public class MagmaThrower extends Tower {
		
		
		public function MagmaThrower() {
			super();
			tBaseColor = 0xFF9900
			tRange = 150
			tDmg = 40;
			tAtkSpeed = 38;
			tbSpeed = 36;
			tAoe = 85;
			tCost = 160;
			tType = "fire"
			bFrame = 2
			tFrame = 13	
			tDescription = "Throws large fireballs that explode in an AoE and deal 5 burning damage to all caught for 3 seconds.  Slow attack speed.  Cost: "+tCost.toString();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("burn",5,3)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
