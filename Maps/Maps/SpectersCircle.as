﻿package Maps.Maps {
	
	import flash.display.MovieClip;
	
	public class SpectersCircle extends MapSelections {
		
		
		public function SpectersCircle() {
			super()
			// constructor code
		}
		override internal function setMapArray():void
		{
			mapArray = [  
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,],
			[0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,4,0,2,3,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,4,0,2,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,4,0,2,0,0,0,1,1,2,0,0,0,0,0,4,0,0,0,0,0,0,],
			[1,1,2,0,0,0,0,4,0,2,0,0,0,4,0,2,0,0,0,0,0,4,0,0,0,0,0,0,],
			[0,0,2,0,0,0,0,4,0,1,1,1,1,4,0,1,1,1,2,0,0,4,0,0,0,0,0,0,],
			[0,0,2,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,2,0,0,4,0,0,0,0,0,0,],
			[0,0,2,0,0,0,0,4,3,3,3,3,3,3,3,3,3,3,3,0,0,4,0,0,0,0,0,0,],
			[0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,],
			[0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]];
		}
	}
	
}