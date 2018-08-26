package towers
{

	import sounds.SoundManager;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import towers.skills.Skill;

	public class Warrior extends Tower
	{

		
		
		public function Warrior()
		{
			tName = "Warrior";
			super();
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
		override public function upgradeOne():Class
		{
			return Swordsman;
		}
		override public function upgradeTwo():Class
		{
			return Knight;
		}
		override public function upgradeThree():Class
		{
			return Commander;
		}
	}

}