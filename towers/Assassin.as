package towers {
	
	import flash.display.MovieClip;
	
	
	public class Assassin extends Tower {
		
		
		public function Assassin() {
			tName = "Assassin";
			super()
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("poison",.15,5,5)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
