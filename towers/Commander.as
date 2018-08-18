package towers {
	
	
	
	
	public class Commander extends Tower {
		
		
		public function Commander() {
			super()
			tBaseColor = 0xcca892
			tRange = 50
			tDmg = 77;
			tAtkSpeed = 18;
			tbSpeed = 50;
			tCost = 999;
			tType = "normal"
			tFrame = 8
			fireSoundString = "swordhit"
			tDescription = "Likes to shout a lot of motivational things.  Nearby towers strangely reply to it. Cost: " + tCost.toString();
		}
	}
	
}
