package towers.skills
{

	import towers.Tower;

	public class Stun extends TowerSkill
	{

		public function Stun(SourceObject:Tower,SA:Array)
		{
			super(SourceObject,SA);
			sName = "Stun";
			sChance = sA[2];
			cooldownSeconds = sA[3];
			eMenuNameOne = "Chance to stun: ";
			eMenuNameTwo = "Seconds";
			eMenuStatOne = (sA[2] * 100) + "%";
			eMenuStatTwo = sA[3];
		}
		override protected function newHitTarget(dEnemy:Object):Array
		{
			var a:Array = [dEnemy,int(cooldownSeconds*24)];
			return a;
		}
		override protected function chanceVariable(dEnemy:Object):Boolean
		{
			return (dEnemy.isStunned == false);
		}
		override protected function initialEffect(tsa:Array):void
		{
			tsa[0].isStunned = true;
		}
		override protected function removeEffect(tsa:Array):void
		{
			tsa[0].isStunned = false;
		}
	}
}