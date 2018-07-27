package towers
{

	public class BerserkerTower extends Tower
	{

		public function BerserkerTower()
		{
			super();
			tBaseColor = 0x222222;
			tRange = 50;
			tDmg = 30;
			tAtkSpeed = 12;
			tAoe = 0;
			tbSpeed = 50;
			tCost = 235;
			tType = "phys";

			tDescription = "The Berserker.  Attacks twice a second.  Hits hard af.  Cost: " + tCost.toString();
			// constructor code
		}

	}

}