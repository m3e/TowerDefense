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
	import flash.events.MouseEvent;

	import sounds.SoundManager;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import towers.skills.Skill;
	import towers.TowerManager;

	public class Tower extends MovieClip
	{

		public var tDescription:String;
		public var cost:int;
		internal var tName:String;
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

		public var loaded = Boolean;
		public var loadedTimer:Number;

		//these given in Map, "n addTowerToMap"
		public var enemyList:Array;
		public var towerArray:Array;

		public var targeting:String;
		public var _root:*;

		private var sound:SoundChannel;
		internal var clickedOnSounds:Array;
		internal var fireSoundString:String;
		private var fireSoundOn:Boolean;
		private var fireSoundChannel:SoundChannel;

		internal var bFrame:int;

		internal var tLevel:int;

		internal var rectangle:Shape;

		public var uCost:int;

		internal var skillsArray:Array;
		internal var skill:Skill;

		public function Tower()
		{
			skillsArray = [];
			clickedOnSounds = new Array  ;
			buffsArray = new Array  ;
			rectangle = new Shape  ;
			tDmgBuff = 0;
			tTarget = new Array  ;
			targeting = "First";
			loaded = true;
			loadedTimer = 0;
			tLevel = 1;
			bFrame = 1;
			uCost = 45;			
			
			for (var i:int=0; i <TowerManager.towerList.length; i++)
			{
				if (TowerManager.towerList[i].tName == tName)
				{
					tName = TowerManager.towerList[i].tName;
					tAoe = TowerManager.towerList[i].tAoe;
					tRange = TowerManager.towerList[i].tRange;
					tNumberOfTargets = TowerManager.towerList[i].tNumberOfTargets;
					tDmg = TowerManager.towerList[i].tDmg;
					tAtkSpeed = TowerManager.towerList[i].tAtkSpeed;
					tCost = TowerManager.towerList[i].tCost;
					tType = TowerManager.towerList[i].tType;
					tbSpeed = TowerManager.towerList[i].tbSpeed;
					bFrame = TowerManager.towerList[i].bFrame;
					tFrame = TowerManager.towerList[i].tFrame;
					fireSoundString = TowerManager.towerList[i].fireSoundString;
					tDescription = TowerManager.towerList[i].tDescription
				}
			}
			
			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		internal function generateSkills():void
		{

		}
		public function upgradeMe():void
		{
			
		}
		public function tMenu():Array
		{
			var e:Array = new Array  ;
			e = [[,,,],
			 ["Targeting",,,"UpgradeMe"],
			 ["Sell",upgradeThree(),upgradeTwo(),upgradeOne()]];

			return e;
		}
		private function added(e:Event):void
		{
			_root = parent;
			gotoAndStop(tFrame);
			getSounds();
			addEventListener(MouseEvent.MOUSE_DOWN, clickedOn);
			addEventListener(Event.ENTER_FRAME, eFrame);
			removeEventListener(Event.ADDED_TO_STAGE, added);
			rectangle.graphics.beginFill(0xFF0000);
			rectangle.graphics.drawRect(0,0, this.width,this.height);
			rectangle.graphics.endFill();
			addChild(rectangle);// adds the rectangle to the stage
			rectangle.visible = false;
			generateSkills();
		}
		internal function getSounds():void
		{
		}
		internal function clickedOn(e:MouseEvent):void
		{
			if (sound == null && clickedOnSounds.length > 0)
			{
				var i:int = (Math.random() * clickedOnSounds.length);
				sound = SoundManager.sfx(clickedOnSounds[i]);
				sound.addEventListener(Event.SOUND_COMPLETE, soundEnd);
			}
		}
		internal function soundEnd(e:Event):void
		{
			sound.removeEventListener(Event.SOUND_COMPLETE, soundEnd);
			sound = null;
		}
		internal function eFrame(e:Event):void
		{
			if (_root != undefined)
			{
				for (var k:int=0; k < skillsArray.length; k++)
				{
					skillsArray[k].activateSkill();
				}
				tTarget.length = 0;
				//Reload
				if (loaded == false)
				{
					loadedTimer +=  1;
					
					//reset red flash from firing
					if (loadedTimer == 1) 
					{
						rectangle.visible = false;
					}
					
					if (loadedTimer == tAtkSpeed) //Reload
					{
						loaded = true;
					}
				}
				//End Reload
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

				case ("Strong") :
					enemyList.sortOn("eHp", Array.NUMERIC | Array.DESCENDING);
					break;

				case ("Last") :
					enemyList.sortOn("distanceTraveled", Array.NUMERIC);
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
		internal function fireSound():void
		{
			if (fireSoundOn == false && fireSoundString != "default")
			{
				fireSoundOn = true;
				fireSoundChannel = SoundManager.sfx(fireSoundString);
				fireSoundChannel.addEventListener(Event.SOUND_COMPLETE,fireSoundEnd);
			}
		}
		private function fireSoundEnd(e:Event):void
		{

			fireSoundOn = false;
			e.currentTarget.removeEventListener(Event.SOUND_COMPLETE,fireSoundEnd);
			fireSoundChannel = null;
		}
		internal function fire():void
		{


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
			removeEventListener(MouseEvent.MOUSE_DOWN, clickedOn);
			while (buffsArray.length > 0)
			{
				buffsArray[0].finishBuff();
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