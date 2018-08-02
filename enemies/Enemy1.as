package enemies
{
	import enemies.Enemy;


	public class Enemy1 extends Enemy
	{

		public function Enemy1(Map:Array)
		{
			
			
			super(Map);
			eHp = 35;
			maxMoveSpeed = 3;
			moveSpeed = maxMoveSpeed;
			goldValue = 2;
			maxArmor=0;
			armor=0;
			
		}
	}
}