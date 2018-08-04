package towers {
	
	
	
	
	public class Splash extends Tower{


		public function Splash() {
			super();
			tBaseColor = 0x000000
			tRange = 133
			tDmg = 15;
			tAtkSpeed = 60;
			tbSpeed = 10;
			tAoe = 50;
			tCost = 100;
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
