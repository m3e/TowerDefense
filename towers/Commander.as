package towers {
	import towers.skills.Skill;
	
	
	
	
	public class Commander extends Tower {
		
		
		public function Commander() {
			tName = "Commander";
			super()
		}
		override internal function generateSkills():void
		{
			skill = new Skill(_root,"dmgBuff","ally","instant",.2,2,4,2,towerArray)
			addChild(skill)
			skillsArray.push(skill);
		}
	}
	
}
