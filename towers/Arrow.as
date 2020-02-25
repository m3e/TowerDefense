package towers
{

	import sounds.SoundManager;
import towers.skills.TowerSkillManager
	public class Arrow extends Tower
	{


		public function Arrow(SkillManager:TowerSkillManager)
		{
			tName = "Archer";
			super(SkillManager);
			// constructor code
		}
		override internal function getSounds():void
		{
			clickedOnSounds = ["archerhellothere","archerwhatdoyouneed"];
		}

	}
}