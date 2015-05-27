package debuffs {
	
	import enemies.Enemy;
	import flash.events.*;
	
	
	public class Burn extends Debuff {
		
		private var enemy:Enemy;
		private var amount:Number;
		private var seconds:Number;
		private var frequency:int;
		
		private var frames:int;
		
		public function Burn(_enemy:Enemy, _amount:Number,_seconds:Number,_frequency:int) {
			enemy = _enemy
			amount = _amount
			seconds = _seconds
			frequency = _frequency
			frames = 0;
			addEventListener(Event.ENTER_FRAME, debuffTick)
			// constructor code
		}
		
		private function debuffTick(e:Event):void
		{
			//check if debuff ran out
			if (enemy != null && frames < seconds * 24)
			{
				//end check if debuff ran out
				if (frames % 12 == 0 && enemy._root != null)
				{
					enemy.eHp -= amount
					
					
					var newBullet:FlameGroundBullet = new FlameGroundBullet(enemy);
					newBullet.x = enemy.x;
					newBullet.y = enemy.y;
					enemy._root.addChild(newBullet)
				}
				else if (enemy._root == null)
				{
					trace("finish")
					finish()
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
			
			removeEventListener(Event.ENTER_FRAME, debuffTick)
			enemy = null;
		}
	}
	
}
