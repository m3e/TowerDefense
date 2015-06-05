package towers {
	
	
	
	
	public class SplashTower extends Tower{


		public function SplashTower() {
			super();
			tBaseColor = 0x000000
			tRange = 133
			tDmg = 15;
			tAtkSpeed = 60;
			tbSpeed = 30;
			tAoe = 50;
			tCost = 100;
			tType = "phys"
			bFrame = 6
			
			// constructor code
		}
		override public function upgradeOne():Class
		{
			return Demolitionist
		}

	}
	
}
