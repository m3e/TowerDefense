package debuffs {
	
	import flash.display.Sprite;
	import enemies.Enemy;
	
	public class Debuff extends Sprite {
		
		public static var slow:Slow;
		
		public function Debuff() {
			// constructor code
		}
		public static function addDebuffSlow(enemy:Enemy, amount:Number,seconds:Number):void
		{
			slow = new Slow(enemy,amount,seconds)
		}
	}
	
}
