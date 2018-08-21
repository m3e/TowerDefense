package towers {
	
	import sounds.SoundManager;
	import flash.events.MouseEvent;
	
	
	public class Rogue extends Tower {
		
		
		public function Rogue() {
			super();
			tBaseColor = 0x5f5e77
			tRange = 100
			tDmg = 24;
			tAtkSpeed = 18;
			tbSpeed = 30;
			tNumberOfTargets = 2;
			tCost = 100;
			tType = "pierce"
			tFrame = 9
			fireSoundString = "stab"
			tDescription = "The Rogue.  Hits two targets at once.  Applies 1 dmg every second for 5 seconds per hit and slows by 15%.";
			// constructor code
		}
		override internal function getSounds():void
		{
			clickedOnSounds = ["roguehey","roguehowareyou"]
		}		
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("poison",.15,5,1)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
}
