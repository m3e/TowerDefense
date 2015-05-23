package towers
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import fl.motion.Color;

	public class Tower extends MovieClip
	{

		public var tRange:int;
		public var tDmg:Number;
		public var tbSpeed:int;
		public var tTarget:MovieClip;
		public var tAtkSpeed:Number;
		public var tAoe:Number;

		public var tBaseColor:int;

		public var loaded = Boolean;
		public var loadedTimer:Number;

		public var enemyList:Array;
		private var _root:*;

		public function Tower()
		{
			loaded = true;
			loadedTimer = 0;
			tAoe = 0;
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		private function added(e:Event):void
		{
			_root = MovieClip(root);
			removeEventListener(Event.ADDED_TO_STAGE, added);
			var colorMe:ColorTransform = new ColorTransform();
			colorMe.color = tBaseColor;
			this.transform.colorTransform = colorMe;
		}
		private function eFrame(e:Event):void
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
							tTarget = enemyList[i];
						}
						if (tTarget != null)
						{

							fire()



						}
					}
				}
			}
		}
		internal function fire():void
		{
			loaded = false;
							loadedTimer = 0;

							var fireFlash:ColorTransform = new ColorTransform();
							fireFlash.color = 0xFF0000;
							this.transform.colorTransform = fireFlash;

							var newBullet:Bullet = new Bullet(enemyList);
							newBullet.x = this.x;
							newBullet.y = this.y;
							newBullet.bTarget = tTarget;
							newBullet.bDmg = tDmg;
							newBullet.bSpeed = tbSpeed;
							newBullet.bAoe = tAoe;
							rootAddChild(newBullet)
		}
		internal function rootAddChild(newBullet:Bullet)
		{
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