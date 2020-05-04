package towers
{
	import towers.skills.TowerSkillManager
	import flash.display.MovieClip;
	import towers.Tower

	public class SnowTosser extends Tower
	{


		public function SnowTosser(SkillManager: TowerSkillManager)
		{
			tName = "Snow Tosser"
			super(SkillManager)
			// constructor code
		}
	}

}