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

	public class MapSelectScreen extends MovieClip
	{

		private var lastLoaded:Object;
		private var levelsArray:Array = new Array  ;

		public function MapSelectScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			levelsArray.push(SFields,WPath,TOldBridge,BHideout,VOfTrolls,MMayhem,WAlley,TOfMages,SCircle);
			
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
				var map:Map = new Map();
				map.roundsList = common.Commons.roundsList;
				parent.addChild(map);


				endClass();
			}
		}
		private function endClass():void
		{
			parent.removeChild(this);
			for (var i:int=0; i < levelsArray.length; i++)
			{
				levelsArray[i].removeEventListener(MouseEvent.CLICK, mapNameClicked);
			}

			StartMapButton.removeEventListener(MouseEvent.CLICK, startMap);
		}
	}

}