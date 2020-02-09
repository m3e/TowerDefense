package  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import common.Commons;
	
	
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
			common.Commons.addSkillsList(this)
		}
		public function pausedGame():void
		{
			removeEventListener(Event.ENTER_FRAME, eFrame);
		}
		public function resumedGame():void
		{
			addEventListener(Event.ENTER_FRAME, eFrame);
		}
		private function eFrame(e:Event):void
		{
			framesAlive++
			if (framesAlive == 2 || bTarget == null)
			{
				destroyThis();
			}
		}
		private function destroyThis():void
		{
			common.Commons.removeSkillsList(this)
			bTarget = null;
			removeEventListener(Event.ENTER_FRAME, eFrame)
			parent.removeChild(this)
		}
	}
	
}
