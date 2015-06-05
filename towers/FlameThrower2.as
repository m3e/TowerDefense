package towers
{




	public class FlameThrower2 extends Tower
	{


		public function FlameThrower2()
		{
			super();
			tBaseColor = 0x440000;
			tRange = 85;
			tDmg = 3;
			tAtkSpeed = 2;
			tAoe = 0;
			tbSpeed = 8;
			bFrame = 2;
			tCost = 550;
			tType = "fire";
			tNumberOfTargets = 2;
			tDescription = "Doubles the flames coming from this tower and increases damage.  This tower likes fire.  Cost: "+tCost.toString()
			// constructor code
		}
		
	}

}