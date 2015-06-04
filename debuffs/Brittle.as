﻿package debuffs {
	
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
			debuffNow()
			addEventListener(Event.ENTER_FRAME, debuffTick)
			// constructor code
		}
		private function debuffNow():void
		{
			if (enemy != null && frames < seconds * 24)
			{
				enemy.armor = enemy.maxArmor - amount;
			}
			else
			{
				finish()
			}
			frames++
		}
		private function debuffTick(e:Event):void
		{
			debuffNow();
		}
		private function finish():void
		{
			enemy.armor = enemy.maxArmor;
			removeEventListener(Event.ENTER_FRAME, debuffTick)
			enemy = null;
		}
	}
	
}