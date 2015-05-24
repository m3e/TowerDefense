package towers
{

	import flash.events.Event;
	import flash.geom.ColorTransform;
	import debuffs.*;

	public class FlameGroundTower extends Tower
	{

		private var burnList:Array;
		private var burn:Burn;
		
		public function FlameGroundTower()
		{
			super();
			burn = new Burn();
			burnList = new Array();
			tBaseColor = 0x660000;
			tRange = 100;
			tDmg = 3;
			tAtkSpeed = 6;
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
							burnList.push(enemyList[i])
						}
					}
					
				}
				if (burnList.length > 0)
						{
							fire();
						}
			}

		}
		override internal function fire():void
		{
			loaded = false;
			loadedTimer = 0;
			var newBullet:FlameGroundBullet
			var fireFlash:ColorTransform = new ColorTransform();
			fireFlash.color = 0xFF0000;
			this.transform.colorTransform = fireFlash;
			for (var i:int=0; i < burnList.length; i++)
			{
				burn.burnEnemy(burnList[i],tDmg)
				newBullet = new FlameGroundBullet(burnList[i]);
				newBullet.x = burnList[i].x;
				newBullet.y = burnList[i].y;
				_root.addChild(newBullet);
			}
			burnList.length = 0
			
		}

	}

}