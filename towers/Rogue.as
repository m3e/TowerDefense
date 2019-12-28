package towers {
	
	import flash.events.MouseEvent;
	
	public class Rogue extends Tower {
		
		public function Rogue() {
			
			tName = "Rogue";
			super();
			// constructor code
		}
		override internal function getSounds():void
		{
			clickedOnSounds = ["roguehey","roguehowareyou"]
		}		
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("poison",.15,3,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/

	}
}
