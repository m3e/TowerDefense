package towers
{


	import sounds.SoundManager;
	import flash.events.MouseEvent;

	public class Knight extends Tower
	{


		public function Knight()
		{

			tBaseColor = 0xd8d6d4;
			super();
			tRange = 50;
			tDmg = 90;
			tAtkSpeed = 22;
			tbSpeed = 50;
			tCost = 120;
			tType = "normal";
			tFrame = 6;
			fireSoundString = "swordhit"

			tDescription = "It's a Knight in shining armor.  Gives a debuff that increases enemy's damage taken by 10% for 2 seconds. Tips fedora a lot.";
			// constructor code
		}
		override internal function getSounds():void
		{
			clickedOnSounds = ["knightnofreeman","knightshallicompare"]
		}		
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array  ;

			var debuffType:Array = new Array  ;

			//penitence
			debuffType.push("penitence",.1,2);
			debuffsArray.push(debuffType);
			bullet.debuffArray = debuffsArray;
		}
	}

}