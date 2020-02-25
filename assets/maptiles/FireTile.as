package assets.maptiles {
	
	import flash.display.MovieClip;
	
	
	public class FireTile extends MovieClip {
		
		
		public function FireTile() {
			gotoAndStop(Math.ceil(Math.random() * 4));
			alpha = .3
			// constructor code
		}
	}
	
}
