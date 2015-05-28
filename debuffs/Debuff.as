﻿package debuffs {
	
	import flash.display.Sprite;
	import flash.events.*;
	import enemies.Enemy;
	
	
	public class Debuff extends Sprite {
		
		private static var slow:Slow;
		private static var burn:Burn;
		
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
		public static function addBristle(enemy:Enemy, amountNumber, seconds:Number):void
		{
			
		}
	}
	
}
