package towers {
	
	import sounds.SoundManager;
	
	
	public class Arrow extends Tower {
		
		
		public function Arrow() {
			tName = "Archer";
			super();
			// constructor code
		}
		override internal function getSounds():void
		{
			clickedOnSounds = ["archerhellothere","archerwhatdoyouneed"]
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