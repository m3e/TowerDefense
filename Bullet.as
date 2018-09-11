package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.display.Shape;
	import common.Commons;
	import enemies.Enemy;
	import debuffs.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	public class Bullet extends MovieClip
	{

		internal var xSpeed:Number;
		internal var ySpeed:Number;
		internal var enemyList:Array;

		public var bSpeed:Number;
		public var bTarget:*;
		public var bDmg:Number;
		public var bAoe:Number;
		public var bType:String;
		
		private var aoeVisual:Shape;

		public var debuffArray:Array;
		internal var _root:MovieClip;

		public function Bullet(EnemyList:Array)
		{
			stop();
			debuffArray = new Array  ;
			this.mouseEnabled = false;
			enemyList = new Array  ;
			enemyList = EnemyList;
			bTarget = null;
			bDmg = 0;
			bAoe = 0;

			addEventListener(Event.ADDED_TO_STAGE,beginClass);//this will run every time this guy is made
			addEventListener(Event.ENTER_FRAME,eFrame);//this will run every frame

			// constructor code
		}
		internal function addDebuffs(dEnemy:Enemy):void
		{
			for (var i:int=0; i < debuffArray.length; i++)
			{
				switch (debuffArray[i][0])
				{
					case ("penitence") :
						debuffs.Debuff.addPenitence(dEnemy,debuffArray[i][1],debuffArray[i][2])
						break;
					
					case ("slow") :
						debuffs.Debuff.addSlow(dEnemy,debuffArray[i][1],debuffArray[i][2])
						break;
						
					case ("burn") :
						debuffs.Debuff.addBurn(dEnemy,debuffArray[i][1],debuffArray[i][2])
						break;
					
					case ("brittle") :
						debuffs.Debuff.addBrittle(dEnemy,debuffArray[i][1],debuffArray[i][2])
						break;
						
					case ("poison") :
						debuffs.Debuff.addPoison(dEnemy,debuffArray[i][1],debuffArray[i][2],debuffArray[i][3])
						break;
						
					
				}
			}
		}
		private function beginClass(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,beginClass);
			_root = e.currentTarget.parent;

			fire();
		}
		private function eFrame(e:Event):void
		{
			fire();
		}
		internal function distanceTwoPoints(x1:Number, x2:Number,  y1:Number, y2:Number):Number
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			return Math.sqrt(dx * dx + dy * dy);
		}
		private function fire():void
		{
			//Set distance
			var yDist:Number = (bTarget.y + (common.Commons.tileSide * .5)) - this.y;//how far this guy is from the enemy (x)
			var xDist:Number = (bTarget.x + (common.Commons.tileSide * .5)) - this.x;//how far it is from the enemy (y)
			//Angle
			var angle:Number = Math.atan2(yDist,xDist);//the angle that it must move
			//X speed + y Speed
			ySpeed = Math.sin(angle) * bSpeed;//calculate how much it should move the enemy vertically
			xSpeed = Math.cos(angle) * bSpeed;//calculate how much it should move the enemy horizontally
			//Rotation
			this.rotation = (angle / Math.PI) * 180;
			//Math distance if closing in
			if (Math.abs(xSpeed) > Math.abs(xDist))
			{
				xSpeed = xDist;
			}
			if (Math.abs(ySpeed) > Math.abs(yDist))
			{
				ySpeed = yDist;
			}
			
			//End distance Matching
			//move the bullet towards the enemy
			this.x +=  xSpeed;
			this.y +=  ySpeed;

			//Hit Test
			//if (_root.contains(bTarget) && this.hitTestObject(bTarget))
			if (_root.contains(bTarget) && (this.x == (bTarget.x + (common.Commons.tileSide * .5)) && this.y == (bTarget.y + (common.Commons.tileSide * .5))))
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
				destroyThis();
			}
			//else if (!(_root.contains(bTarget)) && this.hitTestObject(bTarget))
			else if (!(_root.contains(bTarget)) && (this.x == (bTarget.x + (common.Commons.tileSide * .5)) && this.y == (bTarget.y + (common.Commons.tileSide * .5))))
			{
				destroyThis();
			}
		}
		internal function hitTarget(dEnemy:Enemy):void
		{
			addDebuffs(dEnemy);
			dEnemy.takeDmg(bDmg,bType);
		}
		internal function hitAoe():void
		{
			
			aoeVisual = new Shape();
			aoeVisual.graphics.beginFill(0x000000,.35);
			aoeVisual.graphics.drawCircle(0,0,bAoe);
			aoeVisual.graphics.endFill();
			aoeVisual.x = (bTarget.x + (common.Commons.tileSide *.5))
			aoeVisual.y = (bTarget.y + (common.Commons.tileSide *.5));   
			_root.addChild(aoeVisual);
			TweenMax.to(aoeVisual, .1, {alpha:0.0, onComplete:removeAoeVisual, onCompleteParams:[parent,aoeVisual]})	;
			var eList:Array = common.Commons.newTheMap(enemyList)
			for (var i:int=0; i < eList.length; i++)
			{
				if (distanceTwoPoints(bTarget.x,eList[i].x,bTarget.y,eList[i].y) <= bAoe)
				{
					hitTarget(eList[i]);
				}
			}
		}
		private function removeAoeVisual(myP:Object,targetShape:Shape):void
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
			debuffArray = null;
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
			enemyList = null;
			bTarget = null;
			_root.removeChild(this);
			_root = null;
		}

	}

}