package assets.maptiles {
	
	import flash.display.MovieClip;
	
	public class Ice extends MovieClip {
		
		public function Ice() {
			gotoAndStop(Math.ceil(Math.random() * 4));
			alpha = .3
			// constructor code
		}
	}
	
}
