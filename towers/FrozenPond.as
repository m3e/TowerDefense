package towers
{

	import flash.events.Event;
	import buffs.*;
	import towers.skills.Skill;

	public class FrozenPond extends Tower
	{
		
		private var tBuff:DmgBuff;

		public function FrozenPond()
		{
			tName = "Frozen Pond";
			super();
			
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