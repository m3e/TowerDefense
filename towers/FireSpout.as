package towers
{




	public class FireSpout extends Tower
	{


		public function FireSpout()
		{
			tName = "Fire Spout";
			super();
			// constructor code
		}
		override public function upgradeOne():Class
		{
			return TripleSpout;
		}
		
	}

}