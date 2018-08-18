package towers {
	
	
	
	import sounds.SoundManager;
	public class Woodsman extends Tower {
		
		
		public function Woodsman() {
			super();
			tBaseColor = 0x66a843
			tRange = 95
			tDmg = 60;
			tAtkSpeed = 20;
			tbSpeed = 20;
			tCost = 120;
			tType = "earth"
			bFrame = 5;
			tNumberOfTargets = 1
			tFrame = 11
			fireSoundString = "arrowShot"
			tDescription = "The Woodsman.  Shoots Earth arrows, poisons 5 dps + slow 25% for 2 seconds.  Single target.";
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffType:Array = new Array;
			
			var debuffsArray:Array = new Array;
			
			debuffType.push("poison",.25,5,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
