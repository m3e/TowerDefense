package towers {
	
	
	
	
	public class Gun extends Tower{


		public function Gun() {
			super();
			tBaseColor = 0xD6D6D6
			tRange = 100
			tDmg = 8;
			tAtkSpeed = 3;
			tbSpeed = 30;
			tCost = 260;
			tType = "phys"
			
			tDescription = "Guns are sort of unfair against the metal armor the creeps wear.  That's why it shoots pellets.  It still hurts tho.  Cost: " + tCost.toString();
			// constructor code
		}

	}
	
}
