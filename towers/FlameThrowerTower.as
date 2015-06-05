package towers
{




	public class FlameThrowerTower extends Tower
	{
		

		public function FlameThrowerTower()
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
			return FlameThrower2
		}
		override public function upgradeTwo():Class
		{
			return FlameGroundTower
		}
		override public function upgradeThree():Class
		{
			return MagmaThrower
		}

	}

}