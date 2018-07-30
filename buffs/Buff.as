package buffs {
	
	import flash.display.Sprite;
	import flash.events.*;
	import towers.*;
	import flash.display.*
	
	
	public class Buff extends Sprite {
		
		public var tTarget:Tower;
		private var sAmount:Number;
		private var sSeconds:Number;
		
		private var rectangle:Shape 
		
		private var frames:int;
		
		public function Buff(_Target:Tower, _amount:Number,_seconds:Number) {
			rectangle = new Shape;
			rectangle.graphics.beginFill(0xf4f442); // choosing the colour for the fill, here it is red
			rectangle.graphics.drawRect(0,0, 8,8); // (x spacing, y spacing, width, height)
			rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
			addChild(rectangle); // adds the rectangle to the stage

			tTarget = _Target;
			sAmount = _amount;
			sSeconds=_seconds;
			this.x = tTarget.x
			this.y = tTarget.y
			tTarget.buffsArray.push(this);
			addEventListener(Event.ENTER_FRAME, buffTick)
			//addEventListener(Event.ADDED_TO_STAGE, added)
			addEventListener(Event.REMOVED, removed)
			// constructor code
		}
		/*private function added(e:Event):void
		{
			rectangle.graphics.beginFill(0xf4f442); // choosing the colour for the fill, here it is red
			rectangle.graphics.drawRect(0,0, 8,8); // (x spacing, y spacing, width, height)
			rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
			addChild(rectangle); // adds the rectangle to the stage
		}*/
		private function removed(e:Event):void
		{
			
			//removeEventListener(Event.ADDED_TO_STAGE, added)
			removeEventListener(Event.REMOVED, removed)
			
		}
		private function buffTick(e:Event):void
		{
			if (tTarget != null && frames < sSeconds * 24)
			{
				if (sAmount > tTarget.tDmgBuff)
				{
					tTarget.tDmgBuff = sAmount;
				}
				else
				{
				
				}
			}
			else
			{
				if (tTarget != null)
				{
					finishBuff()
				}
			}
			frames++
		}
		public function finishBuff():void
		{
			
			tTarget.tDmgBuff = 0
			removeEventListener(Event.ENTER_FRAME, buffTick)
			
			if (rectangle != null && this.contains(rectangle))
			{
				removeChild(rectangle)
			}
			
			rectangle = null;
			if (tTarget.contains(this))
			{
			tTarget.removeChild(this);
			tTarget.buffsArray.splice(tTarget.buffsArray.indexOf(this),1)
			}
			tTarget = null;
		}
	}
	
	
}
