package towers
{

	import flash.display.MovieClip;
import towers.skills.TowerSkillManager

	public class Hail extends Tower
	{


		public function Hail(SkillManager:TowerSkillManager)
		{
			tName = "Hail";
			super(SkillManager);
			// constructor code
		}
		/*override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array  ;

			var debuffType:Array = new Array  ;

			//slow
			debuffType.push("slow",.18,2);
			debuffsArray.push(debuffType);
			debuffType = new Array  ;

			//brittle
			debuffType.push("brittle",1,2);
			debuffsArray.push(debuffType);
			bullet.debuffArray = debuffsArray;
		}*/
	}

}