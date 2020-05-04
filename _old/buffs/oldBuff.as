package buffs {
	
	import flash.display.Sprite;
	import towers.Tower;
	import buffs.*;
	import enemies.Enemy;
	
	public class Buff extends Sprite {
		
		//private static var dmgBuff:DmgBuff;
		//private static var atkSpdBuff:AtkSpdBuff;
		//private static var cs:ChainLightning;
		
		public function Buff() {
			// constructor code
		}
		
		public static function addDmgBuff(_Root:*,ally:Tower, amount:Number, seconds:Number):void
		{
			//dmgBuff = new DmgBuff(ally,amount,seconds)
			//_Root.addChild(dmgBuff);
		}
		public static function addAtkSpdBuff(_Root:*,ally:Tower, amount:Number, seconds:Number):void
		{
			//atkSpdBuff = new AtkSpdBuff(ally,amount,seconds)
			//_Root.addChild(atkSpdBuff);
		}
		public static function chainLightning(_Root:*, bDmg:int, bounces:int, bounceSpeed:int, percentChange:Number, bounceRange:int, enemyList:Array, enemy:Enemy,BType:String)
		{
			//Root:*, dmg:int, Bounces:int, bounceSpeed:int, percentChange:Number, dTarget:Enemy, BType:String, EnemyList:Array
			//cs = new ChainLightning(_Root, bDmg, bounces, bounceSpeed, percentChange, bounceRange, enemy,BType)
			//_Root.addChild(cs);
		}
	}
	
}
