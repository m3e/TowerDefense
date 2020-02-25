package enemies.skills {
	
	import flash.display.MovieClip;
	import enemies.Enemy;
	
	
	public class Heal extends EnemySkill {
		
		
		public function Heal(e:Enemy,sArray:Array) {
			sName = "Heal"
			super(e,sArray)
			cooldownSeconds = Number(sArray[3])
			
			// constructor code
		}
		override protected function doSkillEffect():void
		{
			if (sReady == true && e.eHp < e.eMaxHp)
			{
				
				//trace("hp/max: ",e.eHp,e.eMaxHp, "heal for: ",sArray[2])
				e.eHp += Number(sArray[2])
				
				if (e.eHp > e.eMaxHp)
				{
					//trace("Healing to max: ",e.eHp, e.eMaxHp)
					e.eHp = e.eMaxHp
				}
				if (timerSkill == false)
				{
				playGFX()
				}
			}
		}
	}
	
}
