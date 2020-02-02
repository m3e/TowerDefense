package enemies
{

	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.events.*;
	import enemies.*;
	import common.Commons;

	public class InitiateEnemies extends Sprite
	{

		private var mapArray:Array;
		private var enemyList:Array;
		private var _root:Object;
		private var tileSide:int;

		private var enemy:Enemy;

		public var healthBarOn:Boolean;


		public function InitiateEnemies()
		{

			tileSide = common.Commons.tileSide;
			mapArray = common.Commons.getMapArray();
			enemyList = common.Commons.getEnemyList();
			_root = common.Commons.getRoot();
			// constructor code
		}

		public function createDmgDummy():void
		{
			var enemy:Enemy = new dpsTestEnemy(mapArray);
			enemy.x = 0;
			enemy.y = 6 * tileSide;
			enemy.pt.x = 0;
			enemy.pt.y = 6;
			enemy.addEventListener(Event.REMOVED_FROM_STAGE,enemyDead);
			_root.addChild(enemy);
			enemyList.push(enemy);
		}
		public function customEnemy(waveArray:Array, roundBonus:Boolean):Enemy
		{
			
			
				var enemy:Enemy = new Enemy(mapArray);
				enemy.eMaxHp = waveArray[0];
				enemy.maxMoveSpeed = waveArray[1];
				enemy.goldValue = waveArray[2];
				enemy.maxArmor = waveArray[3];
				enemy.eFrame = waveArray[6];
				enemy.armorType = waveArray[7];
				enemy.eName = waveArray[9]
				_root.addChild(enemy);
				enemy.x = 0;
				enemy.y = 6 * tileSide;
				enemy.pt.x = 0;
				enemy.pt.y = 6;
				enemy.updateHealth();
				if (!(healthBarOn))
				{
					enemy.healthBarOnOff();
				}
				enemy.addEventListener(Event.REMOVED_FROM_STAGE,enemyDead);
				enemyList.push(enemy);
				
				return enemy;
				
				
		}
		private function enemyDead(e:Event):void
		{
			if (e.currentTarget.killed)
			{
				UserInfo.changeGold(e.currentTarget.goldValue);
			}
			else if (e.currentTarget.removeLife)
			{
				UserInfo.updateLives(1);
			}
			else
			{
				if (e.currentTarget is dpsTestEnemy)
				{
					//do nothing
				}
			}
			//enemyList = common.Commons.getEnemyList();
			enemyList.splice(enemyList.indexOf(e.currentTarget),1);
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE,enemyDead);
			if (UserInfo.lives <= 0)
			{
				trace("Game over");
			}
		}
		public function endClass():void
		{
			enemy = null;
			_root = null;
		}
		/*private function getClass(eName:String):Object
		{
			var klasa:Class = getDefinitionByName(eName) as Class;
			var instance:Object = new klasa(mapArray);
			return (instance);
		}*/
	}

}