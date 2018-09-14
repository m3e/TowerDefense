package towers
{

	import flash.display.MovieClip;


	public class Chain extends Tower
	{


		public function Chain()
		{
			tName = "Chain";
			super();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array  ;

			var debuffType:Array = new Array  ;

			//chain
			debuffType.push("chain",3,6,.1,75);
			debuffsArray.push(debuffType);
			bullet.debuffArray = debuffsArray;
		}
	}

}