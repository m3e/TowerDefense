package enemies {
	
	import enemies.Enemy;
	import flash.events.*;
	
	public class dpsTestEnemy extends Enemy 
	{
		
		private var frames:int;
		private var dmgArray:Array;
		private var dmgCounter:Number;
		private var dmgTotal:Number;
		
		//private var startTime:String;
		//private var endTime:String;
		
		public function dpsTestEnemy(Map) 
		{
			super(Map);
			dmgCounter = 0;
			dmgTotal = 0;
			dmgArray = new Array;
			dmgArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
			eHp = 45;
			maxMoveSpeed = 3;
			
			
			goldValue = 99999;
			maxArmor=0;
			armor=0;
			
			
			//var date:Date = new Date();
			//startTime=date.toLocaleTimeString();

			// constructor code
		}
		override public function takeDmg(dmg:Number,dType:String):void
		{
			
				dmg -=  (dmg * determineArmor(armor,dType));
				
				addDamage(dmg);
			
		}
		private function addDamage(dmg:Number):void
		{
			
			dmgCounter += dmg
			dmgTotal += dmg
			
		}
		override internal function startMovement(e:Event):void
		{
			frames++
			
			findDps();
			if (frames == 25)
			{
				//findDps()
				frames = 1
			}
			
			
			calculateDpsFrame()
			
			moveCharacter();
		}
		private function findDps():void
		{
			var dps:Number;
			dps = 0;
		
			for (var i:int=0; i <dmgArray.length; i++)
			{
				dps += dmgArray[i]
				
			}
			if (dps >= 0)
			{
			dpsNumber.text = dps.toString();
			}
			else
			{
				dpsNumber.text = "0";
			}
		}
		private function calculateDpsFrame():void
		{
			dmgArray[frames-1] = dmgCounter
			
			dmgCounter = 0;
		}
		override internal function destroyThis():void
		{
			trace("DPS Dummy Dmg: " + dmgTotal);
			
			/*var date:Date = new Date();
			endTime = date.toLocaleTimeString()
			trace("MS/maxMS: ,",moveSpeed,maxMoveSpeed);
			trace("Time start: ",startTime);
			trace("Time ended: ",endTime);*/
			
			mapArray = null;
			removeEventListener(Event.ENTER_FRAME, startMovement);
			_root.removeChild(healthBar);
			healthBar = null;
			_root.removeChild(this);
			_root = null;
		}
	}
	
}
