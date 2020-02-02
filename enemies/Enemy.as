package enemies
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import design.HealthBar;
	import flash.utils.Dictionary;
	import common.Commons;


	public class Enemy extends MovieClip
	{
		internal var eMaxHp:int;
		public var eHp:int;
		internal var pt:Point = new Point();
		public var maxMoveSpeed:Number;
		public var moveSpeed:Number;
		internal var mapArray:Array;
		//root used on Debuffs to place image
		public var _root:MovieClip;
		public var goldValue:int;
		public var id:int;
		public var maxArmor:int;
		public var armor:int;
		public var distanceTraveled:Number;
		public var killed:Boolean;
		public var eFrame:int;
		public var increasedDmgTaken:Number;
		public var armorType:String;
		public var eName:String;
		public var isStunned:Boolean;


		public var poisonSlow:Number;
		public var iceSlow:Number;
		protected var healthBar:HealthBar;
		public var removeLife:Boolean;

		private var light:Object;
		private var medium:Object;
		private var heavy:Object;
		private var fort:Object;
		private var pure:Object;

		public function Enemy(Map:Array)
		{
			stop();
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

			// constructor code
		}
		private function added(e:Event):void
		{
			eHp = eMaxHp;
			moveSpeed = maxMoveSpeed;
			armor = maxArmor;
			this.gotoAndStop(eFrame);
			_root = e.currentTarget.parent;
			_root.addChild(healthBar);
			healthBar.visible = false;
			addEventListener(Event.ENTER_FRAME, startMovement);
			removeEventListener(Event.ADDED_TO_STAGE, added);
			setupArmor();
		}
		public function determineMoveSpeed():void
		{
			if (isStunned)
			{
				moveSpeed = 0;
			}
			else
			{
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
		}

		private function setupArmor():void
		{
			light = new Object();
			medium = new Object();
			heavy = new Object();
			fort = new Object();
			pure = new Object();

			light["pierce"] = 1.3;
			light["normal"] = 1;
			light["heavy"] = .70
			;
			medium["pierce"] = .9;
			medium["normal"] = .9;
			medium["heavy"] = 1.2
			;
			heavy["pierce"] = .8;
			heavy["normal"] = .9;
			heavy["heavy"] = 1
			;
			fort["pierce"] = .70;
			fort["normal"] = .8;
			fort["heavy"] = 1.3
			;
			pure["pierce"] = 1;
			pure["normal"] = 1;
			pure["heavy"] = 1
			;
		}
		internal function checkMatchup(dmg,dType):Number
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

		internal function determineArmor(dmg:Number):Number
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

				eHp -=  dmg;
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
		internal function startMovement(e:Event):void
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
		internal function moveCharacter():void
		{
			determineMoveSpeed();
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
			distanceTraveled +=  moveSpeed;
			updateHealth();
		}

		public function destroyThis():void
		{
			mapArray = null;
			removeEventListener(Event.ENTER_FRAME, startMovement);
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