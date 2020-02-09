package debuffs {
	
	import flash.events.*;
	import flash.display.Sprite;
	import enemies.*
	import common.Commons;
	
	public class Brittle extends Sprite {
		
		
		private var enemy:Enemy;
		private var amount:Number;
		private var seconds:Number;
		
		private var frames:int;
		
		public function Brittle(_enemy:Enemy, _amount:Number,_seconds:Number) {
			enemy = _enemy
			amount = _amount
			seconds = _seconds
			frames = 0;
			debuffNow()
			common.Commons.addSkillsList(this)
			addEventListener(Event.ENTER_FRAME, debuffTick)
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
		private function debuffNow():void
		{
			if (enemy != null && frames < seconds * 24)
			{
				enemy.armor = enemy.maxArmor - amount;
			}
			else
			{
				finish()
			}
			frames++
		}
		private function debuffTick(e:Event):void
		{
			debuffNow();
		}
		private function finish():void
		{
			common.Commons.removeSkillsList(this)
			enemy.armor = enemy.maxArmor;
			removeEventListener(Event.ENTER_FRAME, debuffTick)
			enemy = null;
		}
	}
	
}
