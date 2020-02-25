package towers {
	
	import flash.display.MovieClip;
	import towers.skills.TowerSkillManager
	
	public class IceMaker extends Tower {
		
		
		public function IceMaker(SkillManager:TowerSkillManager) {
			tName = "Ice Maker"
			super(SkillManager)
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.25,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
