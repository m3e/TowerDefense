package towers
{

	import flash.events.Event;
	import flash.geom.ColorTransform;
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
		override internal function generateSkills():void
		{
			skill = new Skill(_root,"dmgBuff","ally","instant",.15,2,2,2,towerArray)
			addChild(skill);
			skillsArray.push(skill);
		}
	}
}