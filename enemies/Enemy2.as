package enemies
{
	import enemies.Enemy;


	public class Enemy2 extends Enemy
	{


		public function Enemy2(Map:Array)
		{
			super(Map);
			eHp = 70;
			maxMoveSpeed = 3;
			moveSpeed = maxMoveSpeed;
			goldValue = 19;
			// constructor code
		}
	}

}