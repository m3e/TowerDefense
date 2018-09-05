package towers {
	
	
	
	
	public class MagmaThrower extends Tower {
		
		
		public function MagmaThrower() {
			tName = "Magma Thrower";
			super();
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
