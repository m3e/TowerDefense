package towers.skills
{

	import towers.Tower;

	public class Penitence extends TowerSkill
	{


		public function Penitence(SourceObject:Tower,SA:Array)
		{
			super(SourceObject,SA);
			cooldownSeconds = sA[3];
			sName = "Penitence";
			eMenuNameOne = "Damage taken increase: ";
			eMenuNameTwo = "Seconds: ";
			eMenuStatOne = (sA[2] * 100) + "%";
			eMenuStatTwo = sA[3];
			// constructor code
		}
		override protected function newHitTarget(dEnemy:Object):Array
		{
			var a:Array = [dEnemy,int(cooldownSeconds * 24),sA[2]];
			return a;
		}
		override protected function checkOverride(tsa:Array):void
		{
			if (tsa[0].increasedDmgTaken < sA[2])
			{
				tsa[0].increasedDmgTaken = sA[2];
			}
		}
		override protected function removeEffect(tsa:Array):void
		{
			tsa[0].increasedDmgTaken = 0;
		}
	}

}