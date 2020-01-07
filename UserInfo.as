package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.text.TextField
	import flash.events.MouseEvent;
	import com.greensock.TweenLite
	
	
	public class UserInfo extends MovieClip {
		
		private var _root:Object;
				
		//GOLD
		private static var goldBox:GoldBox;
		public static var gold:int;
		
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
			goldBox._caBox.alpha = 0
			addChild(goldBox);
			
			//LIVES
			livesBar = new LivesBar();
			livesBar.x = 585
			livesBar.y = 500
			livesBar.name = "livesBar"
			livesBar.LivesText.text = lives.toString();
			addChild(livesBar);
		}		
		public static function canAfford(cost:int):Boolean
		{
			var afford:Boolean;
			if (cost <= gold)
			{
				afford = true;
			}
			else
			{
				goldBox._caBox.alpha = 0
				TweenLite.from(goldBox._caBox,.2,{alpha:1})
			}
			return afford;
		}
		public static function changeGold(goldChange:int):void
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
