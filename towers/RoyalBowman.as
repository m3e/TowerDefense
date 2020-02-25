package towers {
	
	
	import sounds.SoundManager;
	import towers.skills.TowerSkillManager
	public class RoyalBowman extends Tower {
		
		
		public function RoyalBowman(SkillManager:TowerSkillManager) {
			tName = "Royal Bowman";
			super(SkillManager);
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//brittle
			debuffType.push("brittle",1,3)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/

	}
	
}
