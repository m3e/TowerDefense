package enemies
{
	
	import enemies.Enemy;
	public class Enemy2 extends Enemy
	{


		public function Enemy2(Map:Array)
		{
			super(Map);
			eMaxHp = 80;
			maxMoveSpeed = 3;
			goldValue = 8;
			maxArmor = 0;
			// constructor code
		}
	}

}