package towers {
	
	
	import debuffs.Debuff
	
	public class IceTower extends Tower {
		
		
		public function IceTower() {
			
			tName = "Ice Tower";
			super()
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.22,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}

		
	}
	
}
