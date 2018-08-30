package buffs {
	
	import flash.display.Sprite;
	import towers.Tower;
	import buffs.*;
	
	public class Buff extends Sprite {
		
		private static var dmgBuff:DmgBuff;
		private static var atkSpdBuff:AtkSpdBuff;
		
		public function Buff() {
			// constructor code
		}
		
		public static function addDmgBuff(_Root:*,ally:Tower, amount:Number, seconds:Number):void
		{
			dmgBuff = new DmgBuff(ally,amount,seconds)
			_Root.addChild(dmgBuff);
		}
		public static function addAtkSpdBuff(_Root:*,ally:Tower, amount:Number, seconds:Number):void
		{
			atkSpdBuff = new AtkSpdBuff(ally,amount,seconds)
			_Root.addChild(atkSpdBuff);
		}
	}
	
}
