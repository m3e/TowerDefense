package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.text.TextField
	import flash.events.MouseEvent;

	
	
	public class UserInfo extends MovieClip {
		
		private var _root:Object;
				
		//GOLD
		private var goldBox:GoldBox;
		public var gold:int;
		
		//LIVES
		private var livesBar:LivesBar;
		public var lives:int;
		
		public function UserInfo() {
			gold = 100;
			lives = 20;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage)
			// constructor code
		}
		private function addedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage)
			
			_root = MovieClip(root)
			
			//GOLD
			goldBox = new GoldBox();
			goldBox.x = 591
			goldBox.y = 475
			goldBox.name = "goldBox"
			goldBox.GoldText.text = gold.toString();
			addChild(goldBox);
			
			//LIVES
			livesBar = new LivesBar();
			livesBar.x = 585
			livesBar.y = 500
			livesBar.name = "livesBar"
			livesBar.LivesText.text = lives.toString();
			addChild(livesBar);
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
			goldBox.GoldText.text = gold.toString();
		}
		public function updateLives(subtractedLives:int):void
		{
			lives -= subtractedLives;
			livesBar.LivesText.text = lives.toString();
		}
		public function getGold():int
		{
			return gold;
		}
	}
	
}
