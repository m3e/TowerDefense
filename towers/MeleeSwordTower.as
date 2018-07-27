package towers {
	
	
	
	
	public class MeleeSwordTower extends Tower {
		
		
		public function MeleeSwordTower() {
			super()
			tBaseColor = 0x999999
			tRange = 50
			tDmg = 18;
			tAtkSpeed = 18;
			tAoe = 0
			tbSpeed = 50;
			tCost = 60;
			tType = "phys"
			// constructor code
		}
		
		override public function upgradeOne():Class
		{
			return BerserkerTower
		}
		override public function upgradeTwo():Class
		{
			return KnightTower
		}
	}
	
}
