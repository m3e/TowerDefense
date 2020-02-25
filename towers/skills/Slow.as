package towers.skills
{

	import flash.display.MovieClip;
	import towers.Tower;

	public class Slow extends TowerSkill
	{


		public function Slow(SourceObject:Tower,SA:Array)
		{
			super(SourceObject,SA);
			cooldownSeconds = sA[3];
			sName = "Slow";
			eMenuNameOne = "Slow: ";
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
			if (sA[2] > tsa[0].iceSlow)
			{
				tsa[0].iceSlow = sA[2]
			}
		}
		override protected function removeEffect(tsa:Array):void
		{
			tsa[0].iceSlow = 0;
		}
	}

}