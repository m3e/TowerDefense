package enemies
{

	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.events.*;
	import enemies.*;
	import common.Commons;
	import enemies.skills.EnemySkillManager;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class InitiateEnemies extends Sprite
	{

		private var mapArray:Array;
		private var enemyList:Array;
		private var _root:Object;
		private var tileSide:int;

		private var enemy:Enemy;

		private var enemySkillManager:EnemySkillManager;

		public function InitiateEnemies()
		{

			tileSide = common.Commons.tileSide;
			mapArray = common.Commons.getMapArray();
			enemyList = common.Commons.getEnemyList();
			enemySkillManager = new EnemySkillManager();

			_root = common.Commons.getRoot();
			// constructor code
		}
		public function createDmgDummy():dpsTestEnemy
		{
			var enemy:dpsTestEnemy = new dpsTestEnemy(mapArray);
			var startX:int = common.Commons.startX;
			var startY:int = common.Commons.startY;
			enemy.x = startX * tileSide;
			enemy.y = startY * tileSide;
			enemy.pt.x = startX;
			enemy.pt.y = startY;
			_root.bmEnemy.addChild(enemy);
			enemyList.push(enemy);
			
			return enemy;
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
			enemy.bmpData = waveArray[13];
			
			for (var i:int=0 ; i < 3; i++)
			{
				if (waveArray[(10 + i)] != "")
				{
					enemySkillManager.addSkillToEnemy(enemy,waveArray[i]);
				}
			}
			
			var startX:int = common.Commons.startX;
			var startY:int = common.Commons.startY;
			enemy.x = startX * tileSide;
			enemy.y = startY * tileSide;
			enemy.pt.x = startX;
			enemy.pt.y = startY;
			enemy.updateHealth();
			_root.bmEnemy.addChild(enemy);
			if (!(_root.healthBarOn))
			{
				enemy.healthBarOnOff();
			}
			enemyList.push(enemy);

			return enemy;


		}
		public function endClass():void
		{
			enemy = null;
			_root = null;
			enemyList = null;

			enemySkillManager.endClass();
			enemySkillManager = null;
		}
	}

}