package 
{

	import flash.display.Sprite;
	import towers.Tower;
	import common.Commons;

	public class SellObject extends Sprite
	{

		private var tCost:int;
		private var tower:Tower;
		private var _root:Object;
		public function SellObject()
		{

			_root = common.Commons.getRoot();
			// constructor code
		}
		public function importTowerToSell(_Tower:Tower)
		{
			tower = _Tower;
			tCost = _Tower.tCost;
		}
		public function sellTower():void
		{
			_root.sellTower(tower);
			tower = null;
			tCost = 0;
		}

	}

}