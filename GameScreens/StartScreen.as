package GameScreens {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import design.UI.NewGame;
	import flash.events.MouseEvent;
	import design.UI.OptionsWindow;
	import sounds.SoundManager;
	
	
	public class StartScreen extends MovieClip {
		
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
			
			
			var scaleBy:int = 4
			torch1.scaleX = scaleBy
			torch1.scaleY = scaleBy

			torch2.scaleX = scaleBy
			torch2.scaleY = scaleBy
			
			var torchY:int = 265
			var separation:int = 60
			torch1.x = (stage.width / 2) - (torch1.spriteSize * scaleBy) - separation;
			torch1.y = torchY
			torch2.x = (stage.width / 2) + separation
			torch2.y = torchY
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
			torch1 = null;
			torch2 = null;
			optionsWindow = null;
			newGame = null;
			removeEventListener(Event.REMOVED_FROM_STAGE,removed)
		}
	}
	
}
