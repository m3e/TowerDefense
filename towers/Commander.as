package towers {	
	
	import towers.skills.TowerSkillManager
	
	public class Commander extends Tower {
		
		
		public function Commander(SkillManager:TowerSkillManager) {
			tName = "Commander";
			super(SkillManager)
		}
		/*override internal function generateSkills():void
		{
			skill = new Skill(_root,"dmgBuff","ally","time",.12,2,4,2,towerArray)
			addChild(skill)
			skillsArray.push(skill);
		}*/
	}
	
}
