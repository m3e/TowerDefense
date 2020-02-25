package towers.skills
{

	import towers.Tower;

	public class Shock extends TowerSkill
	{

		public function Shock(SourceObject:Tower,SA:Array)
		{
			super(SourceObject,SA);
			sChance = sA[3];
			cooldownSeconds = sA[4];
			sName = "Shock";
			eMenuNameOne = "Shock chance: ";
			eMenuNameTwo = "Shock Damage: ";
			eMenuNameThree = "Shock length: ";
			eMenuStatOne = int(sA[3] * 100) + "%";
			eMenuStatTwo = sA[2];
			eMenuStatThree = sA[4] + "seconds";
		}
		override protected function newHitTarget(dEnemy:Object):Array
		{
			var a:Array = [dEnemy,cooldownSeconds*24]
			return a;
		}
		override protected function initialEffect(tsa:Array):void
		{
			if (sourceObject != null)
			{
				tDamage = sourceObject.getDmg();
			}
			tsa[0].takeDmg(sA[2],tType)
			var isStunned:Boolean = false;
			if(tsa[0].isStunned == false)
			{
				tsa[0].isStunned = true;
				isStunned = true;
				tsa.push(isStunned)
			}
		}
		override protected function removeEffect(tsa:Array):void
		{
			
			if (tsa[2] == true)
			{
				tsa[0].isStunned = false;
			}
		}
	}

}