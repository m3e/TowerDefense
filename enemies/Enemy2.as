package enemies
{
	import enemies.Enemy;


	public class Enemy2 extends Enemy
	{


		public function Enemy2(Map:Array)
		{
			super(Map);
			eHp = 45;
			maxMoveSpeed = 4;
			moveSpeed = maxMoveSpeed;
			goldValue = 2;
			// constructor code
		}
	}

}