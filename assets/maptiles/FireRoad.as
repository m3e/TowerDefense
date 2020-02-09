package assets.maptiles {
	
	import flash.display.MovieClip;
	
	
	public class FireRoad extends MovieClip {
		
		
		public function FireRoad() {
			gotoAndStop(Math.ceil(Math.random() * 4));
			alpha = .3
			// constructor code
		}
	}
	
}
