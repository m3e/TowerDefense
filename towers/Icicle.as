package towers {
	

	import towers.skills.TowerSkillManager
	
	public class Icicle extends Tower {
		
		
		public function Icicle(SkillManager:TowerSkillManager) {
			tName = "Icicle"
			super(SkillManager);
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//slow
			debuffType.push("slow",.18,2)
			debuffsArray.push(debuffType)
			
			debuffType = new Array;
			
			//brittle
			debuffType.push("brittle",1,2)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
