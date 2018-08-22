package towers {
	
	
	import debuffs.Debuff
	
	public class IceTower extends Tower {
		
		
		public function IceTower() {
			super()
			tBaseColor = 0x0000FF
			tRange = 80
			tDmg = 7;
			tAtkSpeed = 20;
			tAoe = 35
			tbSpeed = 24;
			bFrame = 3;
			tCost = 50;
			tType = "ice"
			tFrame = 4;
			
			tDescription = "Icey.  Cold.  Refreshing.  Slows by 20% to small area for 2 seconds.";
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.2,2)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
		override public function upgradeOne():Class
		{
			return Spike
		}
		override public function upgradeTwo():Class
		{
			return SnowMachine
		}
		override public function upgradeThree():Class
		{
			return FrozenPond
		}
		
	}
	
}
