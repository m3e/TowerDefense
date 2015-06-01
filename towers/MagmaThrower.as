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
			tCost = 400;
			tType = "fire"
			bFrame = 2
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
