package towers
{

	import flash.events.Event;
	import towers.skills.TowerSkillManager

	public class FrozenPond extends Tower
	{

		public function FrozenPond(SkillManager:TowerSkillManager)
		{
			tName = "Frozen Pond";
			super(SkillManager);
			
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.28,.5)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
		
	}
}