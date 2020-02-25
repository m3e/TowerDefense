package towers {
	
	import flash.display.MovieClip;
	import towers.skills.TowerSkillManager
	
	public class Hero extends Tower {
		
		
		public function Hero(SkillManager:TowerSkillManager) {
			tName = "Hero"
			super(SkillManager);
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//brittle
			debuffType.push("brittle",2,3)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
*/	}
	
}
