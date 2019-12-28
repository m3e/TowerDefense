package towers {
	
	import flash.display.MovieClip;
	
	
	public class DeathKnight extends Tower {
		
		
		public function DeathKnight() {
			tName = "Death Knight"
			super()
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array  ;

			var debuffType:Array = new Array  ;

			//penitence
			debuffType.push("penitence",.15,2);
			debuffsArray.push(debuffType);
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
