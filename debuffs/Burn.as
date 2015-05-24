package debuffs {
	
	import enemies.Enemy;
	
	public class Burn extends Debuff {
		
		public function Burn() {
			// constructor code
		}
		public function burnEnemy(enemy:Enemy,bDmg:int):void
		{
			enemy.eHp -= bDmg;
		}
	}
	
}
