package towers {
	
	
	import debuffs.Debuff
	
	public class IceTower extends Tower {
		
		
		public function IceTower() {
			super()
			tBaseColor = 0x330099
			tRange = 100
			tDmg = 15;
			tAtkSpeed = 24;
			tAoe = 25
			tbSpeed = 24;
			bFrame = 3;
			tCost = 200;
			tType = "ice"
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.40,3)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
		
		
	}
	
}
