package enemies.skills
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import enemies.Enemy;


	public class EnemySkillManager extends MovieClip
	{


		public function EnemySkillManager()
		{
			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
		}
		public function addSkillToEnemy(e:Enemy,sString:String):void
		{
			//create array
			var sArray:Array = sString.split(',');
			
			//assign vars
			var sN:String = String(sArray[1]);
			var sType:String = String(sArray[0])
			
			//switch skills
			switch (sType)
			{
				case ("hit") :
					var h:Object;
					switch (sN)
					{
						case ("heal") :
						h = new Heal(e,sArray)
						break;
						
						case ("stoneskin") :
						h = new StoneSkin(e,sArray);
						break;
					}
					
				break;

				case ("timer") :
					var t:Object;
					switch (sN)
					{
						case ("heal") :
						t = new Heal(e,sArray)
						break;
					}
					
					
				break;
			}

		}
		public function endClass():void
		{

		}
	}

}