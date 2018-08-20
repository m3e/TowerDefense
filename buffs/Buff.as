package buffs {
	
	import flash.display.Sprite;
	import towers.Tower;
	import buffs.*;
	
	public class Buff extends Sprite {
		
		private static var dmgBuff:DmgBuff;
		
		
		public function Buff() {
			// constructor code
		}
		
		public static function addDmgBuff(_Root:*,ally:Tower, amount:Number, seconds:Number):void
		{
			dmgBuff = new DmgBuff(ally,amount,seconds)
			_Root.addChild(dmgBuff);
		}
	}
	
}
