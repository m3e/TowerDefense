﻿



package towers
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import GameProperties;
	import debuffs.*;
	import flash.geom.*;
	import flash.display.*;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import enemies.Enemy;

	import sounds.SoundManager;

	public class Tower extends MovieClip
	{

		public var tDescription:String;
		public var cost:int;

		public var tRange:int;
		public var tDmg:Number;
		public var tbSpeed:int;
		public var tTarget:Array;
		internal var tNumberOfTargets:int;
		public var tAtkSpeed:Number;
		public var tAoe:Number;
		public var tCost:int;
		public var tType:String;

		public var tFrame:int;
		public var buffsArray:Array;
		public var tDmgBuff:Number;

		public var tBaseColor:int;

		public var loaded = Boolean;
		public var loadedTimer:Number;

		//these given in Map, "n addTowerToMap"
		public var enemyList:Array;
		public var towerArray:Array;

		public var targeting:String;
		internal var _root:*;





		internal var bFrame:int;

		internal var rectangle:Shape;

		public function Tower()
		{
			buffsArray = new Array  ;
			rectangle = new Shape  ;
			tDmgBuff = 0;
			tDescription = "No description" + this;
			tTarget = new Array  ;
			targeting = "First";
			loaded = true;
			loadedTimer = 0;
			tbSpeed = 90;
			tAoe = 0;
			bFrame = 1;
			tNumberOfTargets = 1;
			tFrame = 19
			
			
			
			;
			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		public function tMenu():Array
		{
			var e:Array = new Array  ;
			e = [[,,,],
			 ["Targeting",,,],
			 ["Sell",upgradeThree(),upgradeTwo(),upgradeOne()]];

			return e;
		}
		private function added(e:Event):void
		{

			_root = parent;
			gotoAndStop(tFrame);



			addEventListener(Event.ENTER_FRAME, eFrame);
			removeEventListener(Event.ADDED_TO_STAGE, added);
			rectangle.graphics.beginFill(0xFF0000);
			// choosing the colour for the fill, here it is red;
			rectangle.graphics.drawRect(0,0, this.width,this.height);
			// (x spacing, y spacing, width, height);
			rectangle.graphics.endFill();
			// not always needed but I like to put it in to end the fill;
			addChild(rectangle);// adds the rectangle to the stage
			rectangle.visible = false;




		}
		internal function eFrame(e:Event):void
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
						rectangle.visible = false;
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
					targetingCheck();
					for (var i:int=0; i < enemyList.length && (tTarget.length < tNumberOfTargets || targeting == "All"); i++)
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

					}
				}
			}
			else
			{
				trace("This tower has no _root and this shouldn't happen.  X/Y:",this.x,this.y);
			}
		}
		internal function targetingCheck():void
		{
			switch (targeting)
			{
				case ("First") :
					enemyList.sortOn("distanceTraveled", Array.NUMERIC | Array.DESCENDING);
					break;

				case ("Last") :
					enemyList.sortOn("distanceTraveled", Array.NUMERIC);
					break;

				case ("Strong") :
					enemyList.sortOn("eHp", Array.NUMERIC | Array.DESCENDING);
					break;

				case ("Weak") :
					enemyList.sortOn("eHp", Array.NUMERIC);
					break;
				
				case ("All") :
					
					break;

			}
		}
		internal function addDebuffs(bullet:Bullet):void
		{

		}
		internal function specialFunction():void
		{

		}
		internal function fireSound():void
		{

		}
		internal function fire():void
		{
			
				specialFunction();
				fireSound();
				//Create new Bullet
				var newBullet:Bullet;
				for (var i:int=0; i < tTarget.length; i++)
				{
					newBullet = new Bullet(enemyList);
					newBullet.gotoAndStop(bFrame);
					//add debuff;
					addDebuffs(newBullet);
					//Set Bullet location, target, dmg, speed, aoe
					newBullet.x = this.x + (GameProperties.tileSide * .5);
					newBullet.y = this.y + (GameProperties.tileSide * .5);
					newBullet.bTarget = tTarget[i];
					newBullet.bDmg = tDmg * (1 + tDmgBuff);
					newBullet.bSpeed = tbSpeed;
					newBullet.bAoe = tAoe;
					newBullet.bType = tType;
					//End Set bullet stats
					_root.addChild(newBullet);
				}
		}
		public function upgradeOne():Class
		{
			return null;
		}
		public function upgradeTwo():Class
		{
			return null;
		}
		public function upgradeThree():Class
		{
			return null;
		}

		internal function checkB(xCo:int,yCo:int):Boolean
		{
			var inBounds:Boolean;

			//trace("X,Y:"+xCo,yCo,"mapLength/Height:" + towerArray.length, towerArray[0].length)
			if (xCo >= 0 && xCo < towerArray[0].length && yCo >= 0 && yCo < towerArray.length)
			{
				inBounds = true;
			}

			return inBounds;
		}
		internal function dist(firstX:int,firstY:int,secondX:int,secondY:int):int
		{
			var dist:int = Math.abs(firstX - secondX) + Math.abs(firstY - secondY);
			return dist;
		}
		public function destroyTower():void
		{
			removeEventListener(Event.ENTER_FRAME, eFrame);
			removeEventListener(Event.ADDED_TO_STAGE, added);

			while (buffsArray.length > 0)
			{

				buffsArray[0].tTarget = this;
				buffsArray[0].finishBuff();
				buffsArray.splice(0,1);
			}

			tTarget = null;
			enemyList = null;
			towerArray = null;
			buffsArray = []
			;
			if (_root != undefined && _root.contains(this))
			{
				removeChild(rectangle);
				rectangle = null;
				_root.removeChild(this);
			}
			_root = null;
		}
	}
}