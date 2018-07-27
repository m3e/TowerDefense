package towers {
	
	
	
	
	public class KnightTower extends Tower {
		
		
		public function KnightTower() {
			super();
			tBaseColor = 0x444444;
			tRange = 50;
			tDmg = 38;
			tAtkSpeed = 15;
			tAoe = 0;
			tbSpeed = 50;
			tCost = 205;
			tType = "phys";

			tDescription = "It's a Knight in shining armor.  Well, it was shiny yesterday, before all the battling.  Cost: " + tCost.toString();
			// constructor code
		}
	}
	
}
