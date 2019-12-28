package towers.skills
{

	import flash.display.MovieClip;
	import buffs.DmgBuff;
	import common.Commons;
	import buffs.Buff;

	public class Skill extends MovieClip
	{

		private var allyOrEnemy:String;
		private var eTrigger:String;
		private var loaded:Boolean;
		private var tTarget:Array;
		private var loadedTimer:int;
		private var enemyList:Array;
		private var tAtkSpeed:int;
		private var tRange:int;
		private var targeting:String;
		private var towerArray:Array;
		private var bAmount:Number;
		private var bSeconds:Number;
		private var effect:String;
		private var _root:*;

		public function Skill(_Root:*,_effect:String,_allyOrEnemy:String,_trigger:String,_amount:Number,_seconds:Number,_atkSpeed:int,_range:int,_towerArray:Array)
		{
			_root = _Root;
			effect = _effect;
			bSeconds = _seconds;
			bAmount = _amount;
			towerArray = _towerArray;
			tRange = _range;
			tAtkSpeed = _atkSpeed
			tTarget = [];
			allyOrEnemy = _allyOrEnemy;
			eTrigger = _trigger;
			loadedTimer = 0;
			switch (allyOrEnemy)
			{
				case ("ally") :
					targeting = "ally"
					break;

				case ("enemy") :
					targeting = "enemy"
					break;
			}
			switch (eTrigger)
			{
				case ("time") :
					//instantEffect();
					break;

				case ("bullet") :
					//normalBullet();
					break;
			}
			// constructor code
		}
		public function activateSkill():void
		{
			tTarget.length = 0;
			//Reload
			if (loaded == false)
			{
				loadedTimer +=  1;

				//reset red flash from firing
				if (loadedTimer == 1)
				{
					//rectangle.visible = false;
				}

				//Reload

				if (loadedTimer == tAtkSpeed)
				{
					loaded = true;
				}
			}
			//End Reload
			if (loaded == true)
			{
				switch (targeting)
				{
					case ("ally"):
					var myX:int
					var myY:int
					for (var i:int = -tRange; i <= tRange; i++)
					{
						
						myY=(parent.y/32) + i
						for (var p:int = -tRange; p <= tRange; p++)
						{
							myX = (parent.x/32) + p
							if (common.Commons.checkB(myX,myY))
								{
									
									if (towerArray[myY][myX] != null && towerArray[myY][myX] != parent)
									{
										if(common.Commons.dist(parent.x/common.Commons.tileSide,parent.y/common.Commons.tileSide,myX,myY) <= tRange)
										   {
												tTarget.push(towerArray[myY][myX])
										   }
										
									}
								}
						}
					}
					break;
					
					case ("enemy"):
					break;
				}
				if (tTarget.length > 0)
					{
						loaded = false;
						loadedTimer = 0;
						fire();
					}
				
			}
		}
		private function fire():void
		{
			for (var i:int=0; i < tTarget.length; i++)
			{
				switch (effect)
				{
					case ("dmgBuff"):
					buffs.Buff.addDmgBuff(_root,tTarget[i],bAmount,bSeconds);
					//Buff.addDmgBuff(_root,tTarget[i],.15,2)
					break;
					
					case("atkSpdBuff"):
					buffs.Buff.addAtkSpdBuff(_root,tTarget[i],bAmount,bSeconds);
					break;
				}
			}
		}
		private function targetingCheck():void
		{
			/*switch ("targeting")
			{
				case ("First") :
					enemyList.sortOn("distanceTraveled", Array.NUMERIC | Array.DESCENDING);
					break;

				case ("Strong") :
					enemyList.sortOn("eHp", Array.NUMERIC | Array.DESCENDING);
					break;

				case ("Last") :
					enemyList.sortOn("distanceTraveled", Array.NUMERIC);
					break;

				case ("Weak") :
					enemyList.sortOn("eHp", Array.NUMERIC);
					break;

				case ("All") :

					break;

			}*/
		}
	}
}