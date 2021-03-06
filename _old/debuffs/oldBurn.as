﻿package debuffs
{

	import enemies.Enemy;
	import flash.display.Sprite;
	import flash.events.*;
	import common.Commons;


	public class Burn extends Sprite
	{

		private var enemy:Enemy;
		private var amount:Number;
		private var seconds:Number;

		private var frames:int;

		public function Burn(_enemy:Enemy, _amount:Number,_seconds:Number)
		{
			enemy = _enemy;
			amount = _amount;
			seconds = _seconds;
			
			frames = 0;
			common.Commons.addSkillsList(this)
			addEventListener(Event.ENTER_FRAME, debuffTick);
			// constructor code
		}
		public function pausedGame():void
		{
			removeEventListener(Event.ENTER_FRAME, debuffTick);
		}
		public function resumedGame():void
		{
			addEventListener(Event.ENTER_FRAME, debuffTick);
		}
		private function debuffTick(e:Event):void
		{
			//check if debuff ran out
			if (enemy != null && frames < seconds * 24)
			{
				//end check if debuff ran out
				if (frames % 12 == 0 && enemy._root != null)
				{
					newBulletOnTarget();
					enemy.takeDmg(amount,"fire");
				}
				else if (enemy._root == null)
				{
					finish();
				}
			}
			else
			{
				finish();
			}
			frames++;
		}
		private function newBulletOnTarget():void
		{
			var newBullet:FlameGroundBullet = new FlameGroundBullet(enemy);
			newBullet.x = enemy.x;
			newBullet.y = enemy.y;
			enemy._root.addChild(newBullet);
		}
		private function finish():void
		{
			common.Commons.removeSkillsList(this)
			removeEventListener(Event.ENTER_FRAME, debuffTick);
			enemy = null;
		}
	}

}