package common
{
	import flash.display.Sprite;
	import towers.Tower;

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
		public static var fRate:int = 24
		public static var gamePaused:Boolean;
		public static var towerList:Array = new Array;
		public static var bulletList:Array = new Array;
		public static var skillsList:Array = new Array;

		public function Commons()
		{
			// constructor code
		}
		public static function addSkillsList(s:Object):void
		{
			skillsList.push(s)
		}
		public static function removeSkillsList(s:Object):void
		{
			skillsList.splice(skillsList.indexOf(s),1)
		}
		public static function addBulletList(b:Object):void
		{
			bulletList.push(b)
		}
		public static function removeBulletList(b:Object):void
		{
			bulletList.splice(bulletList.indexOf(b),1)
		}
		public static function addTowerList(t:Object):void
		{
			//trace("T added: ", t)
			//trace("Before: ", towerList)
			towerList.push(t);
			//trace("After: ", towerList)
		}
		public static function removeTowerList(t:Object):void
		{
			//trace("T removed: ", t);
			//trace("Before: ", towerList)
			towerList.splice(towerList.indexOf(t),1)
			//trace("After: ", towerList)
		}
		public static function pauseGame():void
		{
			gamePaused = true;
			for (var s:int=0; s < skillsList.length; s++)
			{
				
				skillsList[s].pausedGame()
			}
			for (var i:int=0; i < enemyList.length; i++)
			{
				enemyList[i].pausedGame();
			}
			for (var t:int=0; t < towerList.length; t++)
			{
				towerList[t].pausedGame()
			}
			for (var b:int=0; b < bulletList.length; b++)
			{
				bulletList[b].pausedGame();
			}
			trace("SkillsList: ",skillsList.length,"EnemyList: ",enemyList.length,"TowerList: ",towerList.length,"BulletList: ",bulletList.length)
		}
		public static function resumeGame():void
		{
			gamePaused = false;
			for (var s:int=0; s < skillsList.length; s++)
			{
				skillsList[s].resumedGame()
			}
			for (var i:int=0; i < enemyList.length; i++)
			{
				enemyList[i].resumedGame();
			}
			for (var t:int=0; t < towerList.length; t++)
			{
				towerList[t].resumedGame()
			}
			for (var b:int=0; b < bulletList.length; b++)
			{
				bulletList[b].resumedGame();
			}
		}
		public static function enemyAlive(eTarget:Object):Boolean
		{
			var eAlive:Boolean;
			eAlive = (enemyList.indexOf(eTarget) != -1)
			return eAlive
		}
		public static function setMapArray(newMap:Array)
		{
			mapArray = newMap;
		}
		public static function setRoundsList(newRL:Array)
		{
			roundsList = newRL;
		}
		public static function getRoundsList():Array
		{
			return roundsList;
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