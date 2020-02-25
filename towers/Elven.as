package towers {
	
	import flash.display.MovieClip;
	import towers.skills.TowerSkillManager
	public class Elven extends Tower {
		
		
		public function Elven(SkillManager:TowerSkillManager) {
			tName = "Elven"
			super(SkillManager)
			// constructor code
		}
		/*override internal function generateSkills():void
		{
			skill = new Skill(_root,"atkSpdBuff","ally","time",.10,2,4,2,towerArray)
			addChild(skill)
			skillsArray.push(skill);
		}*/
	}
	
}
