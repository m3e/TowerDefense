﻿package 
{
	import flash.display.MovieClip;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.TweenLite;
	import sounds.SoundManager;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	import GameScreens.MapSelectScreen;
	import flash.display.StageScaleMode;
	import common.Commons;
	import GameScreens.StartScreen;
	import design.BottomBar;
	import towers.TowerManager;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.BitmapData;

	//Middle
	//X: 448
	//Y: 292.5

	public class Main extends MovieClip
	{

		private var soundManager:SoundManager;
		private var queue:LoaderMax;
		private var myLoader:URLLoader;
		private var towerList:Array;
		private var startScreen:StartScreen;

		public function Main()
		{

			this.stage.scaleMode = StageScaleMode.SHOW_ALL;
			this.stage.quality = "16X16";

			queue = new LoaderMax({name:"mainQueue",onProgress:progressHandler,onComplete:completeHandler});

			queue.append(new MP3Loader("sounds/sfx/building/buildtower.mp3", {name:"buildtower", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/roundstart/roundstart2.mp3", {name:"roundstart2", volume:1, autoPlay:false, estimatedBytes: 2000}));

			queue.append(new MP3Loader("sounds/sfx/voices/archer/hellothere.mp3", {name:"archerhellothere", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/voices/archer/whatdoyouneed.mp3", {name:"archerwhatdoyouneed", volume:1, autoPlay:false, estimatedBytes: 2000}));

			queue.append(new MP3Loader("sounds/sfx/dirt/dirt1.mp3", {name:"dirt1", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/dirt/dirt2.mp3", {name:"dirt2", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/dirt/dirt3.mp3", {name:"dirt3", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/dirt/dirt4.mp3", {name:"dirt4", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/dirt/dirt5.mp3", {name:"dirt5", volume:1, autoPlay:false, estimatedBytes: 2000}));

			queue.append(new MP3Loader("sounds/sfx/voices/knight/shallicompare.mp3", {name:"knightshallicompare", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/voices/knight/nofreeman.mp3", {name:"knightnofreeman", volume:1, autoPlay:false, estimatedBytes: 2000}));

			queue.append(new MP3Loader("sounds/sfx/voices/warrior/greetings.mp3", {name:"warriorgreetings", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/voices/warrior/howcanihelp.mp3", {name:"warriorhowcanihelp", volume:1, autoPlay:false, estimatedBytes: 2000}));

			queue.append(new MP3Loader("sounds/sfx/voices/rogue/hey.mp3", {name:"roguehey", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/voices/rogue/howareyou.mp3", {name:"roguehowareyou", volume:1, autoPlay:false, estimatedBytes: 2000}));

			queue.append(new MP3Loader("sounds/sfx/buttonclick.mp3", {name:"clickbutton", volume:1, autoPlay:false, estimatedBytes: 2000}));
			
			queue.append(new MP3Loader("sounds/sfx/fire/flame.mp3", {name:"flame", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/bullet/bulletshot.mp3", {name:"bulletshot", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/zap/zap.mp3", {name:"zapsound", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/lavasplash/lavasplash.mp3", {name:"lavasplash", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/stab/stab.mp3", {name:"stab", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/shieldBlock.mp3", {name:"shieldblock", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/swordStrike.mp3", {name:"swordhit", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/arrowShot.mp3", {name:"arrowShot", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/icecrash/icehit.mp3", {name:"icehit", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/cannonfire/cannonfire.mp3", {name:"cannonfire", volume:1, autoPlay:false, estimatedBytes: 2000}));
			
			queue.append(new MP3Loader("sounds/music/MainTheme.mp3", {name:"mainTheme", volume:1, autoPlay:false, estimatedBytes: 50000}));
			queue.append(new MP3Loader("sounds/music/BattleMap1.mp3", {name:"BattleMap1", volume:1, autoPlay:false, estimatedBytes: 50000}));
			//queue.append(new MP3Loader("sounds/music/BattleMap2.mp3", {name:"BattleMap2", volume:1, autoPlay:false, estimatedBytes: 50000}));
			
			queue.append(new ImageLoader("assets/icons/Towers32SpriteSheet.png", {name:"towers32"}));
			queue.append(new ImageLoader("assets/icons/Towers45SpriteSheet.png", {name:"towers45"}));
			

			addEventListener("restart", restartMap);
			addEventListener("backtomap", backToMap);
			queue.load();
			// constructor code
		}
		private function restartMap(e:Event):void
		{
			
			var map:Map = new Map();
			addChild(map);
		}
		private function backToMap(e:Event):void
		{
			var mapSelectScreen:MapSelectScreen = new MapSelectScreen(this);
			addChild(mapSelectScreen);
		}
		private function progressHandler(e:LoaderEvent):void
		{
			Preload.PreloadBar.scaleX = e.target.progress;
			Preload.PreloadText.text = (e.target.progress.toFixed(2) * 100) + "%";
		}
		private function completeHandler(e:LoaderEvent):void
		{
			setupTowerManager();
		}
		private function setupTowerManager():void
		{
			myLoader = new URLLoader  ;
			myLoader.addEventListener(Event.COMPLETE,setupTowers);
			Preload.PreloadText.text = "Loading Towers!";
			myLoader.load(new URLRequest("towers/TowersList.xml"));
		}
		private function setupTowers(e:Event):void
		{
			towerList = new Array  ;

			var myXML = new XML(e.target.data);
			var i:int = 0;
			
			var rect:Rectangle = new Rectangle(0,0,common.Commons.tileSide,common.Commons.tileSide);
			var rect45:Rectangle = new Rectangle(0,0,45,45);
			var pt:Point = new Point(0,0);
			var bmpData:BitmapData
			while (i < myXML.Row.length())
			{

				var tower:Object = new Object();
				tower.tName = String(myXML.Row[i].Name);
				tower.tAoe = int(myXML.Row[i].AoE);
				tower.tRange = int(myXML.Row[i].Range);
				tower.tNumberOfTargets = int(myXML.Row[i].of_Targets);
				tower.tDmg = int(myXML.Row[i].Dmg);
				tower.tAtkSpeed = int(myXML.Row[i].Atk_Speed);
				tower.tCost = int(myXML.Row[i].Cost);
				tower.tType = String(myXML.Row[i].Type);
				tower.bFrame = String(myXML.Row[i].bulletFrame);
				tower.bHitFrame = String(myXML.Row[i].bulletHit);
				tower.tbSpeed = int(myXML.Row[i].bulletSpeed);
				tower.tFrame = int(myXML.Row[i].towerFrame);
				
				rect.y = (tower.tFrame * common.Commons.tileSide) - common.Commons.tileSide
				bmpData = new BitmapData(common.Commons.tileSide,common.Commons.tileSide);
				bmpData.copyPixels(queue.getContent("towers32").rawContent.bitmapData,rect,pt);
				tower.bmpData = BitmapData(bmpData);
				
				rect45.y = (tower.tFrame * 45) - 45
				bmpData = new BitmapData(45,45)
				bmpData.copyPixels(queue.getContent("towers45").rawContent.bitmapData,rect45,pt);
				tower.bmpData45 = BitmapData(bmpData);
				
				tower.fireSoundString = String(myXML.Row[i].fireSoundString);
				tower.hitSound = String(myXML.Row[i].hitSoundString);
				tower.tUpgradeOne = null;
				tower.tUpgradeTwo = null;
				tower.tUpgradeThree = null;
				if (myXML.Row[i].upgradeOne != undefined)
				{
					tower.tUpgradeOne = String(myXML.Row[i].upgradeOne);
				}
				if (myXML.Row[i].upgradeTwo != undefined)
				{
					tower.tUpgradeTwo = String(myXML.Row[i].upgradeTwo);
				}
				if (myXML.Row[i].upgradeThree != undefined)
				{
					tower.tUpgradeThree = String(myXML.Row[i].upgradeThree);
				}
				tower.targeting = String(myXML.Row[i].targeting);
				tower.tSkillOne = String(myXML.Row[i].skillOne);
				tower.tSkillTwo = String(myXML.Row[i].skillTwo);
				tower.tSkillThree = String(myXML.Row[i].skillThree);
				tower.tSkillFour = String(myXML.Row[i].skillFour);
				tower.tDescription = String(myXML.Row[i].tDescription);
				towerList.push(tower);

				//var waveData:Array = [maxHp,maxMoveSpeed,goldValue,maxArmor,numberOfEnemies,freq,roundNumber,armorType,endBonus];
				i++;
			}
			Preload.PreloadText.text = "Done!";
			TowerManager.towerList = towerList;
			myLoader = null;
			startMenu();
		}
		private function startMenu():void
		{
			soundManager = new SoundManager(queue);
			removeChild(Preload);
			Preload = null;
			startScreenUI(); //Game Starts Here
			//endThis() //skip to mapSelectScreen
		}
		private function startScreenUI():void
		{
			startScreen = new StartScreen();
			addChild(startScreen);
			startScreen.newGame.addEventListener(MouseEvent.CLICK, startGame);
		}
		private function startGame(e:Event):void
		{
			startScreen.newGame.removeEventListener(MouseEvent.CLICK, startGame);
			TweenLite.to(startScreen, .5, {alpha:0, onComplete:endThis});
		}
		private function endThis():void
		{
			removeChild(startScreen);
			startScreen = null;

			var mapSelectScreen:MapSelectScreen = new MapSelectScreen(this);
			addChild(mapSelectScreen);
			TweenLite.from(mapSelectScreen, .3, {alpha:0});
		}
	}

}