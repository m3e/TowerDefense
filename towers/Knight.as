package towers
{
	import towers.skills.TowerSkillManager
	import flash.events.MouseEvent;

	public class Knight extends Tower
	{


		public function Knight(SkillManager:TowerSkillManager)
		{
			tName = "Knight";
			super(SkillManager);
			// constructor code
		}
		override internal function getSounds():void
		{
			clickedOnSounds = ["knightnofreeman","knightshallicompare"]
		}		
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array  ;

			var debuffType:Array = new Array  ;

			//penitence
			debuffType.push("penitence",.1,2);
			debuffsArray.push(debuffType);
			bullet.debuffArray = debuffsArray;
		}*/

	}

}