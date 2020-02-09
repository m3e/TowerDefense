package debuffs {
	import enemies.Enemy;
	import flash.events.Event;
	import flash.display.Sprite
	import common.Commons;
	
	
	public class Slow extends Sprite {
		
		private var enemy:Enemy;
		private var sAmount:Number;
		private var sSeconds:Number;
		
		private var frames:int;
		
		public function Slow(_enemy:Enemy, _amount:Number,_seconds:Number) {
			enemy = _enemy
			sAmount = _amount
			sSeconds = _seconds
			frames = 0;
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
		/*public function tick():void
		{
			if (enemy != null && frames < sSeconds * 24)
			{
				if (sAmount > enemy.iceSlow)
				{
					enemy.iceSlow = sAmount;
					enemy.determineMoveSpeed()
				}
			}
			else
			{
				finish();
			}
			frames++
		}*/
		private function debuffTick(e:Event):void
		{
			if (enemy != null && frames < sSeconds * 24)
			{
				if (sAmount > enemy.iceSlow)
				{
					enemy.iceSlow = sAmount;
					enemy.determineMoveSpeed()
				}
				else
				{
				
				}
			}
			else
			{
				finish()
			}
			frames++
		}
		private function finish():void
		{
			common.Commons.removeSkillsList(this)
			enemy.iceSlow = 0;
			enemy.determineMoveSpeed()
			removeEventListener(Event.ENTER_FRAME, debuffTick)
			enemy = null;
		}
		
	}
	
}
