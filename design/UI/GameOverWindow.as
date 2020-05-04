package design.UI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import design.UI.MenuButton;
	import flash.events.MouseEvent;
	import sounds.SoundManager;
	
	public class GameOverWindow extends MovieClip {
		
		public var restartButton:MenuButton;
		public var backToMap:MenuButton;
		
		public function GameOverWindow() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		private function added(e:Event):void
		{
				SoundManager.playSong("GameOverTheme");
				removeEventListener(Event.ADDED_TO_STAGE, added);
				
				var sameY:int = 280
				var scaleBy:Number = .5
				var separation:int = 20
				restartButton = new MenuButton();
				restartButton.btnText.text = "Restart Map"
				restartButton.scaleX = scaleBy
				restartButton.scaleY = scaleBy
				restartButton.x = (this.width / 2) - restartButton.width - separation
				restartButton.y = sameY
				addChild(restartButton)
				restartButton.addEventListener(MouseEvent.CLICK, closeWindow)
				
				backToMap = new MenuButton();
				backToMap.scaleX = scaleBy
				backToMap.scaleY = scaleBy
				backToMap.x = (this.width / 2) + separation
				backToMap.y = sameY;
				backToMap.btnText.text = "Change Map"
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
