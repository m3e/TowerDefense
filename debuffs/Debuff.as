package debuffs {
	
	import flash.display.Sprite;
	import flash.events.*;
	import enemies.Enemy;
	
	
	public class Debuff extends Sprite {
		
		private static var slow:Slow;
		private static var burn:Burn;
		private static var brittle:Brittle;
		
		public function Debuff() {
			// constructor code
		}
		public static function addSlow(enemy:Enemy, amount:Number,seconds:Number):void
		{
			slow = new Slow(enemy,amount,seconds)
		}
		public static function addBurn(enemy:Enemy, amount:Number,seconds:Number):void
		{
			burn = new Burn(enemy,amount,seconds)
		}
		public static function addBrittle(enemy:Enemy, amount:Number, seconds:Number):void
		{
			brittle = new Brittle(enemy,amount,seconds)
		}
	}
	
}
