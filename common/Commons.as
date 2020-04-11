package common
{
	import flash.display.MovieClip;
	import towers.Tower;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import com.greensock.loading.LoaderMax;
	import flash.display.Bitmap;

	public class Commons extends MovieClip
	{

		public static var mapWidth:int;
		public static var mapHeight:int;
		public static var tileSide:int = 32;
		public static var mapArray:Array;
		public static var enemyList:Array = new Array  ;
		public static var _root:Object;
		public static var towerArray:Array = new Array  ;
		public static var tileArray:Array = new Array  ;
		public static var roundsList:Array = new Array  ;
		public static var fRate:int = 24;
		public static var gamePaused:Boolean;
		public static var towerList:Array = new Array  ;
		public static var bulletList:Array = new Array  ;
		public static var skillsList:Array = new Array  ;
		public static var enemySkillsList:Array = new Array  ;
		public static var hitList:Array = new Array  ;
		public static var startX:int = 0;
		public static var startY:int = 6;
		public static var queue:LoaderMax;

		public function Commons()
		{
			// constructor code
		}
		public static function getSprite(category:String,position:int,rect:Rectangle = null,pt:Point = null):BitmapData
		{
			if (rect == null)
			{
				rect = new Rectangle(0,0,tileSide,tileSide);
			}
			if (pt == null)
			{
				pt = new Point(0,0);
			}
			var bmpData:BitmapData;
			
			var bmp:Bitmap = queue.getContent(category).rawContent;
			var bmpWidth:int = bmp.width / tileSide
			var bmpHeight:int = bmp.height / tileSide
			
			rect.x = (position % bmpWidth) * tileSide
			rect.y = Math.floor(position / bmpWidth) * tileSide
			
			bmpData = new BitmapData(common.Commons.tileSide,common.Commons.tileSide);
			bmpData.copyPixels(bmp.bitmapData,rect,pt);
			
			return bmpData;
		}
		public static function addSkillsList(s:Object):void
		{
			skillsList.push(s);
		}
		public static function removeSkillsList(s:Object):void
		{
			skillsList.splice(skillsList.indexOf(s),1);
		}
		public static function addEnemySkillsList(s:Object):void
		{
			enemySkillsList.push(s);
		}
		public static function removeEnemySkillsList(s:Object):void
		{
			enemySkillsList.splice(skillsList.indexOf(s),1);
		}

		public static function addBulletList(b:Object):void
		{
			bulletList.push(b);
		}
		public static function removeBulletList(b:Object):void
		{
			bulletList.splice(bulletList.indexOf(b),1);
		}

		public static function addHitList(h:Object):void
		{
			hitList.push(h);
		}
		public static function removeHitList(h:Object):void
		{
			hitList.splice(hitList.indexOf(h),1);
		}

		public static function addTowerList(t:Object):void
		{
			towerList.push(t);
		}
		public static function removeTowerList(t:Object):void
		{
			towerList.splice(towerList.indexOf(t),1);
		}
		public static function pauseGame():void
		{

			gamePaused = true;
			for (var s:int=0; s < skillsList.length; s++)
			{
				skillsList[s].pausedGame();
			}
			for (var i:int=0; i < enemyList.length; i++)
			{
				enemyList[i].pausedGame();
			}
			for (var t:int=0; t < towerList.length; t++)
			{
				towerList[t].pausedGame();
			}
			for (var b:int=0; b < bulletList.length; b++)
			{
				bulletList[b].pausedGame();
			}
			for (var h:int=0; h < hitList.length; h++)
			{
				hitList[h].pausedGame();
			}
			for (var e:int=0; e < enemySkillsList.length; e++)
			{
				enemySkillsList[e].pausedGame();
			}
			trace("SkillsList: ",skillsList.length,"EnemySkillsList: ",enemySkillsList.length,"EnemyList: ",enemyList.length,"TowerList: ",towerList.length,"BulletList: ",bulletList.length,"HitList: ",hitList.length);
		}
		public static function resumeGame():void
		{
			gamePaused = false;
			for (var s:int=0; s < skillsList.length; s++)
			{
				skillsList[s].resumedGame();
			}
			for (var i:int=0; i < enemyList.length; i++)
			{
				enemyList[i].resumedGame();
			}
			for (var t:int=0; t < towerList.length; t++)
			{
				towerList[t].resumedGame();
			}
			for (var b:int=0; b < bulletList.length; b++)
			{
				bulletList[b].resumedGame();
			}
			for (var h:int=0; h < hitList.length; h++)
			{
				hitList[h].resumedGame();
			}
			for (var e:int=0; e < enemySkillsList.length; e++)
			{
				enemySkillsList[e].resumedGame();
			}
		}
		public static function enemyAlive(eTarget:Object):Boolean
		{
			var eAlive:Boolean;
			eAlive = (enemyList.indexOf(eTarget) != -1);
			return eAlive;
		}
		public static function setStartPoints(xCo:int,yCo:int):void
		{
			startX = xCo;
			startY = yCo;
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
		public static function endGame():void
		{
			while (hitList.length > 0)
			{
				hitList[0].endClass();
			}
			while (bulletList.length > 0)
			{
				bulletList[0].destroyThis();
			}
			while (towerList.length > 0)
			{
				towerList[0].destroyTower();
			}
			while (skillsList.length > 0)
			{
				skillsList[0].endClass();
			}
			while (enemySkillsList.length > 0)
			{
				enemySkillsList[0].endSkill();
			}
			while (enemyList.length > 0)
			{
				enemyList[0].destroyThis();
			}
			hitList = new Array  ;
			bulletList = new Array  ;
			towerList = new Array  ;
			skillsList = new Array  ;
			enemyList = new Array  ;
			enemySkillsList = new Array  ;
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