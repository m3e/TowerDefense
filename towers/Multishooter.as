package towers {
	
	import flash.display.MovieClip;
	
	
	public class Multishooter extends Tower {
		
		
		public function Multishooter() {
			super();
			tRange = 100
			tDmg = 4;
			tAtkSpeed = 4;
			tbSpeed = 30;
			tCost = 90;
			tType = "fire"
			bFrame = 7;			
			tFrame = 21;
			tNumberOfTargets = 3;
			

			tDescription = "Hits 3 people at once.  Great vs great, weak vs low numbers.";
			// constructor code
		}
		
	}
	
}
