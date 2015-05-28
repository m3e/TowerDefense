package debuffs {
	
	import flash.events.*;
	import flash.display.MovieClip;
	import enemies.*
	
	public class Brittle extends Debuff {
		
		
		private var enemy:Enemy;
		private var amount:Number;
		private var seconds:Number;
		
		private var frames:int;
		
		public function Brittle(_enemy:Enemy, _amount:Number,_seconds:Number) {
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
				
			}
			else
			{
				finish()
			}
			frames++
		}
		private function finish():void
		{
			
			removeEventListener(Event.ENTER_FRAME, debuffTick)
			enemy = null;
		}
	}
	
}
