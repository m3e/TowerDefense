package towers.skills
{

	import towers.Tower;


	public class Burn extends TowerSkill
	{


		public function Burn(SourceObject:Tower,SA:Array)
		{
			super(SourceObject,SA);
			cooldownSeconds = sA[3];
			sName = "Burn";
			eMenuNameOne = "Damage per Second: ";
			eMenuNameTwo = "Seconds: ";
			eMenuStatOne = sA[2];
			eMenuStatTwo = sA[3];
			// constructor code
		}
		override protected function newHitTarget(dEnemy:Object):Array
		{
			var a:Array = [dEnemy,cooldownSeconds * 24, sA[2]]
			return a;
		}
		override protected function initialEffect(tsa:Array):void
		{
			tsa[0].burnDmg +=  int(sA[2]);
		}

		override protected function removeEffect(tsa:Array):void
		{
			tsa[0].burnDmg -= int(sA[2]);
		}
	}

}