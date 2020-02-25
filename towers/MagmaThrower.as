package towers {
	
	
	import towers.skills.TowerSkillManager
	
	public class MagmaThrower extends Tower {
		
		
		public function MagmaThrower(SkillManager:TowerSkillManager) {
			tName = "Magma Thrower";
			super(SkillManager);
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("burn",5,3)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/

	}
	
}
