package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;


	public class Enemy1 extends MovieClip
	{

		public var eHp:Number;
		public var pt:Point = new Point();
		private var moveSpeed:int;
		private var mapArray:Array;
		private var _root:MovieClip;
		public var id:int;

		public function Enemy1(Map:Array)
		{
			mapArray = Map;
			stop();
			eHp = 4;
			moveSpeed = 3;
			addEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.ENTER_FRAME, startMovement);
			// constructor code
		}
		private function added(e:Event):void
		{
			_root=MovieClip(root);
			removeEventListener(Event.ADDED_TO_STAGE, added);
		}
		public function startMovement(e:Event):void
		{
			if (eHp <= 0)
			{
				
				destroyThis();
			}
			else
			{
				
				switch (mapArray[Math.floor(pt.y)][Math.floor(pt.x)])
				{
					case 1 :
						if (currentFrame != 1)
						{
							gotoAndStop(1);
						}
						else
						{
							gotoAndStop(2);
						}
						x +=  moveSpeed;
						if (Math.floor(x/32) != pt.x)
						{
							x -=  x % 32;
							pt.x = x / 32;
						}
						break;

					case 2 :
						if (currentFrame != 7)
						{
							gotoAndStop(7);
						}
						else
						{
							gotoAndStop(8);
						}
						y +=  moveSpeed;
						if (Math.floor(y/32) != pt.y)
						{
							y -=  y % 32;
							pt.y = y / 32;

						}
						break;

					case 3 :
						if (currentFrame != 3)
						{
							gotoAndStop(3);
						}
						else
						{
							gotoAndStop(4);
						}
						x -=  moveSpeed;
						if (Math.ceil(x/32) != pt.x)
						{
							pt.x--;
							x +=  Math.abs(pt.x * 32 - x);
						}
						break;

					case 4 :
						y -=  moveSpeed;
						if (currentFrame != 5)
						{
							gotoAndStop(5);
						}
						else
						{
							gotoAndStop(6);
						}
						if (Math.ceil(y/32) != pt.y)
						{
							pt.y--;
							y +=  Math.abs(pt.y * 32 - y);
						}
						break;
				}
			}
		}
		private function destroyThis():void
		{
			mapArray = null;
			removeEventListener(Event.ENTER_FRAME, startMovement);
			_root.removeChild(this)
			_root = null;
		}
	}

}