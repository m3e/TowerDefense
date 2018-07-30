package towers {
	
	
	
	
	public class Arrow extends Tower {
		
		
		public function Arrow() {
			tBaseColor = 0x96cc8a
			super();
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
			return RoyalBowman
		}
		override public function upgradeTwo():Class
		{
			return Woodsman
		}
		override public function upgradeThree():Class
		{
			return Rogue
		}
	}
}