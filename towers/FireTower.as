package towers
{




	public class FireTower extends Tower
	{
		

		public function FireTower()
		{
			super();
			tBaseColor = 0xFF3300;
			tRange = 90;
			tDmg = 3;
			tAtkSpeed = 2;
			tAoe = 0;
			tbSpeed = 8;
			bFrame = 2;
			tCost = 350;
			tType = "fire";
			tNumberOfTargets = 1;
			
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