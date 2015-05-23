package enemies.enemy1
{

	import enemies.Enemy;


	public class Enemy1 extends Enemy
	{

		public function Enemy1(Map:Array)
		{
			//t1, med hp, med speed
			super(Map);
			eHp = 100;
			moveSpeed = 3;
			goldValue = 10;
		}
	}
}