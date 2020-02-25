package towers {
	
	
	import flash.events.MouseEvent;
	import towers.skills.TowerSkillManager
	
	public class Shadow extends Tower {
		
		
		public function Shadow(SkillManager:TowerSkillManager) {
			tName = "Shadow";
			super(SkillManager);
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("poison",.2,5,5)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/
	}
	
}
