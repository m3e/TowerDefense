package GameScreens {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import design.UI.NewGame;
	import flash.events.MouseEvent;
	import design.UI.OptionsWindow;
	import sounds.SoundManager;
	
	
	public class StartScreen extends MovieClip {
		
		//private var newGame:NewGame;
		private var optionsWindow:OptionsWindow;
		
		public function StartScreen() {
			addEventListener(Event.ADDED_TO_STAGE,added)
			addEventListener(Event.REMOVED_FROM_STAGE,removed)
			// constructor code
		}
		private function added(e:Event):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE,added)
			sounds.SoundManager.bgfx("mainTheme");
			options.addEventListener(MouseEvent.CLICK, optionsClicked)
			//newGame = new NewGame();
			//addChild(newGame);
			//newGame.menuName.text = "New Game"
		}
		private function optionsClicked(e:MouseEvent):void
		{
			optionsWindow = new OptionsWindow(false)
			optionsWindow.x = 0
			optionsWindow.y = 0
			addChild(optionsWindow);
		}
		private function removed(e:Event):void
		{
			options.removeEventListener(MouseEvent.CLICK, optionsClicked)
			optionsWindow = null;
			newGame = null;
			removeEventListener(Event.REMOVED_FROM_STAGE,removed)
		}
	}
	
}
