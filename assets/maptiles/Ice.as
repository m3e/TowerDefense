package assets.maptiles {
	import enemies.Enemy;
	import debuffs.Slow;
	
	public class Ice extends Tile {
		
		public function Ice() {
			gotoAndStop(Math.ceil(Math.random() * 4));
			
			// constructor code
		}
	}
	
}
