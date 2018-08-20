package common {
	import flash.display.Sprite;
	
	public class Commons extends Sprite{

		public static var mapWidth:int;
		public static var mapHeight:int;
		public static var tileSide:int = 32;
		public static var mapArray:Array;
		
		public function Commons() {
			
			// constructor code
		}
		public static function getMapArray():Array
		{
			mapArray = [  
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,1,1,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,1,1,1,2,0,0,0,0,4,0,0,0,2,0,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[0,0,0,0,2,0,0,0,0,4,0,0,0,2,0,4,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,1,1,1,1,1,4,0,2,3,3,0,4,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]];
			
			mapWidth = mapArray[0].length
			mapHeight = mapArray.length;
			
			return mapArray;
		}
		public static function dist(firstX:int,firstY:int,secondX:int,secondY:int):int
		{
			var dist:int = Math.abs(firstX - secondX) + Math.abs(firstY - secondY)
			return dist
		}
		public static function checkB(xCo:int,yCo:int):Boolean
		{
			var inBounds:Boolean;
			
			if (xCo >= 0 && xCo < mapWidth && yCo >= 0 && yCo < mapHeight)
			{
				inBounds = true;
			}

			return inBounds;
		}
		
		public static function newTheMap(array:Array):Array
		{
			var newArray:Array = new Array  ;
			for (var i:int = 0; i < array.length; i++)
			{
				var content:* = array[i];
				if (content is Array)
				{
					newArray[i] = newTheMap(content);
				}
				else
				{
					newArray[i] = content;
				}
			}
			return newArray
		}

	}
	
}
