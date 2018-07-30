package towers {
	
	
	
	
	public class Knight extends Tower {
		
		
		public function Knight() {
			
			tBaseColor = 0xd8d6d4;
			super();
			tRange = 50;
			tDmg = 38;
			tAtkSpeed = 15;
			tbSpeed = 50;
			tCost = 205;
			tType = "phys";

			tDescription = "It's a Knight in shining armor.  Well, it was shiny yesterday, before all the battling.  Cost: " + tCost.toString();
			// constructor code
		}
	}
	
}
