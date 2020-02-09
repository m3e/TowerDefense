package debuffs {
	
	import enemies.Enemy;
	import flash.events.Event;
	import flash.display.Sprite
	import common.Commons;
	
	public class Penitence extends Sprite {
		
		private var enemy:Enemy;
		private var sAmount:Number;
		private var sSeconds:Number;
		private var frames:int;
		
		public function Penitence(_enemy:Enemy, _amount:Number,_seconds:Number) {
			enemy = _enemy
			sAmount = _amount
			sSeconds = _seconds
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
			if (enemy != null && frames < sSeconds * 24)
			{
				if (sAmount > enemy.increasedDmgTaken)
				{
					enemy.increasedDmgTaken = sAmount;
					
				}
				else
				{
					
				}
			}
			else
			{
				finish();
			}
			frames++;
		}

		private function finish():void
		{
			common.Commons.removeSkillsList(this)
			enemy.increasedDmgTaken = 0
			removeEventListener(Event.ENTER_FRAME, debuffTick)
			enemy = null;
		}
	}
	
}
