package towers {
	
	import sounds.SoundManager;
	import flash.events.MouseEvent;
	
	
	public class Warrior extends Tower {
		
		
		public function Warrior() {
			tBaseColor = 0x8c8781
			super()
			
			tRange = 50
			tDmg = 17;
			tAtkSpeed = 24;
			tAoe = 0
			tbSpeed = 50;
			tCost = 30;
			tType = "phys"
			tFrame = 1;
			
			tDescription = "Your basic warrior.  Can be seen in nearly all fantasy tales.  Has a soft side under all that armor.  Cost: " + tCost.toString();
			// constructor code
		}
		override internal function clickedOn(e:MouseEvent):void
		{
			var i:int = (Math.random()*2)
			switch (true)
			{
				case (i == 0):
				SoundManager.sfx("warriorgreetings")
				break;
				
				case (i == 1):
				SoundManager.sfx("warriorhowcanihelp");
				break;
			}
		}
		override public function upgradeOne():Class
		{
			return Swordsman
		}
		override public function upgradeTwo():Class
		{
			return Knight
		}
		override public function upgradeThree():Class
		{
			return Commander
		}
		override internal function fireSound():void
		{
			SoundManager.sfx("swordhit");
		}
	}
	
}
