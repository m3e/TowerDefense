﻿package towers {
	
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
			
			tDescription = "Goes *Pew* *Pew* *Pew*.  Enemies think it's too hot.  We think it's justtt right.  Cost: " + tCost.toString();
			// constructor code
		}
	}
	
}