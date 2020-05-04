package
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
	import GameScreens.StartScreen;
	import design.BottomBar;
	import towers.TowerManager;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import common.Commons;

	import flash.display.LoaderInfo;
	import flash.display.Loader;
	import flash.system.Security;
	import User.UserProfile;

	//Middle
	//X: 448
	//Y: 292.5

	public class Main extends MovieClip
	{

		private var soundManager: SoundManager;
		private var queue: LoaderMax;
		private var towerList: Array;
		private var startScreen: StartScreen;
		private var paramObj: Object = LoaderInfo(root.loaderInfo).parameters;
		private var apiPath: String = paramObj.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
		// Kongregate API reference
		private var kongregate:*;

		public function Main()
		{
			this.stage.scaleMode = StageScaleMode.SHOW_ALL;
			this.stage.quality = "16X16";
			Security.allowDomain(apiPath);

			queue = new LoaderMax({name:"mainQueue",onProgress:progressHandler,onComplete:completeHandler});

			queue.append(new MP3Loader("externalFiles/sounds/sfx/building/buildtower.mp3", {name:"buildtower", volume:1, autoPlay:false, estimatedBytes: 2000}));
			//queue.append(new MP3Loader("externalFiles/sounds/sfx/roundstart/roundstart2.mp3", {name:"roundstart2", volume:1, autoPlay:false, estimatedBytes: 2000}));

			queue.append(new MP3Loader("externalFiles/sounds/sfx/voices/archer/hellothere.mp3", {name:"archerhellothere", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/voices/archer/whatdoyouneed.mp3", {name:"archerwhatdoyouneed", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/voices/knight/shallicompare.mp3", {name:"knightshallicompare", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/voices/knight/nofreeman.mp3", {name:"knightnofreeman", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/voices/warrior/greetings.mp3", {name:"warriorgreetings", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/voices/warrior/howcanihelp.mp3", {name:"warriorhowcanihelp", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/voices/rogue/hey.mp3", {name:"roguehey", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/voices/rogue/howareyou.mp3", {name:"roguehowareyou", volume:1, autoPlay:false, estimatedBytes: 2000}));
			
			queue.append(new MP3Loader("externalFiles/sounds/sfx/dirt/dirt1.mp3", {name:"dirt1", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/dirt/dirt2.mp3", {name:"dirt2", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/dirt/dirt3.mp3", {name:"dirt3", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/dirt/dirt4.mp3", {name:"dirt4", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/dirt/dirt5.mp3", {name:"dirt5", volume:1, autoPlay:false, estimatedBytes: 2000}));
			
			queue.append(new MP3Loader("externalFiles/sounds/sfx/buttonclick.mp3", {name:"clickbutton", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/newgame.mp3", {name:"newgamesound", volume:1, autoPlay:false, estimatedBytes: 2000}));
			
			queue.append(new MP3Loader("externalFiles/sounds/sfx/fire/flame.mp3", {name:"flame", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/dark/ShadowAttack3.mp3", {name:"darkshot", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/bullet/bulletshot.mp3", {name:"bulletshot", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/zap/zap.mp3", {name:"zapsound", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/lavasplash/lavasplash.mp3", {name:"lavasplash", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/stab/stab.mp3", {name:"stab", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/shieldBlock.mp3", {name:"shieldblock", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/swordStrike.mp3", {name:"swordhit", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/arrowShot.mp3", {name:"arrowshot", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/icecrash/icehit.mp3", {name:"icehit", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/cannonfire/cannonfire.mp3", {name:"cannonfire", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("externalFiles/sounds/sfx/torch/torch.mp3", {name:"torchSfx", volume:1, autoPlay:false, estimatedBytes:2000}));
			//queue.append(new MP3Loader("externalFiles/sounds/sfx/victoryscreen/hooray.mp3", {name:"hooraySfx", volume:1, autoPlay:false, estimatedBytes:2000}))
			//queue.append(new MP3Loader("externalFiles/sounds/sfx/victoryscreen/balloonpop.mp3", {name:"confettiSfx", volume:1, autoPlay:false, estimatedBytes:2000}))
			
			//MainMenu
			queue.append(new MP3Loader("externalFiles/sounds/music/Visions of Freedom.mp3", {name:"mainTheme2", volume:1, repeat:-1, autoPlay:false}));
			queue.append(new MP3Loader("externalFiles/sounds/music/A Bitter Hope.mp3", {name:"mainTheme1", volume:1, repeat:-1, autoPlay:false}));
			queue.append(new MP3Loader("externalFiles/sounds/music/Memories of a Lost Autumn.mp3", {name:"mainTheme0", volume:1, repeat:-1, autoPlay:false}));
			//Victory
			queue.append(new MP3Loader("externalFiles/sounds/music/Training Is Over.mp3", {name:"victoryMusic1", volume:1, repeat:-1, autoPlay:false}));
			queue.append(new MP3Loader("externalFiles/sounds/music/Can't Stop Winning.mp3", {name:"victoryMusic0", volume:1, repeat:-1, autoPlay:false}));
			//Battle Maps
			queue.append(new MP3Loader("externalFiles/sounds/music/BattleMap1.mp3", {name:"battleMap0", volume:1, autoPlay:false}));
			queue.append(new MP3Loader("externalFiles/sounds/music/Heated Lands.mp3", {name:"battleMap1", volume:1, repeat:-1, autoPlay:false}));
			queue.append(new MP3Loader("externalFiles/sounds/music/The Precipice of Victory.mp3", {name:"battleMap2", volume:1, repeat:-1, autoPlay:false}));
			queue.append(new MP3Loader("externalFiles/sounds/music/The Tread of War.mp3", {name:"battleMap3", volume:1, repeat:-1, autoPlay:false}));
			queue.append(new MP3Loader("externalFiles/sounds/music/Cold Sanctuary.mp3", {name:"battleMap4", volume:1, repeat:-1, autoPlay:false}));
			queue.append(new MP3Loader("externalFiles/sounds/music/NewName.mp3", {name:"battleMap5", volume:1, repeat:-1, autoPlay:false}));
			
			//R51
			queue.append(new MP3Loader("externalFiles/sounds/music/A Slave To No One.mp3", {name:"round51", volume:1, repeat:-1, autoPlay:false}));
			//GameOver
			queue.append(new MP3Loader("externalFiles/sounds/music/GameOverTheme.mp3", {name:"GameOverTheme", volume:1, repeat:-1, autoPlay:false}));
			
			queue.append(new XMLLoader("externalFiles/maps/Survival.xml", {name:"SurvivalXML"}))
			queue.append(new XMLLoader("externalFiles/TowersList.xml", {name:"TowersXML"}));
			
			queue.append(new ImageLoader("externalFiles/spritesheets/Towers32SpriteSheet.png", {name:"towers32"}));
			queue.append(new ImageLoader("externalFiles/spritesheets/Towers45SpriteSheet.png", {name:"towers45"}));
			queue.append(new ImageLoader("externalFiles/spritesheets/EnemySpriteSheet.png", {name:"enemySS"}));
			//queue.append(new ImageLoader("externalFiles/spritesheets/ConfettiSpriteSheet.png", {name:"confettiSS"}));
			queue.append(new ImageLoader("externalFiles/spritesheets/torch.png", {name:"torchSS"}));

			addEventListener("restart", restartMap);
			addEventListener("backtomap", backToMap);
			
			queue.load();
			// after load, run: completeHandler()
		}
		private function completeHandler(e: LoaderEvent): void
		{
			Commons.queue = queue;

			setupTowers();
			Preload.PreloadText.text = "Done!";
			setupRounds();

			soundManager = new SoundManager();

			removeChild(Preload);
			Preload = null;

			// Load the API
			var request: URLRequest = new URLRequest(apiPath);
			var loader: Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			this.addChild(loader);
			//once done, run loadComplete()
		}
		function loadComplete(event: Event): void
		{
			// Save Kongregate API reference
			kongregate = event.target.content;

			// Connect to the back-end
			kongregate.services.connect();
			
			Commons.kongregate = kongregate;
			// You can now access the API via:
			// kongregate.services
			// kongregate.user
			// kongregate.scores
			// kongregate.stats
			// etc...
			Commons.loadGame();
			
			startScreenUI()
		}
		private function startScreenUI(): void
		{
			//Commons.wipeGame()
			startScreen = new StartScreen();
			addChild(startScreen);
			startScreen.newGame.addEventListener(MouseEvent.CLICK, startGame);
		}
		private function startGame(e: Event): void
		{
			startScreen.newGame.removeEventListener(MouseEvent.CLICK, startGame);
			TweenLite.to(this, .4,
			{
				alpha: 0,
				onComplete: endThis
			});
		}		
		private function endThis(): void
		{
			removeChild(startScreen);
			startScreen = null;

			var mapSelectScreen: MapSelectScreen = new MapSelectScreen(this);
			addChild(mapSelectScreen);
			TweenLite.to(this, .3,
			{
				alpha: 1
			});
		}
		private function restartMap(e: Event): void
		{
			var map: Map = new Map();
			addChild(map);
		}
		private function backToMap(e: Event): void
		{
			var mapSelectScreen: MapSelectScreen = new MapSelectScreen(this);
			addChild(mapSelectScreen);
		}
		private function progressHandler(e: LoaderEvent): void
		{
			Preload.PreloadBar.scaleX = e.target.progress;
			Preload.PreloadText.text = int(e.target.progress * 100) + "%";
		}
		private function setupTowers(): void
		{
			towerList = new Array;

			var myXML = queue.getContent("TowersXML");
			var i: int = 0;
			var rect: Rectangle = new Rectangle(0, 0, Commons.tileSide, Commons.tileSide);
			var rect45: Rectangle = new Rectangle(0, 0, 45, 45);
			var pt: Point = new Point(0, 0);
			var bmpData: BitmapData
			while (i < myXML.Row.length())
			{
				
				var tower: Object = new Object();
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

				rect.y = (tower.tFrame * Commons.tileSide) - Commons.tileSide
				bmpData = new BitmapData(Commons.tileSide, Commons.tileSide);
				bmpData.copyPixels(queue.getContent("towers32").rawContent.bitmapData, rect, pt);
				tower.bmpData = BitmapData(bmpData);


				rect45.y = (tower.tFrame * 45) - 45
				bmpData = new BitmapData(45, 45)
				bmpData.copyPixels(queue.getContent("towers45").rawContent.bitmapData, rect45, pt);
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
				tower.totalCost = int(myXML.Row[i].TotalCost);
				towerList.push(tower);

				//var waveData:Array = [maxHp,maxMoveSpeed,goldValue,maxArmor,numberOfEnemies,freq,roundNumber,armorType,endBonus];
				i++;
			}
			TowerManager.towerList = towerList;
		}
		private function setupRounds(): void
		{
			var myXML = queue.getContent("SurvivalXML")
			var i: int = 0;
			var roundsList: Array = new Array;

			var rect: Rectangle = new Rectangle(0, 0, Commons.tileSide, Commons.tileSide);
			var pt: Point = new Point();
			var bmpData: BitmapData;

			while (i < myXML.Row.length())
			{
				var roundNumber: int = int(myXML.Row[i].currentRound);
				bmpData = Commons.getSprite("enemySS", i);

				var maxHp: int = int(myXML.Row[i].maxHp);
				var maxMoveSpeed: Number = Number(myXML.Row[i].maxMoveSpeed);
				var goldValue: int = int(myXML.Row[i].goldValue);
				var numberOfEnemies: int = int(myXML.Row[i].numberOfEnemies);
				var endBonus: int = int(myXML.Row[i].roundEndBonus);
				var freq: int = int(myXML.Row[i].freq);
				var armorType: String = String(myXML.Row[i].armorType);
				var maxArmor: int = int(myXML.Row[i].maxArmor);
				var eName: String = String(myXML.Row[i].eName);

				var s1: String = myXML.Row[i].eSkillOne;
				var s2: String = myXML.Row[i].eSkillTwo;
				var s3: String = myXML.Row[i].eSkillThree;

				var waveData: Array = [maxHp, maxMoveSpeed, goldValue, maxArmor, numberOfEnemies, freq, roundNumber, armorType, endBonus, eName, s1, s2, s3, bmpData];
				roundsList.push(waveData);
				i++;
			}
			common.Commons.setRoundsList(roundsList);

		}

	}

}