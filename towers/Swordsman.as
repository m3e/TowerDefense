package towers
{

	public class Swordsman extends Tower
	{

		public function Swordsman()
		{
			tName = "Swordsman"
			super();
			// constructor code
		}
		override public function upgradeOne():Class
		{
			return Samurai
		}
		override public function upgradeTwo():Class
		{
			return MasterSwordsman
		}

	}

}