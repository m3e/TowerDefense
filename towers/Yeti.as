package towers {
	
	import flash.display.MovieClip;
	import towers.skills.TowerSkillManager
	
	public class Yeti extends Tower {
		
		
		public function Yeti(SkillManager:TowerSkillManager) {
			tName = "Yeti"
			super(SkillManager)
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.28,3)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
