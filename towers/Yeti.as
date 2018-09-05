package towers {
	
	import flash.display.MovieClip;
	
	
	public class Yeti extends Tower {
		
		
		public function Yeti() {
			tName = "Yeti"
			super()
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.2,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
