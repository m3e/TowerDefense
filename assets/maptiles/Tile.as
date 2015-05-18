package  assets.maptiles {
	
	import flash.display.MovieClip
	import flash.events.*;
	
	public class Tile extends MovieClip{
		
		public var occupied:Boolean;
		private var _root:MovieClip;

		public function Tile() {
			occupied = false;
			addEventListener(Event.ADDED_TO_STAGE, beginClass)
			// constructor code
		}
		
		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);
			removeEventListener(Event.ADDED_TO_STAGE, beginClass);
		}

	}
	
}
