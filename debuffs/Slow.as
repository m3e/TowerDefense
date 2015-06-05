package debuffs {
	import enemies.Enemy;
	import flash.events.Event;
	import flash.display.MovieClip
	
	
	public class Slow extends Debuff {
		
		private var enemy:Enemy;
		private var sAmount:Number;
		private var sSeconds:Number;
		
		private var frames:int;
		
		public function Slow(_enemy:Enemy, _amount:Number,_seconds:Number) {
			enemy = _enemy
			sAmount = _amount
			sSeconds = _seconds
			frames = 0;
			addEventListener(Event.ENTER_FRAME, debuffTick)
			// constructor code
		}
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
			enemy.iceSlow = 0;
			enemy.determineMoveSpeed()
			removeEventListener(Event.ENTER_FRAME, debuffTick)
			enemy = null;
		}
		
	}
	
}
