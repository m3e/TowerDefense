package towers {
	
	public class Laser extends Tower {
		
		public function Laser() {
			tBaseColor = 0x00FFFF
			super();
			tRange = 100
			tDmg = 10;
			tAtkSpeed = 12;
			tbSpeed = 20;
			tCost = 10;
			tType = "fire"
			// constructor code
		}
	}
	
}
