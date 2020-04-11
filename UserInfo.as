package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.text.TextField
	import flash.events.MouseEvent;
	import com.greensock.TweenLite
	
	
	public class UserInfo extends MovieClip {
				
		//GOLD
		//private static var goldBox:GoldBox;
		//public static var gold:int;
		
		//LIVES
		//private static var livesBar:LivesBar;
		//public static var lives:int;
		
		
		
		public function UserInfo() {
			//gold = 100;
			//lives = 20;
			//addEventListener(Event.ADDED_TO_STAGE, addedToStage)
			// constructor code
		}
		/*private function addedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage)
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage)
			//GOLD
			goldBox = new GoldBox();
			goldBox.x = 593
			goldBox.y = 480
			goldBox.name = "goldBox"
			goldBox.GoldText.text = gold.toString();
			goldBox._caBox.alpha = 0
			addChild(goldBox);
			
			//LIVES
			livesBar = new LivesBar();
			livesBar.x = 590
			livesBar.y = 507
			livesBar.name = "livesBar"
			livesBar.LivesText.text = lives.toString();
			addChild(livesBar);
		}		
		/*public static function can1Afford(cost:int):Boolean
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
		public static function change1Gold(goldChange:int):void
		{
			gold += goldChange
			goldBox.GoldText.text = gold.toString();
		}
		public static function update1Lives(subtractedLives:int):void
		{
			lives -= subtractedLives;
			livesBar.LivesText.text = lives.toString();
		}
		public function getGold():int
		{
			return gold;
		}
		private function removedFromStage(e:Event):void
		{
			endClass();
		}*/
		/*private function endClass():void
		{
			removeChild(goldBox)
			removeChild(livesBar)
			goldBox = null;
			livesBar = null;
		}*/
	}
	
}
