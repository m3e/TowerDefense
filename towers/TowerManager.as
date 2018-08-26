package towers {
	
	import flash.display.MovieClip;

	import towerimg.PsuedoTower;
	
	public class TowerManager extends MovieClip {
		
		
		public static var towerList:Array;
		
		public function TowerManager(TowerList:Array) {
			towerList = TowerList;
			// constructor code
		}
	}
}
