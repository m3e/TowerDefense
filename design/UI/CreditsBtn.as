package design.UI
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import GameScreens.CreditsScreen;


	public class CreditsBtn extends MenuButton
	{

		private var credits: CreditsScreen
		public function CreditsBtn()
		{
			super()

			addEventListener(Event.ADDED_TO_STAGE, added2)
		}
		private function added2(e: Event): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added2)
			
			addEventListener(Event.REMOVED_FROM_STAGE, removed2)
			credits = new CreditsScreen()
			credits.x -= this.x
			credits.y -= this.y
			credits.addEventListener(MouseEvent.CLICK, closeCredits)
			addChild(credits)
			credits.visible = false;
			addEventListener(MouseEvent.CLICK, openCredits)
		}
		private function openCredits(e: MouseEvent): void
		{
			credits.visible = true;

		}
		private function closeCredits(e: MouseEvent): void
		{
			mouseEnabled = true;
			credits.visible = false;
		}
		private function removed2(e: Event): void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removed2)
			removeEventListener(MouseEvent.CLICK, openCredits)
			removeChild(credits);
			credits.removeEventListener(MouseEvent.CLICK, closeCredits)
			credits = null;
		}
	}

}