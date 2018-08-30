package towers.skills
{

	import flash.display.MovieClip;
	import buffs.DmgBuff;
	import common.Commons;
	import buffs.Buff;

	public class Skill extends MovieClip
	{

		private var allyOrEnemy:String;
		private var instantOrBullet:String;
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

		public function Skill(_Root:*,_effect:String,_allyOrEnemy:String,_instantOrBullet:String,_amount:Number,_seconds:Number,_atkSpeed:int,_range:int,_towerArray:Array)
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
			instantOrBullet = _instantOrBullet;
			loadedTimer = 0;
			switch (allyOrEnemy)
			{
				case ("ally") :
					targeting = "ally"
					break;

				case ("enemy") :
					//targetEnemy()
					break;
			}
			switch (instantOrBullet)
			{
				case ("instant") :
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
					/*targetingCheck();
				for (var i:int=0; i < enemyList.length && (tTarget.length < myP.tNumberOfTargets || targeting == "All"); i++)
				{
					//Set Target

					if (Math.sqrt(Math.pow(enemyList[i].y - y,2) + Math.pow(enemyList[i].x - x,2)) < tRange)
					{
						//if the selected enemy is close enough, then set it as the target
						tTarget.push(enemyList[i]);
					}
					if (tTarget.length >= tNumberOfTargets && targeting != "All")
					{
						break;
					}
					//End target Set
				}
				if (tTarget.length > 0)
				{
					//Flash and Fire
					loaded = false;
					loadedTimer = 0;

					rectangle.visible = true;

					fire();


					//End Flash and Fire

				}*/
					break;
				}
				if (tTarget.length > 0)
					{
						//Flash and Fire
						loaded = false;
						loadedTimer = 0;

						//var fireFlash:ColorTransform = new ColorTransform();
						//fireFlash.color = 0xFF0000;
						//rectangle.transform.colorTransform = fireFlash;

						fire();


						//End Flash and Fire

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