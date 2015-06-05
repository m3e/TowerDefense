package towers {
	
	
	
	
	public class MagmaThrower extends Tower {
		
		
		public function MagmaThrower() {
			super();
			tBaseColor = 0xFF9900
			tRange = 150
			tDmg = 15;
			tAtkSpeed = 32;
			tbSpeed = 36;
			tAoe = 50;
			tCost = 350;
			tType = "fire"
			bFrame = 2
			tDescription = "Throws large fireballs that explode in an AoE and deal 10 burning damage to all caught 3 seconds.  Slow attack speed.  Cost: "+tCost.toString();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("burn",10,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
