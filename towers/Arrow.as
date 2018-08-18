package towers {
	
	import sounds.SoundManager;
	
	
	public class Arrow extends Tower {
		
		
		public function Arrow() {
			tBaseColor = 0x96cc8a
			super();
			tRange = 100
			tDmg = 12;
			tAtkSpeed = 18;
			tbSpeed = 20;
			tCost = 40;
			tType = "pierce"
			bFrame = 5;			
			tFrame = 2;
			fireSoundString = "arrowShot"

			tDescription = "The Archer.  Everyone's favorite starting class.  If this tower could crouch and be stealth, it might crit, but it can't.";
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