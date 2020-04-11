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
	import com.greensock.TweenLite;
	import common.PreLoader;
	import common.LoadingText;
	import flash.net.URLLoader;
	import design.UI.OptionsWindow;

	import flash.filters.GlowFilter;


	public class MapSelectScreen extends MovieClip
	{

		private var optionsWindow:OptionsWindow;
		private var lastLoaded:Object;
		private var levelsArray:Array = new Array  ;
		private var gameMode:int;
		private var _r:Main;
		private var loadingText:LoadingText;

		public function MapSelectScreen(r:Main)
		{

			_r = r;
			addEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			gameMode = 1;
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			sounds.SoundManager.bgfx("mainTheme");
			options.addEventListener(MouseEvent.CLICK, optionsClicked);
			levelsArray.push(SFields,WPath,TOldBridge,BHideout,VOfTrolls,MMayhem,WAlley,TOfMages,SCircle);

			survivalButton.addEventListener(MouseEvent.MOUSE_DOWN, selectMode);
			campaignButton.addEventListener(MouseEvent.MOUSE_DOWN, selectMode);
			campaignButton.visible = false;
			survivalButton.visible = false;
			survivalButton.gotoAndStop(2);

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
			levelsArray[0].dispatchEvent(new MouseEvent("click"));
			StartMapButton.addEventListener(MouseEvent.CLICK, startMap);
			var glow:GlowFilter = new GlowFilter(0xff3300,1,6,6,10)
			StartMapButton.filters = [glow]
		}
		private function optionsClicked(e:MouseEvent):void
		{
			optionsWindow = new OptionsWindow(false);
			optionsWindow.x = (stage.width / 2) - (optionsWindow.width / 2);
			optionsWindow.y = (stage.height / 2) - (optionsWindow.height / 2);
			addChild(optionsWindow);
		}
		private function selectMode(e:MouseEvent):void
		{
			gameMode = e.target.gameMode;
			survivalButton.gotoAndStop(1);
			campaignButton.gotoAndStop(1);
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
					var glow:GlowFilter = new GlowFilter(uint(0xffff00));
					if (lastLoaded != null)
					{
						lastLoaded.filters = [];
					}
					lastLoaded = e.target;
					lastLoaded.filters = [glow];
					mapPreview.loadMapPreview(e.target.mapArray);
				}
			}

		}
		private function startMap(e:MouseEvent):void
		{
			if (lastLoaded != null)
			{
				TweenLite.to(this, .5, {alpha:0, onComplete:loadMap});
			}
		}
		private function loadMap():void
		{
			loadingText = new LoadingText();
			loadingText.x = (stage.width / 2) - (loadingText.width / 2);
			loadingText.y = (stage.height /2) - (loadingText.height / 2);
			_r.addChild(loadingText);


			lastLoaded.startGame(gameMode);
			lastLoaded.addEventListener(Event.COMPLETE, mapLoaded);
		}
		private function mapLoaded(e:Event):void
		{
			_r.removeChild(loadingText);
			loadingText = null;
			lastLoaded.removeEventListener(Event.COMPLETE, mapLoaded);
			removeMapPreview();

			SoundManager.bgfx("BattleMap1");

			var map:Map = new Map();
			_r.addChild(map);

			endClass();
		}
		private function removeMapPreview():void
		{
			mapPreview.removeMapPreview();
			removeChild(mapPreview);
			mapPreview = null;
		}
		private function removedFromStage(e:Event):void
		{
			options.removeEventListener(MouseEvent.CLICK, optionsClicked);
			optionsWindow = null;
			lastLoaded = null;
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			survivalButton.removeEventListener(MouseEvent.MOUSE_DOWN, selectMode);
			campaignButton.removeEventListener(MouseEvent.MOUSE_DOWN, selectMode);
			levelsArray = [];
		}
		private function endClass():void
		{
			for (var i:int=0; i < levelsArray.length; i++)
			{
				levelsArray[i].removeEventListener(MouseEvent.CLICK, mapNameClicked);
			}
			StartMapButton.removeEventListener(MouseEvent.CLICK, startMap);
			_r.removeChild(this);
			_r = null;
		}
	}

}