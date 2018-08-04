package towers
{




	public class FireTower extends Tower
	{
		

		public function FireTower()
		{
			super();
			tBaseColor = 0xFF3300;
			tRange = 75;
			tDmg = 5;
			tAtkSpeed = 4;
			tAoe = 0;
			tbSpeed = 8;
			bFrame = 2;
			tCost = 70;
			tType = "fire";
			tNumberOfTargets = 1;
			
			tDescription = "Takes fire and throws it, like some sort of throwing flame machine.  Cost: " + tCost.toString();
			
			// constructor code
		}
		override public function upgradeOne():Class
		{
			return FireSpout
		}
		override public function upgradeTwo():Class
		{
			return ScorchedEarth
		}
		override public function upgradeThree():Class
		{
			return MagmaThrower
		}

	}

}