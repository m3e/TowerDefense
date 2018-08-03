package enemies
{

	import enemies.Enemy;
	public class Enemy1 extends Enemy
	{


		public function Enemy1(Map:Array)
		{
			super(Map);
			eMaxHp = 50;
			maxMoveSpeed = 2.5;
			goldValue = 7;
			maxArmor = 0;
			// constructor code
		}
	}
}