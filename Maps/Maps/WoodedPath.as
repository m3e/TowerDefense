﻿package Maps.Maps {
	
	import flash.display.MovieClip;
	
	
	public class WoodedPath extends MapSelections {
		
		
		public function WoodedPath() {
			super()
			mapID = "WoodedPath"
			gameName = "Wooded Path"
		}
		override internal function setMapArray():void
		{
			mapArray = [  
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,1,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,1,4,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,4,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,4,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[1,1,1,1,1,4,0,0,0,0,0,0,1,2,0,0,0,0,0,0,1,1,1,1,1,1,1,1],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,4,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,4,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,4,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]];
		}
	}
	
}
