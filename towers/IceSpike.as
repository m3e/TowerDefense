package towers {
	

	
	
	public class IceSpike extends Tower {
		
		
		public function IceSpike() {
			super();
			tBaseColor = 0x3399FF
			tRange = 120
			tDmg = 15;
			tAtkSpeed = 6;
			tbSpeed = 30;
			tAoe = 0;
			bFrame = 4;
			tCost = 400;
			tType = "ice"
			tDescription = "Shoots ice spikes.  You lose the AoE, but this tower slows by 30% and reduces armor by 5 on enemies.  Large range, good damage.  Cost: "+tCost.toString();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//slow
			debuffType.push("slow",.3,.5)
			debuffsArray.push(debuffType)
			
			debuffType = new Array;
			//brittle
			debuffType.push("brittle",5,5)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
