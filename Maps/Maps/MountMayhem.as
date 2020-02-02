﻿package Maps.Maps {
	
	import flash.display.MovieClip;
	
	public class MountMayhem extends MapSelections {
		
		
		public function MountMayhem() {
			super()
			mapID = "MountMayhem"
			gameName = "Mount Mayhem"
		}
		override internal function setMapArray():void
		{
			mapArray = [  
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,1,1,4,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,],
			[1,1,2,0,0,0,0,0,0,1,4,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,],
			[0,0,1,2,0,0,0,0,0,4,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,1,2,0,0,0,1,4,0,0,0,0,0,0,0,2,0,0,0,0,0,1,1,1,1,1,],
			[0,0,0,0,1,1,1,1,4,0,0,0,0,0,0,0,0,1,2,0,0,0,1,4,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,4,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]];
		}
	}
	
}
