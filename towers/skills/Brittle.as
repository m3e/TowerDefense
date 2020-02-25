package towers.skills
{

	import towers.Tower;

	public class Brittle extends TowerSkill
	{

		public function Brittle(SourceObject:Tower,SA:Array)
		{
			super(SourceObject,SA);
			cooldownSeconds = sA[3];
			sName = "Brittle";
			eMenuNameOne = "Armor reduction: ";
			eMenuNameTwo = "Seconds: ";
			eMenuStatOne = sA[2];
			eMenuStatTwo = String(cooldownSeconds);
		}
		override protected function newHitTarget(dEnemy:Object):Array
		{
			var a:Array = [dEnemy,int(cooldownSeconds * 24),sA[2]];
			return a;
		}
		override protected function checkOverride(tsa:Array):void
		{
			var aReduc:int = int(sA[2]);
			if (tsa[0].maxArmor - aReduc < tsa[0].armor)
			{
				tsa[0].armor = tsa[0].maxArmor - int(sA[2]);
			}
		}
		override protected function removeEffect(tsa:Array):void
		{
			tsa[0].armor = tsa[0].maxArmor;
		}
	}

}