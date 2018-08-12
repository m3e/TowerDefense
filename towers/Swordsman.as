package towers
{

	public class Swordsman extends Tower
	{

		public function Swordsman()
		{
			super();
			tBaseColor = 0xada9a4;
			tRange = 50;
			tDmg = 50;
			tAtkSpeed = 16;
			tAoe = 0;
			tbSpeed = 50;
			tCost = 120;
			tType = "phys";
			tFrame = 7

			tDescription = "The Swordsman.  Attacks twice a second.  Hits hard af.  Cost: " + tCost.toString();
			// constructor code
		}

	}

}