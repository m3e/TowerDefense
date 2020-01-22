package design.UI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import sounds.SoundManager;
	
	public class MenuButton extends MovieClip {
		
		public var soundEnabled:Boolean = true;
		
		public function MenuButton() {
			addEventListener(Event.ADDED_TO_STAGE, added)
			gotoAndStop(1);
			
			
			// constructor code
		}
		protected function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added)
			addEventListener(MouseEvent.CLICK, clicked)
			addEventListener(MouseEvent.MOUSE_OUT, hoverOff)
			addEventListener(MouseEvent.MOUSE_DOWN, downClick)
			addEventListener(Event.REMOVED_FROM_STAGE, removed)
		}
		protected function clicked(e:MouseEvent):void
		{
			playSound()
			gotoAndStop(1)
		}
		protected function hoverOff(e:MouseEvent):void
		{
			gotoAndStop(1)
		}
		protected function downClick(e:MouseEvent):void
		{
			this.gotoAndStop(2)
		}
		protected function removed(e:Event):void
		{
			removeEventListener(MouseEvent.CLICK, clicked)
			removeEventListener(MouseEvent.MOUSE_OUT, hoverOff)
			removeEventListener(MouseEvent.MOUSE_DOWN, downClick)
			removeEventListener(Event.REMOVED_FROM_STAGE, removed)
		}
		protected function playSound():void
		{
			if (soundEnabled == true)
			{
			SoundManager.sfx("clickbutton")
			}
		}
	}
	
}
