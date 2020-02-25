package towers
{

	import flash.display.MovieClip;
	import towers.skills.TowerSkillManager

	public class MultiChain extends Tower
	{


		public function MultiChain(SkillManager:TowerSkillManager)
		{
			tName = "MultiChain";
			super(SkillManager);
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array  ;

			var debuffType:Array = new Array  ;

			//chain
			debuffType.push("chain",4,6,.1,75);
			debuffsArray.push(debuffType);
			bullet.debuffArray = debuffsArray;
		}*/
	}

}