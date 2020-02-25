package towers {
	
	import flash.display.MovieClip;
	import towers.skills.TowerSkillManager
	
	public class Blizzard extends Tower {
		
		
		public function Blizzard(SkillManager:TowerSkillManager) {
			tName = "Blizzard"
			super(SkillManager)
			targeting = "All"
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.34,.5)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
