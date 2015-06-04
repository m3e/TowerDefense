package enemies
{

	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.events.*;
	import enemies.*;

	public class InitiateEnemies extends Sprite
	{

		private var mapArray:Array;
		private var enemyList:Array;
		private var _root:Object;
		private var userInfo:UserInfo;
		private var tileSide:int;
		
		public var roundInProgress:Boolean;
		private var roundNumber:int;

		private var enemy:Enemy;
		private var enemy1:Enemy1;
		private var enemy2:Enemy2;
		private var enemy3:Enemy3;
		private var enemy4:Enemy4;
		private var enemy5:Enemy5;
		private var enemy6:Enemy6;
		private var enemy7:Enemy7;
		private var enemy8:Enemy8;
		private var enemy9:Enemy9;
		private var enemy10:Enemy10;
		private var enemy11:Enemy11;
		private var enemy12:Enemy12;

		private var enemyTimer:int;


		public function InitiateEnemies(MapArray:Array, EnemyList:Array,_Root:Object,_userInfo:UserInfo,TileSide:int)
		{
			roundNumber = 1;
			tileSide = TileSide;
			userInfo = _userInfo;
			mapArray = MapArray;
			enemyList = EnemyList;
			_root = _Root;
			//startRound();
			//createDmgDummy();
			// constructor code
		}
		public function startRound():void
		{
			roundInProgress = true;
			addEventListener(Event.ENTER_FRAME, startEnemies);
		}
		private function stopRound():void
		{
			roundNumber++
			roundInProgress = false;
			removeEventListener(Event.ENTER_FRAME, startEnemies);
		}
		private function startEnemies(e:Event):void
		{

			if (enemyTimer % 24 == 0)
			{
				createEnemy(roundNumber);
			}
			if (enemyTimer % 360 == 0 && enemyTimer != 0 && !(enemyTimer >= 360*12))
			{
				stopRound()
			}
			enemyTimer++;
		}
		public function createDmgDummy():void
		{
			var enemy:Enemy = new dpsTestEnemy(mapArray)
			
			_root.addChild(enemy);
			enemy.x = 0;
			enemy.y = 6 * tileSide;
			enemy.pt.x = 0;
			enemy.pt.y = 6;
			enemy.addEventListener(Event.REMOVED_FROM_STAGE,enemyDead);
			enemyList.push(enemy);
		}
		private function createEnemy(i):void
		{
			var enemy:Enemy = getClass("enemies.Enemy"+i.toString()) as Enemy;
			

			//var enemy:Enemy = new Enemy1(mapArray);
			_root.addChild(enemy);
			enemy.x = 0;
			enemy.y = 6 * tileSide;
			enemy.pt.x = 0;
			enemy.pt.y = 6;
			enemy.addEventListener(Event.REMOVED_FROM_STAGE,enemyDead);
			enemyList.push(enemy);
		}
		private function enemyDead(e:Event):void
		{
			if (e.currentTarget.killed)
			{
				userInfo.changeGold(e.currentTarget.goldValue);
			}
			else
			{
				userInfo.updateLives(1);
			}
			enemyList.splice(enemyList.indexOf(e.currentTarget),1);
			e.currentTarget.removeEventListener(Event.REMOVED,enemyDead);
			if(userInfo.lives <= 0)
			{
				trace("Game over");
			}
		}
		private function getClass(eName:String):Object
		{
			var klasa:Class = getDefinitionByName(eName) as Class;
			var instance:Object = new klasa(mapArray);
			return (instance);
		}
	}

}