package  {
	
	import flash.display.Sprite;
	import towers.Tower;
	
	public class SellObject extends Sprite{

		private var tCost:int;
		private var tower:Tower;
		
		public function SellObject() {
			
			// constructor code
		}
		public function importTowerToSell(_Tower:Tower)
		{
			tower = _Tower;
			tCost = _Tower.tCost
		}
		public function sellTower():void
		{
			var _map:Map
			_map = tower.parent as Map;
			_map.sellTower(tower);
			tower = null;
			tCost = 0;
		}

	}
	
}
