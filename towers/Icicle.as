package towers {
	

	
	
	public class Icicle extends Tower {
		
		
		public function Icicle() {
			tName = "Icicle"
			super();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			//slow
			debuffType.push("slow",.15,2)
			debuffsArray.push(debuffType)
			
			debuffType = new Array;
			
			//brittle
			debuffType.push("brittle",1,2)
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
	}
	
}
