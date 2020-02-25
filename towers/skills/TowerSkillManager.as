package towers.skills
{

	import flash.display.MovieClip;
	import towers.Tower;
	import towers.skills.*;

	public class TowerSkillManager extends MovieClip
	{


		public function TowerSkillManager()
		{
			// constructor code
		}
		public function addSkillToTower(targetTower:Tower,sA:Array)
		{
			var h:Object;
			switch (sA[0])
			{
				case ("hit") :
					
					switch (sA[1])
					{
						case ("poison") :
							h = new Poison(targetTower,sA);
							break;
						case ("brittle") :
							h = new Brittle(targetTower,sA);
							break;
						case ("penitence") :
							h = new Penitence(targetTower,sA);
							break;
						case ("slow") :
						 	h = new Slow(targetTower,sA);
							break;
						case ("burn") :
							h = new Burn(targetTower,sA);
							break;
						case ("stun"):
							h = new Stun(targetTower,sA);
							break;
						case ("crit"):
							h = new Crit(targetTower,sA);
							break;
						case ("shock"):
							h = new Shock(targetTower,sA);
							break;
						case ("henchant"):
							h = new HolyEnchant(targetTower,sA);
							break;
						case ("chain"):
							h = new ChainLightning(targetTower,sA);
							break;
					}
					break;

				case ("timer") :
					switch (sA[1])
					{
						//case ("dmgBuff") :
						case ("atkSpdBuff") :
							h = new ASBuff(targetTower,sA);
							break;
						case ("dmgBuff") :
							h = new DMGBuff(targetTower,sA);
							break;
						case ("icedRoad") :
						 	h = new IcedRoad(targetTower,sA);
						 	break;
						case ("fireRoad") :
							h = new FireRoad(targetTower,sA);
							break;
					}
					break;
			}
		}
	}
}