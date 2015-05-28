package towers {
	

	
	
	public class IceSpike extends Tower {
		
		
		public function IceSpike() {
			super();
			tBaseColor = 0x3399FF
			tRange = 650
			tDmg = 15;
			tAtkSpeed = 6;
			tbSpeed = 30;
			tAoe = 0;
			bFrame = 4;
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.20,.5)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
