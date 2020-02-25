﻿package enemies
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import design.HealthBar;
	import flash.utils.Dictionary;
	import common.Commons;

	import assets.maptiles.Tile;
	import enemies.skills.EnemySkill;

	import towers.skills.animations.*;
	import flash.geom.ColorTransform;

	public class Enemy extends MovieClip
	{
		public var eMaxHp:int;
		public var eHp:Number;
		internal var pt:Point = new Point();
		public var maxMoveSpeed:Number;
		public var moveSpeed:Number;
		protected var mapArray:Array;
		//root used on Debuffs to place image
		public var _root:MovieClip;
		public var goldValue:int;
		public var id:int;
		public var maxArmor:int;
		public var armor:int;
		public var distanceTraveled:Number;
		public var killed:Boolean;
		public var eFrame:int;

		public var armorType:String;
		public var eName:String;



		public var poisonSlow:Number;

		protected var healthBar:HealthBar;
		public var removeLife:Boolean;

		public var iceSlow:Number;
		public var poisonDmg:int;
		public var burnDmg:int;
		public var isStunned:Boolean;
		public var increasedDmgTaken:Number;

		protected var light:Object;
		protected var medium:Object;
		protected var heavy:Object;
		protected var fort:Object;
		protected var pure:Object;

		protected var enemySkillOnHit:Array = new Array  ;
		protected var enemySkillOnTimer:Array = new Array  ;

		private var colorTransformed:Boolean;
		public var stunMC:StunMC = new StunMC();
		public var poisonMC:PoisonMC = new PoisonMC();
		public var burnMC:BurnMC = new BurnMC();

		public function Enemy(Map:Array)
		{
			stop();
			mouseEnabled = false;
			mouseChildren = false;
			armorType = "heavy";
			increasedDmgTaken = 0;
			eFrame = 1;
			poisonSlow = 0;
			iceSlow = 0;
			distanceTraveled = 0;
			id = 9999 * Math.random();
			mapArray = Map;
			healthBar = new HealthBar();
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		protected function setupSkillsMC():void
		{
			var skillsArray:Array = [poisonMC,stunMC];
			for (var i:int=0; i < skillsArray.length; i++)
			{
				addChild(skillsArray[i]);
				skillsArray[i].stop;
				skillsArray[i].visible = false;
			}
		}
		protected function added(e:Event):void
		{
			eHp = eMaxHp;
			moveSpeed = maxMoveSpeed;
			armor = maxArmor;
			this.gotoAndStop(eFrame);
			_root = e.currentTarget.parent;
			_root.addChild(healthBar);
			healthBar.visible = false;
			stage.addEventListener(Event.ENTER_FRAME, startMovement,false,10);
			removeEventListener(Event.ADDED_TO_STAGE, added);
			setupSkillsMC();
			setupArmor();
		}
		public function determineMoveSpeed():void
		{
			if (isStunned)
			{
				stunMC.visible = true;
				stunMC.play();
				moveSpeed = 0;
			}
			else
			{
				stunMC.stop();
				stunMC.visible = false;

				var myX:int = (Math.floor(x + 16) / common.Commons.tileSide);
				var myY:int = (Math.floor(y + 16) / common.Commons.tileSide);


				var a:Number = maxMoveSpeed - (maxMoveSpeed * iceSlow);
				var b:Number = a - (a * poisonSlow);
				if (common.Commons.checkB(Math.floor(myX),Math.floor(myY)))
				{
					var iSlow:Number = 0;
					if (common.Commons.tileArray[myY][myX] != null)
					{
						iSlow = b * common.Commons.tileArray[myY][myX].icedSlow;
					}
					var c:Number = b - iSlow;
					moveSpeed = c;
				}
				else
				{
					moveSpeed = b;
				}
			}
			var iceRGB:int = 0;
			var poisonRGB:int = 0;
			var burnRGB:int = 0;
			var ctBool:Boolean = false;
			if (iceSlow > 0)
			{
				iceRGB = 100;
				ctBool = true;
			}
			if (poisonSlow > 0)
			{
				poisonRGB = 80;
				ctBool = true;
			}
			if (burnDmg > 0)
			{
				burnRGB = 100;
				ctBool = true;
			}
			if (ctBool || colorTransformed)
			{
				if (ctBool)
				{
					colorTransformed = true;
				}
				else
				{
					colorTransformed = false;
				}
				var colorT:ColorTransform = new ColorTransform(1,1,1,1,burnRGB,poisonRGB,iceRGB);
				transform.colorTransform = colorT;
			}
		}
		public function addSkill(eSkill:EnemySkill,sType:String):void
		{
			switch (sType)
			{
				case ("hit") :
					enemySkillOnHit.push(eSkill);
					break;

				case ("timer") :
					enemySkillOnTimer.push(eSkill);
					break;
			}

		}
		protected function setupArmor():void
		{
			light = new Object();
			medium = new Object();
			heavy = new Object();
			fort = new Object();
			pure = new Object();

			light["pierce"] = 1.5;
			light["normal"] = 1;
			light["heavy"] = .80
			;
			medium["pierce"] = .8;
			medium["normal"] = 1;
			medium["heavy"] = 1.3
			;
			heavy["pierce"] = .9;
			heavy["normal"] = .85;
			heavy["heavy"] = 1.3
			;
			fort["pierce"] = .70;
			fort["normal"] = .75;
			fort["heavy"] = .9
			;
			pure["pierce"] = 1;
			pure["normal"] = 1;
			pure["heavy"] = 1
			;
		}
		protected function checkMatchup(dmg,dType):Number
		{
			var d:Number;
			if (dType == "ice" || dType == "fire" || dType == "earth")
			{
				d = 1;
			}
			else
			{
				switch (armorType)
				{
					case ("light") :
						d = light[dType];
						break;

					case ("medium") :
						d = medium[dType];
						break;

					case ("heavy") :
						d = heavy[dType];
						break;

					case ("fort") :
						d = fort[dType];
						break;

					case ("pure") :
						d = pure[dType];

				}
			}
			return Number(dmg * d);
		}
		protected function determineArmor(dmg:Number):Number
		{
			var d:Number = dmg;
			d -=  armor;
			return d;
		}
		public function takeDmg(dmg:Number,dType:String):void
		{
			//calculate reduced dmg
			if (eHp > 0)
			{
				dmg = checkMatchup(dmg,dType);

				dmg = dmg * (1 + increasedDmgTaken)
				;
				dmg = determineArmor(dmg);

				if (dmg < 0)
				{
					dmg = 0;
				}
				if (dmg > 0)
				{
					for (var i:int=0; i < enemySkillOnHit.length; i++)
					{
						enemySkillOnHit[i].activateSkill();
					}

					eHp -=  dmg;

				}

			}
			if (eHp <= 0)
			{
				killed = true;
				if (_root != null && _root.contains(this))
				{
					destroyThis();
				}
			}
		}
		public function pausedGame():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, startMovement);
		}
		public function resumedGame():void
		{
			stage.addEventListener(Event.ENTER_FRAME, startMovement,false,10);
		}
		protected function startMovement(e:Event):void
		{
			moveCharacter();
		}
		public function healthBarOnOff():void
		{
			healthBar.visible = !(healthBar.visible);
		}
		public function updateHealth():void
		{
			var percentHP:Number = eHp / eMaxHp;
			if (_root != null && _root.contains(healthBar))
			{
				healthBar.hpBar.scaleX = percentHP;
				healthBar.x = this.x;
				healthBar.y = this.y - 4;
			}
		}
		protected function useTimerSkills():void
		{
			for (var i:int=0; i < enemySkillOnTimer.length; i++)
			{
				enemySkillOnTimer[i].activateSkill();
			}
		}
		protected function moveCharacter():void
		{
			useTimerSkills();
			determineMoveSpeed();
			trace("Moving Enemy");
			switch (mapArray[Math.floor(pt.y)][Math.floor(pt.x)])
			{
				case 1 :

					x +=  moveSpeed;
					if (Math.floor(x/common.Commons.tileSide) != pt.x)
					{
						distanceTraveled -=  x % common.Commons.tileSide;
						x -=  x % common.Commons.tileSide;

						pt.x = x / common.Commons.tileSide;
					}
					break;

				case 2 :

					y +=  moveSpeed;
					if (Math.floor(y/common.Commons.tileSide) != pt.y)
					{
						distanceTraveled -=  y % common.Commons.tileSide;
						y -=  y % common.Commons.tileSide;

						pt.y = y / common.Commons.tileSide;

					}
					break;

				case 3 :

					x -=  moveSpeed;
					if (Math.ceil(x/common.Commons.tileSide) != pt.x)
					{

						pt.x--;
						distanceTraveled -=  Math.abs(pt.x * common.Commons.tileSide - x);
						x +=  Math.abs(pt.x * common.Commons.tileSide - x);

					}
					break;

				case 4 :
					y -=  moveSpeed;

					if (Math.ceil(y/common.Commons.tileSide) != pt.y)
					{

						pt.y--;
						distanceTraveled -=  Math.abs(pt.y * common.Commons.tileSide - y);
						y +=  Math.abs(pt.y * common.Commons.tileSide - y);

					}
					break;

				default :
					removeLife = true;
					destroyThis();
					break;
			}
			applyEffects();
			distanceTraveled +=  moveSpeed;
			updateHealth();
		}
		protected function applyEffects():void
		{
			if (common.Commons.tileArray[pt.y][pt.x] != null && common.Commons.tileArray[pt.y][pt.x].isOnFire == true)
			{
				var thisTile:Tile = common.Commons.tileArray[pt.y][pt.x];
				takeDmg(thisTile.burnAmount/24,"fire");
			}
			if (poisonDmg > 0)
			{
				poisonMC.play();
				poisonMC.visible = true;
				takeDmg(poisonDmg/24,"earth");
			}
			else
			{
				poisonMC.stop();
				poisonMC.visible = false;
			}
			if (burnDmg > 0)
			{
				burnMC.play();
				burnMC.visible = true;
				takeDmg(burnDmg/24,"fire");
			}
			else
			{
				burnMC.stop();
				burnMC.visible = false;
			}
		}
		protected function dpsBuddy():void
		{

		}
		protected function dpsReport():void
		{

		}
		public function destroyThis():void
		{
			dpsReport();
			for (var i:int=0; i < enemySkillOnHit.length; i++)
			{
				enemySkillOnHit[i].endSkill();
			}
			for (var q:int=0; q < enemySkillOnTimer.length; q++)
			{
				enemySkillOnTimer[q].endSkill();
			}
			dpsBuddy();
			mapArray = null;
			stage.removeEventListener(Event.ENTER_FRAME, startMovement);
			_root.removeChild(healthBar);
			healthBar = null;
			_root.removeChild(this);
			_root = null;
			light = null;
			medium = null;
			heavy = null;
			fort = null;
			pure = null;
		}
	}

}