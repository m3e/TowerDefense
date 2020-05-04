package design.UI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import design.TutorialPage;
	import common.Commons;
	
	
	public class HelpIcon extends MovieClip {
		
		private var tutorial:TutorialPage;
		private var _root:Object;
		public function HelpIcon() {
			addEventListener(Event.ADDED_TO_STAGE, added)
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added)			
			_root = Commons.getRoot();
			addEventListener(MouseEvent.CLICK, clicked,false,0,true)
			tutorial = new TutorialPage()			
			_root.highPriority.addChild(tutorial)
			tutorial.visible = false;
			addEventListener(Event.REMOVED_FROM_STAGE, removed)
		}
		private function clicked(e:Event):void
		{
			openTutorial();
		}
		public function openTutorial():void
		{
			_root.highPriority.setChildIndex(tutorial,_root.highPriority.numChildren-1)
			tutorial.visible = true;
		}
		private function removed(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removed)
			removeEventListener(MouseEvent.CLICK, clicked)
			_root.highPriority.removeChild(tutorial)
			tutorial = null;
			_root = null;
		}
	}
	
}
