package  {
	
	import flash.display.MovieClip;
	import towers.Tower;
	
	
	
	public class UpgradeIcon extends MovieClip {
		
		private var selectedTower:Tower;
		private var uCost;
		
		public function UpgradeIcon() {
			// constructor code
		}
		public function importTower(t:Tower):void
		{
			selectedTower = t;
		}
		public function upgradeTower():void
		{
			if(UserInfo.canAfford(selectedTower.uCost))
			{
				//UserInfo.changeGold(-(selectedTower.uCost))
				selectedTower.upgradeMe();
			}
			else
			{
				trace("You can't afford to upgrade.  Cost:",selectedTower.uCost);
			}
			
		}
	}
	
}
