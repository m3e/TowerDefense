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
			tCost = 450;
			tType = "ice"
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//slow
			debuffType.push("slow",.15,.5)
			debuffsArray.push(debuffType)
			
			debuffType = new Array;
			//brittle
			debuffType.push("brittle",2,5)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
