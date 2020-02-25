package enemies.skills {
	
	import flash.display.MovieClip;
	import enemies.Enemy;
	
	
	public class StoneSkin extends EnemySkill {
		
		
		public function StoneSkin(E:Enemy,SA:Array) {
			sName = "Stoneskin"
			super(E,SA)
			cooldownSeconds = Number(sArray[4])
			// constructor code
		}
		override protected function doSkillEffect():void
		{
			if (sReady == true)
			{
				playGFX()
				e.armor += sArray[2]
				addDuration(sArray[3])
			}
		}
		override public function deactivateSkill():void
		{
			e.armor -= sArray[2]
		}
	}
	
}
