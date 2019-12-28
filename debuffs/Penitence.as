package debuffs {
	
	import enemies.Enemy;
	import flash.events.Event;
	import flash.display.Sprite
	
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
			
			addEventListener(Event.ENTER_FRAME, debuffTick);
			// constructor code
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
			
			enemy.increasedDmgTaken = 0
			removeEventListener(Event.ENTER_FRAME, debuffTick)
			enemy = null;
		}
	}
	
}
