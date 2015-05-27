package towers
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import GameProperties;
	import debuffs.*;

	import flash.utils.getQualifiedClassName;
	import enemies.Enemy;

	public class Tower extends MovieClip
	{

		public var cost:int;

		public var tRange:int;
		public var tDmg:Number;
		public var tbSpeed:int;
		public var tTarget:Sprite;
		public var tAtkSpeed:Number;
		public var tAoe:Number;

		public var tBaseColor:int;

		public var loaded = Boolean;
		public var loadedTimer:Number;

		//enemyList is given in Map().. don't ask why
		public var enemyList:Array;
		internal var _root:*;

		internal var bFrame:int;

		public function Tower()
		{
			loaded = true;
			loadedTimer = 0;
			tAoe = 0;
			bFrame = 1;
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		private function added(e:Event):void
		{
			_root = MovieClip(root);
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			//change color
			var colorMe:ColorTransform = new ColorTransform();
			colorMe.color = tBaseColor;
			this.transform.colorTransform = colorMe;
		}
		internal function eFrame(e:Event):void
		{
			if (_root != undefined)
			{
				tTarget = null;
				if (loaded == false)
				{
					//Reload
					loadedTimer +=  1;
					if (loadedTimer >= tAtkSpeed * .05)
					{
						var returnFromFireFlash:ColorTransform = new ColorTransform();
						returnFromFireFlash.color = tBaseColor;
						this.transform.colorTransform = returnFromFireFlash;
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
					for (var i:int=0; i < enemyList.length; i++)
					{

						//Set Target
						if (Math.sqrt(Math.pow(enemyList[i].y - y,2) + Math.pow(enemyList[i].x - x,2)) < tRange)
						{
							//if the selected enemy is close enough, then set it as the target
							tTarget = enemyList[i];
						}
						//End target Set
						
						if (tTarget != null)
						{
							//Flash and Fire
							loaded = false;
							loadedTimer = 0;

							var fireFlash:ColorTransform = new ColorTransform();
							fireFlash.color = 0xFF0000;
							this.transform.colorTransform = fireFlash;
							
							fire();
							break;
						}
						//End Flash and Fire

					}
				}
			}
		}
		internal function addDebuffs(bullet:Bullet):void
		{
			
		}
		internal function fire():void
		{
			//Create new Bullet
			var newBullet:Bullet = new Bullet(enemyList);
			newBullet.gotoAndStop(bFrame);
			//add debuff
			addDebuffs(newBullet);
			//Set Bullet location, target, dmg, speed, aoe
			newBullet.x = this.x + (GameProperties.tileSide * .5);
			newBullet.y = this.y + (GameProperties.tileSide * .5);
			newBullet.bTarget = tTarget;
			newBullet.bDmg = tDmg;
			newBullet.bSpeed = tbSpeed;
			newBullet.bAoe = tAoe;
			//End Set bullet stats
			_root.addChild(newBullet);
		}
		public function destroyTower():void
		{
			removeEventListener(Event.ENTER_FRAME, eFrame);
			removeEventListener(Event.ADDED_TO_STAGE, added);
			tTarget = null;
			enemyList = null;
			if (_root != undefined && _root.contains(this))
			{
				_root.removeChild(this);
			}
			_root = null;
		}
	}
}