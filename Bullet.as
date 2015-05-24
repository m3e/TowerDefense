package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.display.Shape;

	public class Bullet extends MovieClip
	{

		internal var xSpeed:Number;
		internal var ySpeed:Number;
		internal var enemyList:Array;

		public var bSpeed:Number;
		public var bTarget:*;
		public var bDmg:Number;
		public var bAoe:Number;

		internal var _root:MovieClip;

		public function Bullet(EnemyList:Array)
		{
			enemyList = new Array  ;
			enemyList = EnemyList;
			bTarget = null;
			bDmg = 0;
			bAoe = 0;

			addEventListener(Event.ADDED_TO_STAGE,beginClass);//this will run every time this guy is made
			addEventListener(Event.ENTER_FRAME,eFrame);//this will run every frame

			// constructor code
		}
		private function beginClass(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,beginClass);
			
			_root = MovieClip(root);

			fire();
		}
		private function eFrame(e:Event):void
		{
			fire();
		}
		private function distanceTwoPoints(x1:Number, x2:Number,  y1:Number, y2:Number):Number
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			return Math.sqrt(dx * dx + dy * dy);
		}
		private function fire():void
		{
			var yDist:Number = bTarget.y - this.y;//how far this guy is from the enemy (x)
			var xDist:Number = bTarget.x - this.x;//how far it is from the enemy (y)
			var angle:Number = Math.atan2(yDist,xDist);//the angle that it must move
			ySpeed = Math.sin(angle) * bSpeed;//calculate how much it should move the enemy vertically
			xSpeed = Math.cos(angle) * bSpeed;//calculate how much it should move the enemy horizontally

			if (Math.abs(xSpeed) > Math.abs(xDist))
			{
				xSpeed = xDist;

			}
			if (Math.abs(ySpeed) > Math.abs(yDist))
			{
				ySpeed = yDist;

			}
			//move the bullet towards the enemy
			this.x +=  xSpeed;
			this.y +=  ySpeed;

			if (this.hitTestObject(bTarget))
			{//if it touches the enemy
				if (bAoe > 0)
				{
					for (var i:int=0; i < enemyList.length; i++)
					{
						if (distanceTwoPoints(bTarget.x,enemyList[i].x,bTarget.y,enemyList[i].y) < bAoe)
						{
							enemyList[i].eHp -= bDmg;
						}
						
					}
				}
				else
				{
					bTarget.eHp -=  bDmg;//make it lose some health

				}
				destroyThis();//and destroy this guy
			}
			else if (bTarget == null)
			{
				destroyThis();
			}
		}
		public function destroyThis():void
		{
			//this function will just remove this guy from the stage
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
			enemyList = null;
			bTarget = null;
			_root.removeChild(this);
			_root = null;

		}

	}

}