package towers
{

	import flash.events.Event;
	import flash.geom.ColorTransform;
	import buffs.*;

	public class FrozenPond extends Tower
	{
		
		private var tBuff:Buff;

		public function FrozenPond()
		{
			super();
			tBaseColor = 0xa0bbe8;
			tRange = 2;
			tDmg = 0;
			tAtkSpeed = 24;
			tAoe = 0;
			tbSpeed = 0;
			bFrame = 3;
			tCost = 250;
			tType = "ice";
			tNumberOfTargets = 1;
			targeting = "first";
			tDescription = "Frozen Pond.  Feel nature's tranquility.  Buffs towers within 2 blocks 15% dmg.  Cost: " + tCost.toString();
			// constructor code
		}

		
		override internal function eFrame(e:Event):void
		{
			if (_root != undefined)
			{
				tTarget.length = 0;
				if (loaded == false)
				{
					//Reload
					loadedTimer +=  1;

					//reset red flash from firing
					if (loadedTimer == 1)
					{
						var returnFromFireFlash:ColorTransform = new ColorTransform();
						returnFromFireFlash.color = tBaseColor;
						rectangle.transform.colorTransform = returnFromFireFlash;
					}
					//Reload
					if (loadedTimer == tAtkSpeed)
					{
						loaded = true;
					}
					//End Reload

				}
				if (loaded == true)
				{
					
					var myX:int
					var myY:int
					for (var i:int = -tRange; i <= tRange; i++)
					{
						
						myY=(this.y/32) + i
						for (var p:int = -tRange; p <= tRange; p++)
						{
							myX = (this.x/32) + p
							if (checkB(myX,myY))
								{
									
									if (towerArray[myY][myX] != null && towerArray[myY][myX] != this)
									{
										if(dist(this.x/32,this.y/32,myX,myY) <= tRange)
										   {
												tTarget.push(towerArray[myY][myX])
												
										   }
										
									}
								}
						}
					}
					if (tTarget.length > 0)
					{
						//Flash and Fire
						loaded = false;
						loadedTimer = 0;

						var fireFlash:ColorTransform = new ColorTransform();
						fireFlash.color = 0xFF0000;
						rectangle.transform.colorTransform = fireFlash;

						fire();


						//End Flash and Fire

					}
				}
			}
		}
		override internal function fire():void
		{
			specialFunction();
			
			for (var i:int=0; i < tTarget.length; i++)
			{
				tBuff = new Buff(tTarget[i],.15,2)
				_root.addChild(tBuff);
			}
		}
	}

}