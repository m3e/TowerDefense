package towers {
	

	
	
	public class Spike extends Tower {
		
		
		public function Spike() {
			super();
			tBaseColor = 0x3399FF
			tRange = 133
			tDmg = 80;
			tAtkSpeed = 22;
			tbSpeed = 30;
			tAoe = 0;
			bFrame = 4;
			tCost = 180;
			tType = "ice"
			tFrame = 17
			tDescription = "Shoots ice spikes.  Long range, single target.  Slows 15% and reduces armor by 2. Cost: " + tCost.toString()
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
			debuffType.push("brittle",5,2)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
