package towers
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
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
	import towers.TowerManager;
	import common.Commons;
	import towers.*;
	import towers.Projectiles.Bullet;
	import towers.skills.TowerSkillManager;
	import towers.Projectiles.ProjectileHits.*;
	import towers.skills.animations.DMGBuffMC;
	import towers.skills.animations.SPDBuffMC;

	public class Tower extends MovieClip
	{

		private var hitSound:String;
		public var tDescription:String;
		public var cost:int;
		public var tName:String;
		public var tRange:int;
		public var tDmg:Number;
		public var tbSpeed:int;
		public var tTarget:Array;
		internal var tNumberOfTargets:int;
		public var tAtkSpeed:Number;
		public var tAoe:Number;
		public var tCost:int;
		public var tType:String;

		private var addedToStage:Boolean;

		public var tFrame:int;
		public var buffsArray:Array;
		public var tDmgBuff:Number;
		public var tActualDmg:Number;
		public var tBaseAtkSpdBuff:Number = 0;
		public var tAtkSpdBuff:Number = 0;

		public var loaded = Boolean;
		public var loadedTimer:Number;

		//these given in Map, "n addTowerToMap"
		public var enemyList:Array;
		public var towerArray:Array;

		public var targeting:String;
		public var _root:*;

		protected var sound:SoundChannel;
		protected var fsReload:int;
		private var fireSoundReload:int;
		internal var clickedOnSounds:Array;
		internal var fireSoundString:String;
		private var fireSoundOn:Boolean;

		internal var tUpgradeOne:String;
		internal var tUpgradeTwo:String;
		internal var tUpgradeThree:String;

		internal var bFrame:String;
		protected var bHitFrame:String;

		internal var tLevel:int;

		internal var rectangle:Shape;

		public var uCost:int;

		internal var skillsArray:Array;
		public var hitSkills:Array;
		public var timeSkills:Array;
		public var allSkills:Array = new Array  ;
		protected var dmgBuffMC:DMGBuffMC = new DMGBuffMC();
		protected var spdBuffMC:SPDBuffMC = new SPDBuffMC();
		
		protected var bmpData:BitmapData;
		protected var bmp:Bitmap;
		public var bmpData45:BitmapData;

		protected var towerSkillManager:TowerSkillManager;

		public function Tower(SkillManager:TowerSkillManager)
		{
			towerSkillManager = SkillManager;
			skillsArray = [];
			hitSkills = [];
			timeSkills = [];
			clickedOnSounds = new Array  ;
			buffsArray = new Array  ;
			rectangle = new Shape  ;
			tDmgBuff = 0;
			tActualDmg = 0;
			tAtkSpdBuff = 0;
			//tActualAtkSpd = 0;
			tTarget = new Array  ;
			targeting = "First";
			loaded = true;
			loadedTimer = 0;
			tLevel = 1;
			bFrame = "RedSlash";
			uCost = 45;

			dmgBuffMC.stop();
			addChild(dmgBuffMC)
			dmgBuffMC.visible = false;
			
			spdBuffMC.stop();
			spdBuffMC.x = this.width - spdBuffMC.width
			addChild(spdBuffMC)
			spdBuffMC.visible = false;
			
			for (var i:int=0; i <TowerManager.towerList.length; i++)
			{
				if (TowerManager.towerList[i].tName == tName)
				{
					var td:Object = TowerManager.towerList[i];
					
					tName = td.tName;
					tAoe = td.tAoe;
					tRange = td.tRange;
					tNumberOfTargets = td.tNumberOfTargets;
					tDmg = td.tDmg;
					tAtkSpeed = td.tAtkSpeed;
					tCost = td.tCost;
					tType = td.tType;
					tbSpeed = td.tbSpeed;
					bFrame = td.bFrame;
					bHitFrame = td.bHitFrame;
					tFrame = td.tFrame;
					bmpData = td.bmpData
					bmpData45 = td.bmpData45
					fireSoundString = td.fireSoundString;
					tDescription = td.tDescription;
					tUpgradeOne = td.tUpgradeOne;
					tUpgradeTwo = td.tUpgradeTwo;
					tUpgradeThree = td.tUpgradeThree;
					targeting = td.targeting;
					hitSound = td.hitSound;
					var s1:String = td.tSkillOne;
					var s2:String = td.tSkillTwo;
					var s3:String = td.tSkillThree;
					var s4:String = td.tSkillFour;
					var skillsList:Array = [s1,s2,s3,s4];
					for (var p:int=0; p < skillsList.length; p++)
					{
						if (skillsList[p].length > 0)
						{
							skillsList[p] = skillsList[p].split(",");
							skillsArray.push(skillsList[p]);
						}
					}

					if (targeting != "All")
					{
						targeting = "First";
					}
					break;
				}
			}

			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		internal function generateSkills():void
		{
			for (var i:int=0; i < skillsArray.length; i++)
			{
				towerSkillManager.addSkillToTower(this,skillsArray[i]);
			}
		}
		public function upgradeMe():void
		{

		}
		public function tMenu():Array
		{
			//"UpgradeMe" = upgrades
			var sArray:Array = new Array  ;
			for (var i:int=0; i < allSkills.length; i++)
			{
				sArray.push(allSkills[i]);
			}
			while (sArray.length < 4)
			{
				sArray.push(null);
			}
			var e:Array = new Array  ;
			//e = [[sArray[0],sArray[1],sArray[2],sArray[3]],
			e = [sArray,
			 ["Targeting",,,],
			 ["Sell",upgradeOne(),upgradeTwo(),upgradeThree()]];

			return e;
		}
		private function added(e:Event):void
		{
			addedToStage = true;
			bmp = new Bitmap(bmpData);
			addChild(bmp);
			generateSkills();
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
		public function getAtkSpeed():Number
		{
			//var k = Math.floor(Math.pow(.5,tAtkSpdBuff) * tAtkSpeed)
			var k:Number = Math.pow(.5,(tAtkSpdBuff + tBaseAtkSpdBuff)) * tAtkSpeed;
			//var k:Number = tAtkSpeed - (tAtkSpeed * tAtkSpdBuff);
			return k;
		}
		public function getDmg():Number
		{
			var k:Number = tDmg * (1 + tDmgBuff);
			return k;
		}
		public function pausedGame():void
		{
			removeEventListener(Event.ENTER_FRAME, eFrame);
		}
		public function resumedGame():void
		{
			addEventListener(Event.ENTER_FRAME, eFrame);
		}
		protected function applyEffects():void
		{
			if (tDmgBuff > 0)
			{
				dmgBuffMC.visible = true
				if (tDmgBuff <= .15)
				{
					dmgBuffMC.gotoAndStop(1);
				}
				else if (tDmgBuff > .15 && tDmgBuff <= .25)
				{
					dmgBuffMC.gotoAndStop(2);
				}
				else
				{
					dmgBuffMC.gotoAndStop(3);
				}
			}
			else
			{
				dmgBuffMC.visible = false;
			}
			var newAtkSpd:Number = Math.pow(.5,(tAtkSpdBuff + tBaseAtkSpdBuff))
			if (newAtkSpd < 1)
			{
				spdBuffMC.visible = true
				if (newAtkSpd >= .9)
				{
					spdBuffMC.gotoAndStop(1);
				}
				else if (newAtkSpd >= .8 && newAtkSpd < .9)
				{
					spdBuffMC.gotoAndStop(2);
				}
				else
				{
					spdBuffMC.gotoAndStop(3);
				}
				
			}
			else
			{
				spdBuffMC.visible = false;
			}
		}
		internal function eFrame(e:Event):void
		{
			if (_root != undefined)
			{
				applyEffects();
				if (fireSoundReload > 0)
				{
					fireSoundReload--;
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
					//Reload
					//trace("Tower.tAtkSpeed:",tAtkSpeed - (tAtkSpeed * tAtkSpdBuff))
					if (loadedTimer >= getAtkSpeed())
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
		internal function fireSound():void
		{
			if (fireSoundReload == 0 && fireSoundString != "default")
			{
				fireSoundReload = tAtkSpeed;
				if (fireSoundReload < 4)
				{
					fireSoundReload = 4;
				}
				var fireSoundChannel:SoundChannel = SoundManager.sfx(fireSoundString);
			}
		}
		internal function fire():void
		{
			fireSound();
			//Create new Bullet
			var newBullet:Bullet;
			for (var i:int=0; i < tTarget.length; i++)
			{

				var bShot:String = bFrame;
				var bString:String = "towers.Projectiles." + bShot;
				var ClassReference:Class = getDefinitionByName(bString) as Class;
				newBullet = new ClassReference();

				var bHit:String = bHitFrame;
				if (bHit != "BlankHit")
				{
					var bHitString:String = "towers.Projectiles.ProjectileHits." + bHit;
					var bHitClass:Class = getDefinitionByName(bHitString) as Class;
					newBullet.bHitClass = bHitClass;
				}
				else
				{
					newBullet.bHitClass = null;
				}
				newBullet.hitSound = hitSound;
				newBullet.tSource = this;
				newBullet.hitSkills = common.Commons.newTheMap(hitSkills);
				newBullet.bTarget = tTarget[i];
				newBullet.tX = this.x;
				newBullet.tY = this.y;
				for (var p:int=0; p < hitSkills.length; p++)
				{
					hitSkills[p].addBullet(newBullet);
				}
				if (tbSpeed == tRange)
				{
					newBullet.instant = true;
					newBullet.x = tTarget[i].x + (common.Commons.tileSide * .5);
					newBullet.y = tTarget[i].y + (common.Commons.tileSide * .5);
				}
				else
				{
					newBullet.x = this.x + (common.Commons.tileSide * .5);
					newBullet.y = this.y + (common.Commons.tileSide * .5);
				}

				newBullet.bDmg = getDmg();
				newBullet.bSpeed = tbSpeed;
				newBullet.bAoe = tAoe;
				newBullet.bType = tType;
				_root.addChild(newBullet);
			}
		}
		public function upgradeOne():Class
		{
			var k:Class = null;
			if (tUpgradeOne != null)
			{
				k = (getDefinitionByName("towers."+tUpgradeOne) as Class);
			}
			return k;
		}
		public function upgradeTwo():Class
		{
			var k:Class = null;
			if (tUpgradeTwo != null)
			{
				k = (getDefinitionByName("towers."+tUpgradeTwo) as Class);
			}
			return k;
		}
		public function upgradeThree():Class
		{
			var k:Class = null;
			if (tUpgradeThree != null)
			{
				k = (getDefinitionByName("towers."+tUpgradeThree) as Class);
			}
			return k;
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
		internal function deactivateSkills():void
		{
			while (timeSkills.length > 0)
			{
				timeSkills[0].endClass();
			}
			while (hitSkills.length > 0)
			{
				hitSkills[0].endClass();
			}
		}
		public function destroyTower():void
		{
			removeEventListener(Event.ENTER_FRAME, eFrame);
			removeEventListener(Event.ADDED_TO_STAGE, added);
			removeEventListener(MouseEvent.MOUSE_DOWN, clickedOn);
			removeChild(spdBuffMC)
			removeChild(dmgBuffMC);
			
			if (addedToStage)
			{
				removeChild(bmp);
				deactivateSkills();
			}
			while (buffsArray.length > 0)
			{
				buffsArray[0].finishBuff();
			}
			buffsArray = [];
			towerSkillManager = null;
			tTarget = null;
			enemyList = null;
			towerArray = null;
			buffsArray = [];
			if (_root != undefined && _root.contains(this))
			{
				removeChild(rectangle);
				rectangle = null;
				_root.removeChild(this);
			}
			_root = null;
			skillsArray = [];
			hitSkills = [];
			timeSkills = [];
		}
	}
}