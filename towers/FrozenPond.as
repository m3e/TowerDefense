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
			targeting = "All";
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//slow
			debuffType.push("slow",.23,.6)
			debuffsArray.push(debuffType)
			
			debuffType = new Array;
		}
	}
}