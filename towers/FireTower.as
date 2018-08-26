package towers
{

	import sounds.SoundManager;


	public class FireTower extends Tower
	{
		

		public function FireTower()
		{
			tName = "Fire Tower"
			super();
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