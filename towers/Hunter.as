package towers {
	
	import flash.display.MovieClip;
	import towers.skills.TowerSkillManager
	
	public class Hunter extends Tower {
		
		
		public function Hunter(SkillManager:TowerSkillManager) {
			tName = "Hunter";
			super(SkillManager);
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffType:Array = new Array;
			
			var debuffsArray:Array = new Array;
			
			debuffType.push("poison",.28,20,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
