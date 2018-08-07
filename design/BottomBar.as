package design{
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.text.TextField;
	
	public class BottomBar extends Sprite {
		
		private var _root:MovieClip;
		
		public function BottomBar() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, addSelf)
		}
		private function addSelf(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addSelf)
		}
		public function towerMapClicked(SelectedObject:Event):void
		{
			MiddleInfo.updateText(SelectedObject);
			MenuManagerInstance.updateMenu(SelectedObject);
		}
	}
	
}
