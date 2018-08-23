package towers {
	
	import flash.display.MovieClip;
	import towers.Multishooter;
	
	
	public class Lightning extends Tower {
		
		
		public function Lightning() {
			super();
			tRange = 140
			tDmg = 4;
			tAtkSpeed = 4;
			tbSpeed = 30;
			tCost = 65;
			tType = "fire"
			bFrame = 7;			
			tFrame = 20;
			

			tDescription = "I dare you to touch it.  Electricity travels fast and far.  Hey, what's this knob do?";
			// constructor code
		}
		override public function upgradeOne():Class
		{
			return Multishooter
		}
	}
	
}
