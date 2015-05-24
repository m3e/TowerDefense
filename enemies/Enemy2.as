package enemies
{
	import enemies.Enemy;


	public class Enemy2 extends Enemy
	{


		public function Enemy2(Map:Array)
		{
			super(Map);
			eHp = 180;
			maxMoveSpeed = 2;
			moveSpeed = maxMoveSpeed;
			goldValue = 18;
			// constructor code
		}
	}

}