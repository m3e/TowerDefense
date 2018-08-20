package buffs
{

	import flash.display.Sprite;
	import flash.events.*;
	import towers.*;
	import flash.display.*;
	
	public class DmgBuff extends Sprite
	{

		public var tTarget:Tower;
		private var sAmount:Number;
		private var sSeconds:Number;

		private var rectangle:Shape;
		private var frames:int;

		public function DmgBuff(_Target:Tower, _amount:Number,_seconds:Number)
		{
			rectangle = new Shape  ;
			rectangle.graphics.beginFill(0xf4f442);
			// choosing the colour for the fill, here it is red;
			rectangle.graphics.drawRect(0,0, 8,8);
			// (x spacing, y spacing, width, height);
			rectangle.graphics.endFill();
			// not always needed but I like to put it in to end the fill;
			addChild(rectangle);// adds the rectangle to the stage

			tTarget = _Target;
			sAmount = _amount;
			sSeconds = _seconds;
			this.x = tTarget.x;
			this.y = tTarget.y;
			tTarget.buffsArray.push(this);
			addEventListener(Event.ENTER_FRAME, buffTick);
			// constructor code
		}
		private function buffTick(e:Event):void
		{
			if (tTarget != null)
			{
				if (frames < sSeconds * 24)
				{
					if (sAmount > tTarget.tDmgBuff)
					{
						tTarget.tDmgBuff = sAmount;
					}
				}
				else
				{
					finishBuff();
				}
				
			}
			else
			{
				finishBuff();
			}
			frames++;
		}
		public function finishBuff():void
		{

			tTarget.tDmgBuff = 0;
			removeEventListener(Event.ENTER_FRAME, buffTick);
			if (rectangle != null && this.contains(rectangle))
			{
				removeChild(rectangle);
			}
			rectangle = null;
			if (tTarget._root.contains(this))
			{
				tTarget._root.removeChild(this);
				if (tTarget.buffsArray.indexOf(this) != -1)
				{
					tTarget.buffsArray.splice(tTarget.buffsArray.indexOf(this),1);
					
				}
				else
				{
					
				}
			}
			tTarget = null;
		}
	}


}