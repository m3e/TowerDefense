package common
{
	import flash.display.Sprite;

	public class Commons extends Sprite
	{

		public static var mapWidth:int;
		public static var mapHeight:int;
		public static var tileSide:int = 32;
		public static var mapArray:Array;
		public static var enemyList:Array = new Array;
		public static var _root:Object;
		public static var towerArray:Array = new Array;
		public static var tileArray:Array = new Array;
		public static var roundsList:Array = new Array;

		public function Commons()
		{
			// constructor code
		}
		public static function setMapArray(newMap:Array)
		{
			mapArray = newMap;
		}
		public static function setRoundsList(newRL:Array)
		{
			roundsList = newRL;
		}
		public static function getMapArray():Array
		{
			mapWidth = mapArray[0].length;
			mapHeight = mapArray.length;

			return mapArray;
		}
		public static function getEnemyList():Array
		{
			return enemyList;
		}
		public static function setRoot(rO:Object)
		{
			_root = rO;
		}
		public static function getRoot():Object
		{
			return _root;
		}
		public static function setTowerArray(tO:Array)
		{
			towerArray = tO;
		}
		public static function getTowerArray():Array
		{
			return towerArray;
		}
		public static function dist(firstX:int,firstY:int,secondX:int,secondY:int):int
		{
			var dist:int = Math.abs(firstX - secondX) + Math.abs(firstY - secondY);
			return dist;
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
			return newArray;
		}

	}

}