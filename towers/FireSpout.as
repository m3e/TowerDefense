package towers
{




	public class FireSpout extends Tower
	{


		public function FireSpout()
		{
			super();
			tBaseColor = 0x440000;
			tRange = 85;
			tDmg = 13;
			tAtkSpeed = 6;
			tAoe = 0;
			tbSpeed = 8;
			bFrame = 2;
			tCost = 120;
			tType = "fire";
			tNumberOfTargets = 2;
			tFrame = 12;
			fireSoundString = "flame";
			tDescription = "Bigger, badder, and hits 2 guys now.  This tower likes fire.";
			// constructor code
		}
		
	}

}