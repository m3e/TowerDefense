package towers {
	
	import flash.display.MovieClip;
	import towers.skills.TowerSkillManager
	
	public class HotSpot extends Tower {
		
		
		public function HotSpot(SkillManager:TowerSkillManager) {
			tName = "Hot Spot"
			super(SkillManager);
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("burn",15,3)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
