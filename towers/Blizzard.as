package towers {
	
	import flash.display.MovieClip;
	
	
	public class Blizzard extends Tower {
		
		
		public function Blizzard() {
			tName = "Blizzard"
			super()
			targeting = "All"
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.28,.5)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
