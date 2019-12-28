package towers {
	
	import flash.display.MovieClip;
	
	
	public class IceMaker extends Tower {
		
		
		public function IceMaker() {
			tName = "Ice Maker"
			super()
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.25,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
