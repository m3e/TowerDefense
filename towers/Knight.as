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
			tDmg = 38;
			tAtkSpeed = 15;
			tbSpeed = 50;
			tCost = 205;
			tType = "phys";
			tFrame = 6;

			tDescription = "It's a Knight in shining armor.  Gives a debuff that increases enemy's damage taken by 10% for 2 seconds. Cost: " + tCost.toString();
			// constructor code
		}
		override internal function clickedOn(e:MouseEvent):void
		{
			var i:int = (Math.random()*2);
			switch (true)
			{
				case (i == 0) :
					SoundManager.sfx("knightnofreeman");
					break;

				case (i == 1) :
					SoundManager.sfx("knightshallicompare");
					break;
			}
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