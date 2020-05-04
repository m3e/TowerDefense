package towers.skills
{

	import towers.Tower;
	import common.Commons;

	public class ChainLightning extends TowerSkill
	{

		private var bounces: int;
		private var bSpeed: Number;
		private var pChange: Number;
		private var bRange: int;
		private var bType: String;

		public function ChainLightning(SourceObject: Tower, SA: Array)
		{
			//hit,chain,bounces3,bspeed6,pchange.15,range75,btype
			super(SourceObject, SA);
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
		override protected function newHitTarget(dEnemy: Object): Array
		{
			if (sourceObject != null)
			{
				tDamage = sourceObject.getDmg();
			}
			var a: Array = [dEnemy, bSpeed, bounces, tDamage, []];
			//trace("Enemy, speed, bounces, damage: ", a);
			return a;
		}
		override protected function removeEffect(tsa: Array): void
		{
			//trace("Removing effect: ", tsa)
			if (tsa[2] > 0)
			{
				var chainList = Commons.newTheMap(Commons.getEnemyList());
				for (var i: int = 0; i < chainList.length; i++)
				{
					if (Commons.dist(tsa[0].x, tsa[0].y, chainList[i].x, chainList[i].y) < bRange && chainList[i] != tsa[0])
					{
						//trace("Check for matches: ", i)
						for (var k: int = 0; k < tsa[4].length; k++)
						{

							//trace("Matching: ", chainList[i].id, " to ", tsa[4][k].id)
							var matchFound: Boolean = false;
							if (chainList[i] == tsa[4][k])
							{
								//trace("Match found, breaking: ", i, chainList[i].id)
								matchFound = true;
								break;
							}
						}
						if (!(matchFound))
						{
							var newDmg: Number = tsa[3] * (1 - pChange);
							chainList[i].takeDmg(newDmg, bType);

							tsa[4].push(tsa[0])
							//trace("TSA[4] length: ", tsa[4].length)
							var newArray: Array = [chainList[i], bSpeed, tsa[2] - 1, newDmg, tsa[4]]
							thisSkillsArray.push(newArray);
							//trace("Newly added Array, breaking: ", newArray)
							break;
						}
					}
				}
			}
		}
	}

}