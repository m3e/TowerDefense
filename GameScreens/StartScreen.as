package GameScreens {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import design.UI.NewGame;
	
	
	public class StartScreen extends MovieClip {
		
		//private var newGame:NewGame;
		
		public function StartScreen() {
			addEventListener(Event.ADDED_TO_STAGE,added)
			addEventListener(Event.REMOVED_FROM_STAGE,removed)
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,added)
			//newGame = new NewGame();
			//addChild(newGame);
			//newGame.menuName.text = "New Game"
		}
		private function removed(e:Event):void
		{
			newGame = null;
			removeEventListener(Event.REMOVED_FROM_STAGE,removed)
		}
	}
	
}
