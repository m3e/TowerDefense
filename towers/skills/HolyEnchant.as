package towers.skills
{

	import towers.Tower;

	public class HolyEnchant extends TowerSkill
	{


		public function HolyEnchant(SourceObject:Tower,SA:Array)
		{
			super(SourceObject,SA);
			cooldownSeconds = sA[4]
			sName = "Holy Enchantment";
			eMenuNameOne = "Adjacent attack speed bonus: ";
			eMenuStatOne = int(sA[2] * 100) + "%";
		}
		override protected function newHitTarget(dEnemy:Object):Array
		{
			var a:Array;
			return a;
		}
		override protected function initialEffect(tsa:Array):void
		{
			if (sourceObject != null)
			{
				var hEnchantArray:Array = checkGridFor(sourceObject,sA[3],"Tower");
				for (var he:int=0; he < hEnchantArray.length; he++)
				{
					thisSkillsArray.push([hEnchantArray[he],cooldownSeconds * 24,sA[2]]);
					hEnchantArray[he].tAtkSpdBuff +=  Number(sA[2]);
				}
			}
		}
		override protected function removeEffect(tsa:Array):void
		{
			tsa[0].tAtkSpdBuff -= Number(sA[2]);
		}
	}

}