package GameScreens
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import design.UI.MenuButton;
	import flash.events.MouseEvent;
	import sounds.SoundManager;
	import User.UserProfile;
	import common.Commons;

	public class FiftyOneVictoryScreen extends MovieClip
	{

		public var restartButton: MenuButton;
		public var backToMap: MenuButton;

		public function FiftyOneVictoryScreen(fiftyOneKills: int)
		{
			TotalKills.text = String(fiftyOneKills);
			
			if (fiftyOneKills > UserProfile.topJesterKills)
			{
				UserProfile.topJesterKills = fiftyOneKills;
			}
			
			UserProfile.totalJesterKills += fiftyOneKills;

			Commons.saveGame();

			Commons.kongregate.stats.submit("jesterKillsTotal", UserProfile.totalJesterKills);
			Commons.kongregate.stats.submit("jesterKills", UserProfile.topJesterKills);

			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		private function added(e: Event): void
		{
			SoundManager.playSong("GameOverTheme");
			removeEventListener(Event.ADDED_TO_STAGE, added);

			var sameY: int = this.height - 120
			var scaleBy: Number = .4
			var separation: int = 40
			restartButton = new MenuButton();
			restartButton.btnText.text = "Restart Map"
			restartButton.scaleX = scaleBy
			restartButton.scaleY = scaleBy
			restartButton.x = (this.width / 2) - restartButton.width - separation
			trace(this.width, restartButton.width, separation);
			restartButton.y = sameY
			addChild(restartButton)
			restartButton.addEventListener(MouseEvent.CLICK, closeWindow)

			backToMap = new MenuButton();
			backToMap.scaleX = scaleBy
			backToMap.scaleY = scaleBy
			backToMap.x = (this.width / 2) + separation
			backToMap.y = sameY;
			backToMap.btnText.text = "Change Map"
			backToMap.addEventListener(MouseEvent.CLICK, closeWindow)
			addChild(backToMap);
		}
		private function closeWindow(e: Event): void
		{
			restartButton.removeEventListener(MouseEvent.CLICK, closeWindow)
			backToMap.removeEventListener(MouseEvent.CLICK, closeWindow)
			removeChild(restartButton)
			removeChild(backToMap)
			parent.removeChild(this)
		}
	}

}