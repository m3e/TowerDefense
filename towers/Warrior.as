package towers {
	
	import sounds.SoundManager;
	
	
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
