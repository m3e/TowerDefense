package design
{

	import flash.display.MovieClip;
	import towers.*;
	import flash.events.Event;

	public class MenuManager extends MovieClip
	{

		private var currentMenuSelected:Array;

		public function MenuManager()
		{
			currentMenuSelected = new Array  ;
			var menuLength:int = 4;
			var menuHeight:int = 3;
			for (var i:int = 0; i < menuHeight; i++)
			{
				currentMenuSelected[i] = [];
				for (var p:int=0; p < menuLength; p++)
				{
					currentMenuSelected[i][p] = undefined;
				}
			}
			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			returnToDefaultMenu();
		}
		public function returnToDefaultMenu():void
		{
			emptyOutMenuSelected();
			currentMenuSelected = [[Warrior,Arrow,FireTower,IceTower],
			   [Splash,,,],
			   [,,,]];
			updateCurrentMenu();
		}
		private function updateCurrentMenu():void
		{
			for (var i:int=0; i < currentMenuSelected.length; i++)
			{
				for (var p:int=0; p < currentMenuSelected[i].length; p++)
				{
					var ct = currentMenuSelected[i][p];
					trace(ct);
					switch (true)
					{

						case (ct is Tower) :
							trace("menumanager.updatemenu");
							break;
					}
				}
			}
		}
		public function updateMenu(e:Event):void
		{

			switch (true)
			{
				case (e.currentTarget is Tower) :
					currentMenuSelected = e.currentTarget.tMenu;
					break;
			}
			updateCurrentMenu();
		}
		private function emptyOutMenuSelected():void
		{
			for (var i:int=0; i < currentMenuSelected.length; i++)
			{
				for (var p:int=0; p < currentMenuSelected[i].length; p++)
				{
					currentMenuSelected[i][p] = undefined;
				}
			}
		}

	}

}