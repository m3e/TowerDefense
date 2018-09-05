package towers {
	
	
	
	import sounds.SoundManager;
	public class Woodsman extends Tower {
		
		
		public function Woodsman() {
			tName = "Woodsman";
			super();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffType:Array = new Array;
			
			var debuffsArray:Array = new Array;
			
			debuffType.push("poison",.20,10,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
		
	}
	
}
