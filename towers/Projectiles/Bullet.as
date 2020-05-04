package towers.Projectiles
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.display.Shape;
	import common.Commons;
	import enemies.Enemy;

	import com.greensock.*;
	import com.greensock.easing.*;
	import towers.Tower;
	import sounds.SoundManager;
	import com.greensock.core.Animation;
	import towers.Projectiles.ProjectileHits.*;

	public class Bullet extends MovieClip
	{

		protected var xSpeed:Number;
		protected var ySpeed:Number;
		protected var enemyList:Array;

		public var bHitClass:Class;

		public var tX:int;
		public var tY:int;
		public var bSpeed:Number;
		public var bTarget:*;
		public var bDmg:Number;
		public var bAoe:Number;
		public var bType:String;
		public var instant:Boolean;
		public var tSource:Tower;
		public var hitSound:String;

		//protected var aoeVisual:Shape;

		public var hitSkills:Array;
		public var debuffArray:Array;
		protected var _root:Object;

		protected var angle:Number;
		protected var yDist:Number;
		protected var xDist:Number;
		protected var rotationB:Number;
		protected var tweenArray:Array = new Array  ;

		protected var TL:Animation;

		public function Bullet()
		{
			hitSkills = new Array  ;
			debuffArray = new Array  ;
			enemyList = new Array  ;
			enemyList = common.Commons.enemyList;
			bTarget = null;
			bDmg = 0;
			bAoe = 0;
			addEventListener(Event.ADDED_TO_STAGE,added);//this will run every time this guy is made
		}
		protected function added(e:Event):void
		{
			common.Commons.addBulletList(this);
			removeEventListener(Event.ADDED_TO_STAGE,added);
			_root = common.Commons.getRoot();
			mouseEnabled = false;
			mouseChildren = false;

			if (instant == false)
			{
				yDist = (bTarget.y + (common.Commons.tileSide * .5)) - this.y;//how far this guy is from the enemy (y)
				xDist = (bTarget.x + (common.Commons.tileSide * .5)) - this.x;//how far it is from the enemy (x)
				angle = Math.atan2(yDist,xDist);//the angle that it must move
				rotationB = (angle / Math.PI) * 180;

				addEventListener(Event.ENTER_FRAME, eFrame);//this will run every frame
				fire();
			}
			else
			{
				targetStrike();
			}
		}
		public function pausedGame():void
		{
			for (var i:int=0; i < tweenArray.length; i++)
			{
				tweenArray[i].pause();
			}
			if (instant == false)
			{
				removeEventListener(Event.ENTER_FRAME, eFrame);
			}
			stop();
		}
		public function resumedGame():void
		{
			for (var i:int=0; i < tweenArray.length; i++)
			{
				tweenArray[i].play();
			}
			if (instant == false)
			{
				addEventListener(Event.ENTER_FRAME, eFrame);
			}
			play();
		}

		protected function eFrame(e:Event):void
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			fire();
		}
		protected function distanceTwoPoints(x1:Number, x2:Number,  y1:Number, y2:Number):Number
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			return Math.sqrt(dx * dx + dy * dy);
		}
		protected function fire():void
		{
			//Set distance
			if (instant == false)
			{
				yDist = (bTarget.y + (common.Commons.tileSide * .5)) - this.y;//how far this guy is from the enemy (y)
				xDist = (bTarget.x + (common.Commons.tileSide * .5)) - this.x;//how far it is from the enemy (x)
				angle = Math.atan2(yDist,xDist);//the angle that it must move
				this.rotation = (angle / Math.PI) * 180;

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
				this.x +=  xSpeed;
				this.y +=  ySpeed;
			}
			if (this.x == (bTarget.x + (common.Commons.tileSide * .5)) && this.y == (bTarget.y + (common.Commons.tileSide * .5)))
			{
				targetStrike();
			}
		}
		protected function targetStrike():void
		{
			SoundManager.sfx(hitSound);
			if (bAoe > 0)
			{
				hitAoe();
			}
			else
			{
				hitTarget(bTarget);
			}
			if (bHitClass != null)
			{
				var pHit:ProjectileHit = new bHitClass(bTarget,angle);
				_root.bmAboveTowers.addChild(pHit);
			}
			destroyThis();
		}
		protected function hitTarget(dEnemy:Enemy):void
		{
			if (common.Commons.enemyAlive(dEnemy))
			{
				addDebuffs(dEnemy);
				dEnemy.takeDmg(bDmg,bType);
			}
		}
		protected function addDebuffs(dEnemy:Enemy):void
		{
			for (var i:int=0; i < hitSkills.length; i++)
			{
				hitSkills[i].hitTarget(dEnemy);
			}
		}
		protected function hitAoe():void
		{
			var eList:Array = common.Commons.newTheMap(enemyList);
			for (var i:int=0; i < eList.length; i++)
			{
				if (distanceTwoPoints(bTarget.x,eList[i].x,bTarget.y,eList[i].y) <= bAoe)
				{
					hitTarget(eList[i]);
				}
			}
		}



		protected function endBlitMask():void
		{

		}
		public function destroyThis():void
		{
			//this function will just remove this guy from the stage
			endBlitMask();
			tweenArray[i] = [];
			for (var i:int=0; i < hitSkills.length; i++)
			{
				hitSkills[i].removeBullet(this);
			}
			hitSkills = [];
			debuffArray = null;
			common.Commons.removeBulletList(this);
			if (instant == false)
			{
				removeEventListener(Event.ENTER_FRAME,eFrame);
			}
			enemyList = null;
			bTarget = null;
			tSource = null;
			_root.bmAboveTowers.removeChild(this);
			_root = null;
		}

	}

}