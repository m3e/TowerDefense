package  assets.maptiles {
	
	import flash.display.MovieClip
	import flash.events.*;
	import enemies.Enemy;
	
	public class Tile extends MovieClip{
		
		public var occupied:Boolean;
		private var _root:MovieClip;
		
		public var iced:Boolean;
		public var tileEffectsArray:Array = new Array;

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
		public function addEffects(e:Array):void
		{
			//tea.push(e);
		}
		public function tileEffects(e:Enemy):void
		{
			var tea:Array = tileEffectsArray;
			for (var i:int=0; i < tea.length; i++)
			{
				
			}
		}

	}
	
}
