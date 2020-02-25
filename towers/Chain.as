package towers
{

	import flash.display.MovieClip;
import towers.skills.TowerSkillManager

	public class Chain extends Tower
	{


		public function Chain(SkillManager:TowerSkillManager)
		{
			tName = "Chain";
			super(SkillManager);
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array  ;

			var debuffType:Array = new Array  ;

			//chain
			debuffType.push("chain",3,6,.1,75);
			debuffsArray.push(debuffType);
			bullet.debuffArray = debuffsArray;
		}*/
	}

}