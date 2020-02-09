package towers.Projectiles
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.display.Shape;
	import common.Commons;
	import enemies.Enemy;
	import debuffs.*;
	import buffs.*;

	import com.greensock.*;
	import com.greensock.easing.*;
	import towers.Tower;

	public class Bullet extends MovieClip
	{

		protected var xSpeed:Number;
		protected var ySpeed:Number;
		protected var enemyList:Array;

		public var tX:int;
		public var tY:int;
		public var bSpeed:Number;
		public var bTarget:*;
		public var bDmg:Number;
		public var bAoe:Number;
		public var bType:String;
		public var instant:Boolean;
		public var tSource:Tower;

		protected var aoeVisual:Shape;

		public var hitSkills:Array;
		public var debuffArray:Array;
		protected var _root:MovieClip;

		public function Bullet()
		{
			hitSkills = new Array  ;
			debuffArray = new Array  ;
			this.mouseEnabled = false;
			enemyList = new Array  ;
			enemyList = common.Commons.enemyList;
			bTarget = null;
			bDmg = 0;
			bAoe = 0;
			addEventListener(Event.ADDED_TO_STAGE,added);//this will run every time this guy is made
			// constructor code
		}
		protected function added(e:Event):void
		{
			common.Commons.addBulletList(this);
			removeEventListener(Event.ADDED_TO_STAGE,added);
			if (instant == false)
			{
				addEventListener(Event.ENTER_FRAME, eFrame);//this will run every frame
			}
			else
			{
				targetStrike();
				var yDist:Number = (bTarget.y + (common.Commons.tileSide * .5)) - tY;
				var xDist:Number = (bTarget.x + (common.Commons.tileSide * .5)) - tX;
				var angle:Number = Math.atan2(yDist,xDist);//the angle that it must move
				this.rotation = (angle / Math.PI) * 180;
				addEventListener(Event.ENTER_FRAME, instantFrame);
			}
			_root = e.currentTarget.parent;

			fire();
		}
		public function pausedGame():void
		{
			if (instant == false)
			{
				removeEventListener(Event.ENTER_FRAME, eFrame);
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, instantFrame);
			}
			stop();
		}
		public function resumedGame():void
		{
			if (instant == false)
			{
				addEventListener(Event.ENTER_FRAME, eFrame);
			}
			else
			{
				addEventListener(Event.ENTER_FRAME, instantFrame);
			}
			play();
		}
		protected function addDebuffs(dEnemy:Enemy):void
		{
			for (var i:int=0; i < hitSkills.length; i++)
			{
				hitSkills[i].activateSkill(dEnemy);
			}
		}
		protected function eFrame(e:Event):void
		{
			fire();
		}
		protected function instantFrame(e:Event):void
		{
			x = bTarget.x + (common.Commons.tileSide * .5);
			y = bTarget.y + (common.Commons.tileSide * .5);
			var yDist:Number = (bTarget.y + (common.Commons.tileSide * .5)) - tY;
			var xDist:Number = (bTarget.x + (common.Commons.tileSide * .5)) - tX;
			var angle:Number = Math.atan2(yDist,xDist);//the angle that it must move
			this.rotation = (angle / Math.PI) * 180;
			if (!(_root.contains(bTarget)) || currentFrame == totalFrames)
			{
				destroyThis();
			}
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
				var yDist:Number = (bTarget.y + (common.Commons.tileSide * .5)) - this.y;//how far this guy is from the enemy (y)
				var xDist:Number = (bTarget.x + (common.Commons.tileSide * .5)) - this.x;//how far it is from the enemy (x)
				var angle:Number = Math.atan2(yDist,xDist);//the angle that it must move
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
			//Hit Test
			if (_root.contains(bTarget) && (this.x == (bTarget.x + (common.Commons.tileSide * .5)) && this.y == (bTarget.y + (common.Commons.tileSide * .5))))
			{
				targetStrike();
			}
			else if (!(_root.contains(bTarget)) && (this.x == (bTarget.x + (common.Commons.tileSide * .5)) && this.y == (bTarget.y + (common.Commons.tileSide * .5))))
			{
				destroyThis();
			}
		}
		protected function targetStrike():void
		{
			if (bAoe > 0)
			{
				//If AOE
				hitAoe();
				//End AOE
			}
			else
			{
				//If Single Target
				hitTarget(bTarget);
				//End Single Target
			}
			//Destroy
			if (instant == false)
			{
				destroyThis();
			}
		}
		protected function hitTarget(dEnemy:Enemy):void
		{
			addDebuffs(dEnemy);
			dEnemy.takeDmg(bDmg,bType);
		}
		protected function hitAoe():void
		{

			/*aoeVisual = new Shape();
			aoeVisual.graphics.beginFill(0x000000,.35);
			aoeVisual.graphics.drawCircle(0,0,bAoe);
			aoeVisual.graphics.endFill();
			aoeVisual.x = (bTarget.x + (common.Commons.tileSide *.5))
			aoeVisual.y = (bTarget.y + (common.Commons.tileSide *.5));   
			_root.addChild(aoeVisual);
			TweenMax.to(aoeVisual, .1, {alpha:0.0, onComplete:removeAoeVisual, onCompleteParams:[parent,aoeVisual]});*/
			var eList:Array = common.Commons.newTheMap(enemyList);
			for (var i:int=0; i < eList.length; i++)
			{
				if (distanceTwoPoints(bTarget.x,eList[i].x,bTarget.y,eList[i].y) <= bAoe)
				{
					hitTarget(eList[i]);
				}
			}
		}
		protected function removeAoeVisual(myP:Object,targetShape:Shape):void
		{
			if (myP.contains(targetShape))
			{
				myP.removeChild(targetShape);
				aoeVisual = null;
			}
		}
		public function destroyThis():void
		{
			//this function will just remove this guy from the stage
			for (var i:int=0; i < hitSkills.length; i++)
			{
				hitSkills[i].removeBullet(this);
			}
			hitSkills = [];
			debuffArray = null;
			common.Commons.removeBulletList(this);
			if (instant == false)
			{
				this.removeEventListener(Event.ENTER_FRAME,eFrame);
			}
			else
			{
				this.removeEventListener(Event.ENTER_FRAME, instantFrame);
			}
			enemyList = null;
			bTarget = null;
			tSource = null;
			_root.removeChild(this);
			_root = null;
		}

	}

}