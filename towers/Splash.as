package towers {
	
	
	
	
	public class Splash extends Tower{


		public function Splash() {
			tName = "Splash";
			super();
			
			// constructor code
		}
		override public function upgradeOne():Class
		{
			return Demolitionist
		}

	}
	
}
