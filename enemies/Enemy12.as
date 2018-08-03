package enemies
{

	import enemies.Enemy;
	public class Enemy12 extends Enemy
	{


		public function Enemy12(Map:Array)
		{
			super(Map);
			eMaxHp = 1000;
			maxMoveSpeed = 4;
			goldValue = 100;
			maxArmor=0;
			// constructor code
		}
	}

}