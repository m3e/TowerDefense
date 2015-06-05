package towers {
	
	
	
	
	public class ArrowTower extends Tower {
		
		
		public function ArrowTower() {
			super();
			tBaseColor = 0x66FF99
			tRange = 95
			tDmg = 15;
			tAtkSpeed = 30;
			tbSpeed = 20;
			tCost = 80;
			tType = "phys"
			
			bFrame = 5;

			// constructor code
		}
		override public function upgradeOne():Class
		{
			return RoyalBowmanTower
		}
		override public function upgradeTwo():Class
		{
			return Woodsman
		}
		override public function upgradeThree():Class
		{
			return Assassin
		}
	}
}