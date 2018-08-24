package towers {
	
	import flash.display.MovieClip;
	
	
	public class Multishooter extends Tower {
		
		
		public function Multishooter() {
			super();
			tRange = 110
			tDmg = 4;
			tAtkSpeed = 4;
			tbSpeed = 30;
			tCost = 90;
			tType = "fire"
			bFrame = 7;			
			tFrame = 21;
			tNumberOfTargets = 3;
			

			tDescription = "Lower arnge, but hits 3 people at once.  Great vs groups, weak vs low numbers.";
			// constructor code
		}
		
	}
	
}
