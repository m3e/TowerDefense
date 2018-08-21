package towers {
	
	
	
	
	public class Splash extends Tower{


		public function Splash() {
			super();
			tBaseColor = 0x000000
			tRange = 112
			tDmg = 9;
			tAtkSpeed = 24;
			tbSpeed = 10;
			tAoe = 60;
			tCost = 60;
			tType = "heavy"
			bFrame = 6
			tFrame = 5
			
			tDescription = "Big, explodey, splash guy.  Hits more than one unit if they're close.";
			
			// constructor code
		}
		override public function upgradeOne():Class
		{
			return Demolitionist
		}

	}
	
}
