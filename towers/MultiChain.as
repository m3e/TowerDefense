package towers
{

	import flash.display.MovieClip;


	public class MultiChain extends Tower
	{


		public function MultiChain()
		{
			tName = "MultiChain";
			super();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array  ;

			var debuffType:Array = new Array  ;

			//chain
			debuffType.push("chain",4,6,.1,75);
			debuffsArray.push(debuffType);
			bullet.debuffArray = debuffsArray;
		}
	}

}