package towers
{




	public class FireSpout extends Tower
	{


		public function FireSpout()
		{
			super();
			tBaseColor = 0x440000;
			tRange = 85;
			tDmg = 10;
			tAtkSpeed = 4;
			tAoe = 0;
			tbSpeed = 8;
			bFrame = 2;
			tCost = 180;
			tType = "fire";
			tNumberOfTargets = 2;
			tFrame = 12;
			tDescription = "Doubles the flames coming from this tower and increases damage.  This tower likes fire.  Cost: "+tCost.toString()
			// constructor code
		}
		
	}

}