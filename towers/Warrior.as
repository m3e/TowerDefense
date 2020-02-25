package towers
{
	import towers.skills.TowerSkillManager
	import sounds.SoundManager;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.events.Event;


	public class Warrior extends Tower
	{

		
		
		public function Warrior(SkillManager:TowerSkillManager)
		{
			tName = "Warrior";
			super(SkillManager);
			// constructor code
		}
		override public function upgradeMe():void
		{
			switch (tLevel)
			{
				case (1):
				tLevel++
				break;
				
				case (2):
				tLevel++
				break;
				
				case (3):
				tLevel++
				break;
				
				case (4):
				tLevel++
				break;
				
				case (5):
				trace(tLevel++)
				break;
			}
		}
		override internal function getSounds():void
		{
			clickedOnSounds = ["warriorgreetings","warriorhowcanihelp"]
		}		
	}

}