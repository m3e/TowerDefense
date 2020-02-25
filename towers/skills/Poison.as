package towers.skills
{

	import towers.Tower;
	import towers.skills.animations.PoisonMC;

	public class Poison extends TowerSkill
	{
		public function Poison(SourceObject:Tower,SA:Array)
		{
			super(SourceObject,SA);
			cooldownSeconds = sA[4];
			sName = "Poison";
			eMenuNameOne = "Damage per Second: ";
			eMenuNameTwo = "Seconds: ";
			eMenuNameThree = "Slow: ";
			eMenuStatOne = sA[3];
			eMenuStatTwo = String(cooldownSeconds);
			eMenuStatThree = (sA[2] * 100) + "%";
			
			// constructor code
		}
		override protected function newHitTarget(dEnemy:Object):Array
		{
			var a:Array = [dEnemy,int(cooldownSeconds * 24),sA[3],sA[2]];
			return a;
		}
		override protected function initialEffect(tsa:Array):void
		{
			tsa[0].poisonDmg +=  int(sA[3]);
		}
		override protected function checkOverride(tsa:Array):void
		{
			if (tsa[0].poisonSlow < sA[2])
			{
				tsa[0].poisonSlow = sA[2];
			}
		}
		override protected function removeEffect(tsa:Array):void
		{
			tsa[0].poisonSlow = 0;
			tsa[0].poisonDmg -=  int(sA[3]);
		}
		override protected function afterRemoval(prc:Array):void
		{

		}
	}
}