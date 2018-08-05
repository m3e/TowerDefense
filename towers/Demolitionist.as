package towers {
	
	
	
	
	public class Demolitionist extends Tower {
		
		
		public function Demolitionist() {
			tBaseColor = 0x444444
			super();
			tRange = 133
			tDmg = 60;
			tAtkSpeed = 28;
			tbSpeed = 30;
			tAoe = 95;
			tCost = 180;
			tType = "phys"
			bFrame = 6
			tDescription = "Demolitionist.  More damage,  bigger AoE.  What'd you expect?  Cost: "+tCost.toString();
			// constructor code
		}
	}
	
}
