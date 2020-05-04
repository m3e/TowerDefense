package Maps.Maps {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import design.LockedMapIcon;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import common.Commons;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import com.greensock.loading.ImageLoader;
	import com.greensock.events.LoaderEvent;
	import flash.display.Bitmap;
	
	public class MapSelections extends MovieClip {
		
		public var mapArray:Array;
		private var lmi:LockedMapIcon;
		public var mapLocked:Boolean;
		protected var mapID:String;
		protected var gameName:String;
		public var startX:int = 0;
		public var startY:int = 6;
		
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
		public function startGame():void
		{
			common.Commons.setMapArray(mapArray);
			common.Commons.setStartPoints(startX,startY);
		}
		private function removed(e:Event):void
		{
			removeEventListener(Event.REMOVED,removed)
			removeChild(lmi);
			lmi = null;
		}
		
	}
	
}
