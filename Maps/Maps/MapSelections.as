package Maps.Maps {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import design.LockedMapIcon;
	
	
	public class MapSelections extends MovieClip {
		
		public var mapArray:Array;
		private var lmi:LockedMapIcon;
		public var mapLocked:Boolean;
		
		public function MapSelections() {
			mapArray = new Array;
			lmi = new LockedMapIcon;
			lmi.mouseEnabled = false
			addEventListener(Event.ADDED, added)
			addEventListener(Event.REMOVED, removed)
			
			setMapArray();
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED, added);
			lmi.alpha = .4
			mapLocked = true;
			addChild(lmi)
		}
		internal function setMapArray():void
		{
			
		}
		public function unlockMap():void
		{
			mapLocked = false;
			lmi.visible = false;
		}
		public function lockMap():void
		{
			mapLocked = true;
			lmi.visible = true;
		}
		private function removed(e:Event):void
		{
			removeEventListener(Event.REMOVED,removed)
			removeChild(lmi);
			lmi = null;
		}
		
	}
	
}
