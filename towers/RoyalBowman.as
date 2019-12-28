package towers {
	
	
	import sounds.SoundManager;
	
	public class RoyalBowman extends Tower {
		
		
		public function RoyalBowman() {
			tName = "Royal Bowman";
			super();
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//brittle
			debuffType.push("brittle",1,3)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/

	}
	
}
