package buffs {
	
	import flash.display.Sprite;
	import towers.Tower;
	import flash.events.Event;
	import flash.display.Shape;
	
	
	public class AtkSpdBuff extends Sprite {
		
		public var tTarget:Tower;
		private var sAmount:Number;
		private var sSeconds:Number;

		private var rectangle:Shape;
		private var frames:int;
		
		public function AtkSpdBuff(_Target:Tower, _amount:Number,_seconds:Number) {
			rectangle = new Shape  ;
			rectangle.graphics.beginFill(0xE9FF30);
			// choosing the colour for the fill, here it is red;
			rectangle.graphics.drawRect(24,0, 8,8);
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
					if (sAmount > tTarget.tAtkSpdBuff)
					{
						tTarget.tAtkSpdBuff = sAmount;
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

			tTarget.tAtkSpdBuff = 0;
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
