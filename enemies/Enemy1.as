package enemies
{
	import enemies.Enemy;


	public class Enemy1 extends Enemy
	{

		public function Enemy1(Map:Array)
		{
			super(Map);
			eHp = 45;
			maxMoveSpeed = 4;
			moveSpeed = maxMoveSpeed;
			goldValue = 13;
		}
	}
}