package enemies
{

	import flash.display.Sprite;
	import flash.utils.Timer;
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


		public function InitiateEnemies(MapArray:Array, EnemyList:Array,_Root:Object,_userInfo:UserInfo,TileSide:int)
		{
			tileSide = TileSide;
			userInfo = _userInfo;
			mapArray = MapArray;
			enemyList = EnemyList;
			_root = _Root;
			startEnemies();
			// constructor code
		}
		private function startEnemies():void
		{
			var numberOfEnemies:int = 99999;
			var enemySpawner:Timer = new Timer(50,numberOfEnemies);
			enemySpawner.addEventListener(TimerEvent.TIMER, createEnemies);
			enemySpawner.start();
		}
		private function createEnemies(e:TimerEvent):void
		{

			var i:int = 1 + Math.floor(Math.random() * 11);

			//var enemy:Enemy = getClass("enemies.enemy"+i.toString()+".Enemy"+i.toString()) as Enemy

			var enemy:Enemy = new Enemy8(mapArray);
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
	}

}