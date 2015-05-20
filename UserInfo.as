package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.text.TextField;
	
	
	public class UserInfo extends MovieClip {
		
		private var _root:Object;
		
		private var goldBox:Shape;
		public var goldBoxText:TextField;
		
		public var gold:int;
		
		public function UserInfo() {
			gold = 0;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage)
			// constructor code
		}
		private function addedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage)
			
			_root = MovieClip(root)
			
			goldBox = new Shape();
			goldBox.graphics.lineStyle(2, 0xFFFFFF)
			goldBox.graphics.beginFill(0x000000,.5)
			goldBox.graphics.drawRect(0, 0, 120, 40)
			goldBox.graphics.endFill();
			goldBox.x = 660
			goldBox.y = 420
			_root.addChild(goldBox);
			
			goldBoxText = new TextField;
			goldBoxText.textColor = 0xFFFFFF
			goldBoxText.text = gold.toString();
			goldBoxText.x = 670
			goldBoxText.y = 430
			
			_root.addChild(goldBoxText);
			
		}
		public function changeGold(goldChange:int):void
		{
			gold += goldChange
			goldBoxText.text = gold.toString();
		}
		public function getGold():int
		{
			return gold;
		}
	}
	
}
