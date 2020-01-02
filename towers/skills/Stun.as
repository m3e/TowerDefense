package towers.skills {
	
	import flash.display.Sprite;
	import enemies.Enemy
	import flash.events.Event;
	
	public class Stun extends Sprite {
		
		private var enemy:Enemy
		private var seconds:int
		private var frames:int = 0
		public function Stun(_e:Enemy,_s:int) {
			enemy = _e;
			seconds = _s;
			// constructor code
			debuffNow()
			addEventListener(Event.ENTER_FRAME, debuffTick)
		}
		private function debuffTick(e:Event):void
		{
			debuffNow();
		}
		private function debuffNow():void
		{
			if (enemy != null && frames < seconds * 24)
			{
				enemy.isStunned = true;
			}
			else
			{
				finish()
			}
			frames++
		}
		private function finish():void
		{
			enemy.isStunned = false;
			removeEventListener(Event.ENTER_FRAME, debuffTick)
			enemy = null;
		}
	}
	
}
