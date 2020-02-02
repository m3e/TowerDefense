package design.UI {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class OptionsButton extends MenuButton {
		
		
		public function OptionsButton() {
			super();
			// constructor code
		}
		override protected function hoverOn(e:MouseEvent):void
		{
			gotoAndStop(3);
		}
	}
	
}
