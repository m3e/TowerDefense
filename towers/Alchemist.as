package towers {
	
	import flash.display.MovieClip;
	
	
	public class Alchemist extends Tower {
		
		
		public function Alchemist() {
			tName = "Alchemist";
			super();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffType:Array = new Array;
			
			var debuffsArray:Array = new Array;
			
			debuffType.push("poison",.18,5,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
