package enemies
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;


	public class Enemy extends Sprite
	{
		public var eHp:int;
		public var pt:Point = new Point();
		public var maxMoveSpeed:Number;
		public var moveSpeed:Number;
		public var mapArray:Array;
		//root used on Debuffs to place image
		public var _root:MovieClip;
		public var goldValue:int;
		public var id:int;
		public var maxArmor:int;
		public var armor:int;

		public function Enemy(Map:Array)
		{
			id = 9999 * Math.random();
			mapArray = Map;
			addEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.ENTER_FRAME, startMovement);
			// constructor code
		}
		private function added(e:Event):void
		{
			_root = MovieClip(root);
			removeEventListener(Event.ADDED_TO_STAGE, added);
		}
		public function determineArmor(dmg:int, damageType:String):Number
		{
			var dmgReduction:Number = 0;
			switch (damageType)
			{
				case ("phys") :
					if (armor > 0)
					{
						dmgReduction = ((armor)*0.06)/(1+0.06*(armor));
						dmgReduction = Math.round(dmgReduction * 100) / 100;
					}
					else if (armor < 0)
					{
						dmgReduction = -(1- Math.pow(2-0.94,armor));
					}

					break;

				case ("fire") :
				case ("ice") :
				case ("earth") :
					

					break;
			}
			trace(damageType);
			return dmgReduction;

		}
		public function takeDmg(dmg:Number,dType:String):void
		{
			//calculate reduced dmg
			if (eHp > 0)
			{
				dmg -=  (dmg * determineArmor(armor,dType));
				eHp -=  dmg;
			}
			if (eHp <= 0)
			{
				destroyThis();
			}
		}
		public function startMovement(e:Event):void
		{


			switch (mapArray[Math.floor(pt.y)][Math.floor(pt.x)])
			{
				case 1 :

					x +=  moveSpeed;
					if (Math.floor(x/32) != pt.x)
					{
						x -=  x % 32;
						pt.x = x / 32;
					}
					break;

				case 2 :

					y +=  moveSpeed;
					if (Math.floor(y/32) != pt.y)
					{
						y -=  y % 32;
						pt.y = y / 32;

					}
					break;

				case 3 :

					x -=  moveSpeed;
					if (Math.ceil(x/32) != pt.x)
					{
						pt.x--;
						x +=  Math.abs(pt.x * 32 - x);
					}
					break;

				case 4 :
					y -=  moveSpeed;

					if (Math.ceil(y/32) != pt.y)
					{
						pt.y--;
						y +=  Math.abs(pt.y * 32 - y);
					}
					break;
			}
		}

		private function destroyThis():void
		{
			mapArray = null;
			removeEventListener(Event.ENTER_FRAME, startMovement);
			_root.removeChild(this);
			_root = null;
		}
	}

}