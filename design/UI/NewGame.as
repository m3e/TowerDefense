package design.UI {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class NewGame extends MenuButton {
		
		
		public function NewGame() {
			super()
			// constructor code
		}
		override protected function clicked(e:MouseEvent):void
		{
			playSound()
			removed(undefined);
			gotoAndStop(1)
		}
	}
	
}
