package towers {
	

	
	
	public class Spike extends Tower {
		
		
		public function Spike() {
			super();
			tBaseColor = 0x3399FF
			tRange = 120
			tDmg = 53;
			tAtkSpeed = 22;
			tbSpeed = 30;
			tAoe = 0;
			bFrame = 4;
			tCost = 80;
			tType = "ice"
			tFrame = 17
			tDescription = "Shoots ice spikes.  Long range, single target.  Slows 15% and reduces armor by 2 for 3 seconds."
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//slow
			debuffType.push("slow",.15,.2)
			debuffsArray.push(debuffType)
			
			debuffType = new Array;
			
			//brittle
			debuffType.push("brittle",2,3)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
