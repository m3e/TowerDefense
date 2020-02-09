package assets.UI.BattleMap {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import common.Commons;
	
	public class NormalSpeed extends MovieClip {
		
		
		public function NormalSpeed() {
			addEventListener(Event.ADDED_TO_STAGE, added)
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added)
			addEventListener(MouseEvent.CLICK,normalSpeed)
			addEventListener(Event.REMOVED_FROM_STAGE, removed)
		}
		private function normalSpeed(e:MouseEvent):void
		{
			common.Commons.fRate = 24
			stage.frameRate = common.Commons.fRate
		}
		private function removed(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removed)
			removeEventListener(MouseEvent.CLICK,normalSpeed)
		}
	}
}
