package  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class FlameGroundBullet extends Sprite {
		
		private var bTarget:Object;
		private var framesAlive:int;
		
		public function FlameGroundBullet(myTarget:Object) {
			bTarget = myTarget;
			this.mouseEnabled = false
			addEventListener(Event.ADDED_TO_STAGE, added)
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added)
			addEventListener(Event.ENTER_FRAME, eFrame)
		}
		private function eFrame(e:Event):void
		{
			framesAlive++
			/*if (bTarget != null)
			{
			this.x = bTarget.x
			this.y = bTarget.y
			}*/
			if (framesAlive == 2 || bTarget == null)
			{
				destroyThis();
			}
		}
		private function destroyThis():void
		{
			bTarget = null;
			removeEventListener(Event.ENTER_FRAME, eFrame)
			parent.removeChild(this)
		}
	}
	
}
