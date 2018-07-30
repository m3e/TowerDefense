package towers
{

	public class Swordsman extends Tower
	{

		public function Swordsman()
		{
			super();
			tBaseColor = 0xada9a4;
			tRange = 50;
			tDmg = 30;
			tAtkSpeed = 12;
			tAoe = 0;
			tbSpeed = 50;
			tCost = 235;
			tType = "phys";

			tDescription = "The Swordsman.  Attacks twice a second.  Hits hard af.  Cost: " + tCost.toString();
			// constructor code
		}

	}

}