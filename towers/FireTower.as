package towers
{

	import sounds.SoundManager;
	import towers.skills.TowerSkillManager

	public class FireTower extends Tower
	{
		

		public function FireTower(SkillManager:TowerSkillManager)
		{
			tName = "Fire Tower"
			super(SkillManager);
			// constructor code
		}
		
	}

}