package GameScreens
{

	import flash.display.MovieClip;
	import flash.events.*;
	import Maps.UI.MapPreview;
	import Maps.*;
	import flash.display.StageScaleMode;
	import flash.display.Stage;
	import common.Commons;
	import User.UserProfile;
	import design.LockedMapIcon;
	import sounds.SoundManager;

	public class MapSelectScreen extends MovieClip
	{

		private var lastLoaded:Object;
		private var levelsArray:Array = new Array  ;
		private var gameMode:int;

		public function MapSelectScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage)
			gameMode = 0;
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			levelsArray.push(SFields,WPath,TOldBridge,BHideout,VOfTrolls,MMayhem,WAlley,TOfMages,SCircle);
			
			survivalButton.addEventListener(MouseEvent.MOUSE_DOWN, selectMode)
			campaignButton.addEventListener(MouseEvent.MOUSE_DOWN, selectMode)

			for (var i:int=0; i < levelsArray.length; i++)
			{
				levelsArray[i].addEventListener(MouseEvent.CLICK, mapNameClicked);
				if (i <= UserProfile.levelsUnlocked)
				{
					//Map is unlocked
					levelsArray[i].unlockMap();
				}
				else
				{
					//Map is locked
					levelsArray[i].lockMap();
				}
			}

			StartMapButton.addEventListener(MouseEvent.CLICK, startMap);
		}
		private function selectMode(e:MouseEvent):void
		{
			gameMode = e.target.gameMode
			survivalButton.gotoAndStop(1)
			campaignButton.gotoAndStop(1)
			e.target.gotoAndStop(2);
		}
		private function mapNameClicked(e:MouseEvent):void
		{
			if (e.target.mapLocked == false)
			{
				if (lastLoaded != null && lastLoaded == e.target)
				{

				}
				else
				{
					lastLoaded = e.target;
					mapPreview.loadMapPreview(e.target.mapArray);
				}
			}

		}
		private function startMap(e:MouseEvent):void
		{

			if (lastLoaded != null)
			{
				mapPreview.removeMapPreview();
				removeChild(mapPreview);
				mapPreview = null;

				common.Commons.setMapArray(lastLoaded.mapArray);
				SoundManager.bgfx("BattleMap1");
				var map:Map = new Map();
				map.roundsList = common.Commons.roundsList;
				parent.addChild(map);

				endClass();
			}
		}
		private function removedFromStage(e:Event):void
		{
			lastLoaded = null;
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage)
			survivalButton.removeEventListener(MouseEvent.MOUSE_DOWN, selectMode)
			campaignButton.removeEventListener(MouseEvent.MOUSE_DOWN, selectMode)
			levelsArray = []
		}
		private function endClass():void
		{
			
			for (var i:int=0; i < levelsArray.length; i++)
			{
				levelsArray[i].removeEventListener(MouseEvent.CLICK, mapNameClicked);
			}
			StartMapButton.removeEventListener(MouseEvent.CLICK, startMap);
			parent.removeChild(this);
		}
	}

}