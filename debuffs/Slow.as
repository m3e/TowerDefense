package debuffs {
	import enemies.Enemy;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.display.MovieClip
	
	
	public class Slow extends Debuff {
		
		private var enemy:Enemy;
		private var amount:Number;
		private var seconds:Number;
		
		private var frames:int;
		
		public function Slow(_enemy:Enemy, _amount:Number,_seconds:Number) {
			enemy = _enemy
			amount = _amount
			seconds = _seconds
			frames = 0;
			addEventListener(Event.ENTER_FRAME, debuffTick)
			// constructor code
		}
		private function debuffTick(e:Event):void
		{
			if (enemy != null && frames < seconds * 24)
			{
				if (enemy.moveSpeed < enemy.maxMoveSpeed - (enemy.maxMoveSpeed * amount))
				{
					
				}
				else
				{
				enemy.moveSpeed = enemy.maxMoveSpeed - (enemy.maxMoveSpeed * amount)
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
			enemy.moveSpeed = enemy.maxMoveSpeed
			removeEventListener(Event.ENTER_FRAME, debuffTick)
			enemy = null;
		}
		
	}
	
}
