package Maps.UI
{

	import flash.display.MovieClip;
	import common.Commons;
	import assets.maptiles.*;

	public class MapPreview extends MovieClip
	{

		private var previewArray:Array = new Array  ;
		private var previewLoaded:Boolean;
		public var locked:Boolean;
		public function MapPreview()
		{
			previewArray = [  
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,],
			[1,1,1,1,1,1,1,1,1,2,0,4,0,0,2,3,1,1,1,1,1,1,1,1,1,1,1,1],
			[0,0,0,0,0,0,0,0,0,1,1,4,0,0,2,0,4,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,4,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]];
			// constructor code
		}
		public function loadMapPreview(mapArray:Array):void
		{
			if (previewLoaded == true)
			{
			removeMapPreview()
			}
			var tile:MovieClip;
			var tileSide:Number = 21
			for (var i:int=0; i < mapArray.length; i++)
			{
				for (var o:int=0; o < mapArray[i].length; o++)
				{
					switch (mapArray[i][o])
					{
						case 0 :
							tile = new Grass();
							break;

						case 1 :
						case 2 :
						case 3 :
						case 4 :
						case 9 :
							tile = new Dirt();
							break;
					}
					previewArea.addChildAt(tile,0);
					tile.x = o * tileSide
					tile.y = i * tileSide;
					tile.width = tileSide
					tile.height = tileSide
					previewArray[i][o] = tile;
					
				}
			}
			previewLoaded = true;
		}
		public function removeMapPreview():void
		{
			for (var i:int=0; i < previewArray.length; i++)
			{
				for (var o:int=0; o < previewArray[i].length; o++)
				{
					previewArea.removeChild(previewArray[i][o]);
					previewArray[i][o] = null;
				}
			}
			previewLoaded = false;
		}
	}

}