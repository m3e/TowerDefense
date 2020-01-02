package towers.skills {
	
	import flash.display.Sprite;
	import enemies.Enemy;
	
	public class Crit extends Sprite {
		
		private var e:Enemy
		private var critChance:Number;
		private var critDmg:Number;
		
		public function Crit(_e:Enemy,chance:Number,critdmg:Number) {
			e = _e
			critChance = chance;
			critDmg = critdmg;
			// constructor code
		}
	}
	
}
