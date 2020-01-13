package  assets.maptiles {
	
	import flash.display.MovieClip
	import flash.events.*;
	import enemies.Enemy;
	import assets.maptiles.Ice;
	
	public class Tile extends MovieClip{
		
		public var occupied:Boolean;
		private var _root:MovieClip;
		
		public var isIced:Boolean;
		public var icedSlow:Number = 0;
		private var iceLayer:Ice;

		public function Tile() {
			occupied = false;
			addEventListener(Event.ADDED_TO_STAGE, beginClass)
			addEventListener(Event.REMOVED, endClass)
			// constructor code
		}
		
		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);
			removeEventListener(Event.ADDED_TO_STAGE, beginClass);
		}
		public function addIceLayer(ice:Ice,slow:Number):void
		{
			iceLayer = ice;
			icedSlow = slow;
			isIced = true;
			addChild(iceLayer)
		}
		public function removeIceLayer():void
		{
			removeChild(iceLayer)
			icedSlow = 0;
			isIced = false;
			iceLayer = null;
		}
		private function endClass(e:Event):void
		{
			iceLayer = null;
			_root = null;
			removeEventListener(Event.ADDED_TO_STAGE, beginClass);
			removeEventListener(Event.REMOVED, endClass)
		}
	}
	
}
