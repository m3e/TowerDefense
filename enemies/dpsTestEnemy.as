package enemies
{

	import enemies.Enemy;
	import flash.events.*;

	public class dpsTestEnemy extends Enemy
	{

		private var frames:int;
		private var dmgArray:Array;
		private var dmgCounter:Number;
		private var dmgTotal:Number;

		private var lDmg:Number;
		private var mDmg:Number;
		private var hDmg:Number;
		private var fDmg:Number;

		//private var startTime:String;
		//private var endTime:String;

		public function dpsTestEnemy(Map)
		{
			lDmg = 0;
			mDmg = 0;
			hDmg = 0;
			fDmg = 0;
			super(Map);
			dmgCounter = 0;
			dmgTotal = 0;
			dmgArray = new Array  ;
			dmgArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			eHp = 45;
			maxMoveSpeed = 3;


			goldValue = 99999;
			maxArmor = 0;
			armor = 0;


			//var date:Date = new Date();
			//startTime=date.toLocaleTimeString();

			// constructor code
		}
		override public function takeDmg(dmg:Number,dType:String):void
		{

			var lightDmg:Number = dmg;
			armorType = "light";
			lightDmg = checkMatchup(lightDmg,dType);
			lightDmg = determineArmor(lightDmg);
			lightDmg *=  (1 + increasedDmgTaken);
			lDmg += lightDmg
			;
			var mediumDmg:Number = dmg;
			armorType = "medium";
			mediumDmg = checkMatchup(mediumDmg,dType);
			mediumDmg = determineArmor(mediumDmg);
			mediumDmg *=  (1 + increasedDmgTaken);
			mDmg += mediumDmg
			;
			var heavyDmg:Number = dmg;
			armorType = "heavy";
			heavyDmg = checkMatchup(heavyDmg,dType);
			heavyDmg = determineArmor(heavyDmg);
			heavyDmg *=  (1 + increasedDmgTaken);
			hDmg += heavyDmg
			;
			var fortDmg:Number = dmg;
			armorType = "fort";
			fortDmg = checkMatchup(fortDmg,dType);
			fortDmg = determineArmor(fortDmg);
			fortDmg *=  (1 + increasedDmgTaken);
			fDmg += fortDmg
			;
			armorType = "pure";
			dmg = checkMatchup(dmg,dType);
			dmg = determineArmor(dmg);
			dmg *=  (1 + increasedDmgTaken);
			addDamage(dmg);

		}

		private function addDamage(dmg:Number):void
		{

			dmgCounter +=  dmg;
			dmgTotal += dmg
			;
		}
		override protected function startMovement(e:Event):void
		{
			frames++;
			findDps();
			if (frames == 25)
			{
				//findDps()
				frames = 1;
			}
			calculateDpsFrame();
			moveCharacter();
		}
		private function findDps():void
		{
			var dps:Number;
			dps = 0;

			for (var i:int=0; i <dmgArray.length; i++)
			{
				dps += dmgArray[i]
				;
			}
			if (dps >= 0)
			{
				dpsNumber.text = int(dps).toString();
			}
			else
			{
				dpsNumber.text = "0";
			}
		}
		private function calculateDpsFrame():void
		{
			dmgArray[frames-1] = dmgCounter
			;
			dmgCounter = 0;
		}
		override protected function dpsBuddy():void
		{
			removeLife = false;
		}
		override protected function dpsReport():void
		{
			//trace("DPS @ 100%: " + dmgTotal);
			/*trace("DPS vs Light: ",lDmg)
			trace("DPS vs Medium: ",mDmg)
			trace("DPS vs Heavy: ",hDmg)
			trace("DPS vs Fort: ",fDmg)*/
		}

	}

}