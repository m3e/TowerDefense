package 
{

	import flash.display.MovieClip;
	import debuffs.*;


	public class IceTowerBullet extends Bullet
	{

		public function IceTowerBullet(EnemyList:Array)
		{
			super(EnemyList);
			// constructor code
		}
		override internal function hitAoe():void
		{
			for (var i:int=0; i < enemyList.length; i++)
					{
						if (distanceTwoPoints(bTarget.x,enemyList[i].x,bTarget.y,enemyList[i].y) < bAoe)
						{
							Debuff.addDebuffSlow(enemyList[i],.30,3)
							enemyList[i].eHp -= bDmg;
						}
						
					}
		}
		
	}

}