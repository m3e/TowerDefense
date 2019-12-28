package towers {
	
	import flash.display.MovieClip;
	
	
	public class HotSpot extends Tower {
		
		
		public function HotSpot() {
			tName = "Hot Spot"
			super();
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("burn",15,3)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
