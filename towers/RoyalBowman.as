package towers {
	
	
	import sounds.SoundManager;
	
	public class RoyalBowman extends Tower {
		
		
		public function RoyalBowman() {
			super();
			tBaseColor = 0xcd61f4
			tRange = 125
			tDmg = 72;
			tAtkSpeed = 16;
			tbSpeed = 20;
			tCost = 160;
			tType = "pierce"
			bFrame = 5;
			tFrame = 10
			fireSoundString = "arrowShot"
			tDescription = "The Royal Bowman.  Applies -3 armor for 3 seconds on the enemy it hits.  Larger range."
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//brittle
			debuffType.push("brittle",3,3)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
