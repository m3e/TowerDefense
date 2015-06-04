package towers
{




	public class FlameThrowerTower extends Tower
	{


		public function FlameThrowerTower()
		{
			super();
			tBaseColor = 0xFF3300;
			tRange = 85;
			tDmg = 5;
			tAtkSpeed = 2;
			tAoe = 0;
			tbSpeed = 8;
			bFrame = 2;
			tCost = 350;
			tType = "fire";
			tNumberOfTargets = 5;
			// constructor code
		}
		
	}

}