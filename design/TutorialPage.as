package design {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import common.Commons;
	import User.UserProfile;
	
	
	public class TutorialPage extends MovieClip {
		
		
		public function TutorialPage() {
			gotoAndStop(1);
			addEventListener(Event.ADDED_TO_STAGE, added)
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added)			
			addEventListener(Event.REMOVED_FROM_STAGE, removed)			
			addEventListener(MouseEvent.CLICK, nextPage)
		}
		private function nextPage(e:Event):void
		{
			if(currentFrame < totalFrames)
			{
				gotoAndStop(currentFrame+1);
			}
			else
			{
				gotoAndStop(1);
				visible = false;
				if (UserProfile.returnUser == false)
				{
					UserProfile.returnUser = true;
					Commons.saveGame();
				}
			}
		}
		private function removed(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removed)
			removeEventListener(MouseEvent.CLICK, nextPage)
		}
	}
	
}
