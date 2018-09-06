package towers
{

	import flash.display.MovieClip;


	public class Hail extends Tower
	{


		public function Hail()
		{
			tName = "Hail";
			super();
			// constructor code
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array  ;

			var debuffType:Array = new Array  ;

			//slow
			debuffType.push("slow",.18,2);
			debuffsArray.push(debuffType);
			debuffType = new Array  ;

			//brittle
			debuffType.push("brittle",1,2);
			debuffsArray.push(debuffType);
			bullet.debuffArray = debuffsArray;
		}
	}

}