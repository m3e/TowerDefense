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
			tileSide = TileSide;
			userInfo = _userInfo;
			mapArray = MapArray;
			enemyList = EnemyList;
			_root = _Root;
			//addEventListener(Event.ENTER_FRAME, startEnemies);
			createDmgDummy();
			// constructor code
		}
		private function startEnemies(e:Event):void
		{

			if (enemyTimer % 24 == 0)
			{
				var i:int;
				switch (true)
				{

					case enemyTimer >= 3960:
						i = 12;
						break;
					
					case enemyTimer >= 3600:
						i = 11;
						break;
					
					case enemyTimer >= 3240:
						i = 10;
						break;
					
					case enemyTimer >= 2880:
						i = 9;
						break;
					
					case enemyTimer >= 2520:
						i = 8;
						break;
					
					case enemyTimer >= 2160:
						i = 7;
						break;
					
					case enemyTimer >= 1800:
						i = 6;
						break;
					
					case enemyTimer >= 1440:
						i = 5;
						break;
					
					case enemyTimer >= 1080:
						i = 4;
						break;
					
					case enemyTimer >= 720:
						i = 3;
						break;
					
					case enemyTimer >= 360:
						i = 2;
						break;
					
					case enemyTimer >= 0:
						i = 1;
						break;
				}
				
				createEnemy(i);
				
			}
			enemyTimer++;
		}
		private function createDmgDummy():void
		{
			var enemy:Enemy = new dpsTestEnemy(mapArray)
			
			_root.addChild(enemy);
			enemy.x = 0;
			enemy.y = 0 * tileSide;
			enemy.pt.x = 0;
			enemy.pt.y = 0;
			enemy.addEventListener(Event.REMOVED_FROM_STAGE,enemyDead);
			enemyList.push(enemy);
		}
		private function createEnemy(i):void
		{
			var enemy:Enemy = getClass("enemies.Enemy"+i.toString()) as Enemy;
			

			//var enemy:Enemy = new Enemy1(mapArray);
			_root.addChild(enemy);
			enemy.x = 0;
			enemy.y = 0 * tileSide;
			enemy.pt.x = 0;
			enemy.pt.y = 0;
			enemy.addEventListener(Event.REMOVED_FROM_STAGE,enemyDead);
			enemyList.push(enemy);
		}
		private function enemyDead(e:Event):void
		{
			userInfo.changeGold(e.currentTarget.goldValue);
			enemyList.splice(enemyList.indexOf(e.currentTarget),1);
			e.currentTarget.removeEventListener(Event.REMOVED,enemyDead);
		}
		private function getClass(eName:String):Object
		{
			var klasa:Class = getDefinitionByName(eName) as Class;
			var instance:Object = new klasa(mapArray);
			return (instance);
		}
	}

}