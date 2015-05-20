package enemies.enemy1
{

	import enemies.Enemy;


	public class Enemy1 extends Enemy
	{

		public function Enemy1(Map:Array)
		{
			super(Map);
			eHp = 4;
			moveSpeed = 3;
			goldValue = 8;
		}
	}
}