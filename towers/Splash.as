package towers {
	
	
	
	
	public class Splash extends Tower{


		public function Splash() {
			super();
			tBaseColor = 0x000000
			tRange = 110
			tDmg = 8;
			tAtkSpeed = 16;
			tbSpeed = 10;
			tAoe = 80;
			tCost = 50;
			tType = "phys"
			bFrame = 6
			
			tDescription = "Big, explodey, splash guy.  Hits more than one unit if they're close.  Cost: " + tCost.toString();
			
			// constructor code
		}
		override public function upgradeOne():Class
		{
			return Demolitionist
		}

	}
	
}
