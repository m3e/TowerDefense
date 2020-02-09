package design.UI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import design.UI.MenuButton;
	import flash.events.MouseEvent;
	
	public class GameOverWindow extends MovieClip {
		
		public var restartButton:MenuButton;
		public var backToMap:MenuButton;
		
		public function GameOverWindow() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		private function added(e:Event):void
		{
				removeEventListener(Event.ADDED_TO_STAGE, added);
				
				restartButton = new MenuButton();
				restartButton.btnText.text = "Restart Map"
				restartButton.scaleX = .4
				restartButton.scaleY = .4
				restartButton.x = 300
				restartButton.y = 350
				addChild(restartButton)
				restartButton.addEventListener(MouseEvent.CLICK, closeWindow)
				
				backToMap = new MenuButton();
				backToMap.scaleX = .4
				backToMap.scaleY = .4
				backToMap.x = 480
				backToMap.y = 350
				backToMap.btnText.text = "Return to Map"
				backToMap.addEventListener(MouseEvent.CLICK, closeWindow)
				addChild(backToMap);
		}
		private function closeWindow(e:Event):void
		{
			restartButton.removeEventListener(MouseEvent.CLICK, closeWindow)
			backToMap.removeEventListener(MouseEvent.CLICK, closeWindow)
			removeChild(restartButton)
			removeChild(backToMap)
			parent.removeChild(this)
		}
	}
	
}
