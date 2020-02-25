package towers.skills
{

	import towers.Tower;
	import common.Commons;

	public class ChainLightning extends TowerSkill
	{

		private var bounces:int;
		private var bSpeed:Number;
		private var pChange:Number;
		private var bRange:int;
		private var bType:String;

		public function ChainLightning(SourceObject:Tower,SA:Array)
		{
			//hit,chain,bounces3,bspeed6,pchange.15,range75,btype
			super(SourceObject,SA);
			bypassDeath = true;
			bounces = sA[2];
			bSpeed = sA[3];
			pChange = sA[4];
			bRange = sA[5];
			bType = sA[6];
			cooldownSeconds = bSpeed;
			sName = "Chain";
			eMenuNameOne = "Number of bounces: ";
			eMenuNameTwo = "Damage reduced per bounce: ";
			eMenuStatOne = sA[2];
			eMenuStatTwo = (sA[4] * 100) + "%";
		}
		override protected function newHitTarget(dEnemy:Object):Array
		{
			if (sourceObject != null)
			{
				tDamage = sourceObject.getDmg();
			}
			var a:Array = [dEnemy,bSpeed,bounces,tDamage];
			return a;
		}
		override protected function removeEffect(tsa:Array):void
		{
			if (tsa[2] > 0)
			{
				var chainList = common.Commons.newTheMap(common.Commons.getEnemyList());
				for (var i:int=0; i < chainList.length; i++)
				{
					if (common.Commons.dist(tsa[0].x,tsa[0].y,chainList[i].x,chainList[i].y) < bRange && chainList[i] != tsa[0])
					{
						chainHit(chainList[i]);
						break;
					}
				}
			}
		}
		private function chainHit(dEnemy:Object):void
		{
			var newDmg:Number = thisSkillsArray[3] * (1 - pChange);
			thisSkillsArray.push([dEnemy,bSpeed,thisSkillsArray[2]-1,newDmg]);
			dEnemy.takeDmg(newDmg,bType);
		}
	}

}