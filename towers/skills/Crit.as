package towers.skills
{

	import towers.Tower;

	public class Crit extends TowerSkill
	{
		public function Crit(SourceObject:Tower,SA:Array)
		{
			super(SourceObject,SA);
			sChance = sA[2];
			sName = "Crit";
			eMenuNameOne = "Chance to crit: ";
			eMenuNameTwo = "Extra damage %: ";
			eMenuStatOne = (sA[2] * 100) + "%";
			eMenuStatTwo = (sA[3] * 100) + "%";
			// constructor code
		}
		override protected function newHitTarget(dEnemy:Object):Array
		{
			var a:Array = [dEnemy,0]
			return a;
		}
		override protected function initialEffect(tsa:Array):void
		{
			if (sourceObject != null)
			{
				tDamage = sourceObject.getDmg();
			}
			tsa[0].takeDmg(tDamage * Number(sA[3]),tType);
		}
	}

}