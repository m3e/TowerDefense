﻿package enemies {
	
	import enemies.Enemy;
	import flash.events.*;
	
	public class dpsTestEnemy extends Enemy {
		
		
		private var frames:int;
		private var dmgArray:Array;
		private var dmgCounter:Number;
		
		public function dpsTestEnemy(Map) {
			super(Map);
			dmgCounter = 0;
			dmgArray = new Array;
			dmgArray = [,,,,,,,,,,,,,,,,,,,,,,,]
			eHp = 45;
			maxMoveSpeed = 4;
			moveSpeed = maxMoveSpeed;
			goldValue = 99999;
			maxArmor=0;
			armor=0;
			// constructor code
		}
		override public function takeDmg(dmg:Number,dType:String):void
		{
			
				dmg -=  (dmg * determineArmor(armor,dType));
				
				addDamage(dmg);
			
		}
		private function addDamage(dmg:Number):void
		{
			
			dmgCounter += dmg
		}
		override internal function startMovement(e:Event):void
		{
			frames++
			if (frames == 25)
			{
				findDps()
				frames = 1
			}
			
			calculateDpsFrame()
			
			moveCharacter();
		}
		private function findDps():void
		{
			var dps:Number=0;
			for (var i:int=0; i <dmgArray.length; i++)
			{
				dps += dmgArray[i]
			}
			if (dps != 0)
			{
			trace(dps);
			}
		}
		private function calculateDpsFrame():void
		{
			dmgArray[frames-1] = dmgCounter
			
			dmgCounter = 0;
		}
	}
	
}