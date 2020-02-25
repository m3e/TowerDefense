package towers {
	
	import flash.events.MouseEvent;
	import towers.skills.TowerSkillManager
	public class Rogue extends Tower {
		
		public function Rogue(SkillManager:TowerSkillManager) {
			
			tName = "Rogue";
			super(SkillManager);
			// constructor code
		}
		override internal function getSounds():void
		{
			clickedOnSounds = ["roguehey","roguehowareyou"]
		}		
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("poison",.15,3,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}*/

	}
}
