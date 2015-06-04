package towers
{

	import flash.events.Event;
	import flash.geom.ColorTransform;
	import debuffs.*;

	public class FlameGroundTower extends Tower
	{

		private var burnList:Array;

		public function FlameGroundTower()
		{
			super();
			burnList = new Array();
			tBaseColor = 0x660000;
			tRange = 50;
			tDmg = 3;
			tAtkSpeed = 6;
			tCost = 250;
			tType = "fire"
			
			// constructor code
		}
		override internal function eFrame(e:Event):void
		{
			if (_root != undefined)
			{
				tTarget = null;
				if (loaded == false)
				{
					loadedTimer +=  1;
					if (loadedTimer >= tAtkSpeed * .05)
					{
						var returnFromFireFlash:ColorTransform = new ColorTransform();
						returnFromFireFlash.color = tBaseColor;
						this.transform.colorTransform = returnFromFireFlash;
					}
					if (loadedTimer == tAtkSpeed)
					{
						loaded = true;
					}

				}
				//for (var i:int=enemyList.length - 1; i >=0; i--)
				for (var i:int=0; i < enemyList.length; i++)
				{
					if (loaded == true)
					{
						if (Math.sqrt(Math.pow(enemyList[i].y - y,2) + Math.pow(enemyList[i].x - x,2)) < tRange)
						{
							//if the selected enemy is close enough, then set it as the target
							burnList.push(enemyList[i]);
						}
					}

				}
				if (burnList.length > 0)
				{
					loaded = false;
					loadedTimer = 0;
					var fireFlash:ColorTransform = new ColorTransform();
					fireFlash.color = 0xFF0000;
					this.transform.colorTransform = fireFlash;
					fire();
				}
			}

		}
		override internal function fire():void
		{

			var newBullet:FlameGroundBullet;
			for (var i:int=0; i < burnList.length; i++)
			{
				burnList[i].takeDmg(tDmg,tType);
				newBullet = new FlameGroundBullet(burnList[i]);
				newBullet.x = burnList[i].x;
				newBullet.y = burnList[i].y;
				_root.addChild(newBullet);
			}
			burnList.length = 0
			;
		}

	}

}