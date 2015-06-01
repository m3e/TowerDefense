package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.text.TextField;
	
	
	public class UserInfo extends MovieClip {
		
		private var _root:Object;
				
		//GOLD
		private var goldBox:Shape;
		private var goldBoxText:TextField;
		public var gold:int;
		
		//LIVES
		private var livesBar:Shape;
		private var livesTextBox:TextField;
		public var lives:int;
		
		public function UserInfo() {
			gold = 99999;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage)
			// constructor code
		}
		private function addedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage)
			
			_root = MovieClip(root)
			
			
			//GOLD
			goldBox = new Shape();
			goldBox.graphics.lineStyle(2, 0xFFFFFF)
			goldBox.graphics.beginFill(0x000000,.5)
			goldBox.graphics.drawRect(0, 0, 80, 20)
			goldBox.graphics.endFill();
			goldBox.x = 650
			goldBox.y = 390
			_root.addChild(goldBox);
			
			goldBoxText = new TextField;
			goldBoxText.textColor = 0xFFFFFF
			goldBoxText.text = gold.toString();
			goldBoxText.x = 655
			goldBoxText.y = 390
			goldBoxText.height = 20
			goldBoxText.width = 80;
			goldBoxText.selectable = false;
			
			_root.addChild(goldBoxText);
			
			//LIVES
			livesBar = new Shape();
			livesBar.graphics.lineStyle(2,0xFFFFFF)
			livesBar.graphics.beginFill(0x000000,.5)
			livesBar.graphics.drawRect(0,0,80,20);
			livesBar.graphics.endFill();
			livesBar.x = 650
			livesBar.y = 360
			_root.addChild(livesBar);
			
			lives = 50;
			
			livesTextBox = new TextField();
			livesTextBox.textColor = 0xFFFFFF
			livesTextBox.text = "Lives: " + lives.toString();
			livesTextBox.x = 650
			livesTextBox.y = 360
			livesTextBox.height = 20
			livesTextBox.width = 80
			livesTextBox.selectable = false;
			
			_root.addChild(livesTextBox);
			
		}
		public function canAfford(cost:int):Boolean
		{
			var afford:Boolean;
			if (cost <= gold)
			{
				afford = true;
			}
			return afford;
		}
		public function changeGold(goldChange:int):void
		{
			gold += goldChange
			goldBoxText.text = gold.toString();
		}
		public function updateLives(subtractedLives:int):void
		{
			lives -= subtractedLives;
			livesTextBox.text = "Lives: " + lives.toString();
		}
		public function getGold():int
		{
			return gold;
		}
	}
	
}
