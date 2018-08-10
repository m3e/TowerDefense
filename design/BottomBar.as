package design{
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.display.Sprite;
	import design.MenuManager
	
	public class BottomBar extends Sprite {
		
		private var _root:Object;
		private var menuManager:MenuManager;
		
		public function BottomBar(e:Object) {
			_root = e;
			
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, addSelf)
		}
		private function addSelf(e:Event):void
		{
			menuManager = new MenuManager(_root);
			menuManager.x = 695
			menuManager.y = 11
			addChild(menuManager);
			removeEventListener(Event.ADDED_TO_STAGE, addSelf)
		}
		public function towerMapClicked(e:Event):void
		{
			MiddleInfo.updateText(e);
			menuManager.updateMenu(e);
		}
		public function tileMapClicked(e:Event):void
		{
			menuManager.tileMapClicked(e)
		}
		public function keyDownPress(e:KeyboardEvent):void
		{
			menuManager.keyDownPress(e);
		}
		public function defaultMenu():void
		{
			menuManager.returnToDefaultMenu();
		}
	}
	
}
