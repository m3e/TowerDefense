package towers {
	
	import flash.display.MovieClip;
	import towers.skills.Skill;
	
	public class Elven extends Tower {
		
		
		public function Elven() {
			tName = "Elven"
			super()
			// constructor code
		}
		override internal function generateSkills():void
		{
			skill = new Skill(_root,"atkSpdBuff","ally","instant",.10,2,4,2,towerArray)
			addChild(skill)
			skillsArray.push(skill);
		}
	}
	
}
