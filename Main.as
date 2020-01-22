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
	import towers.TowerManager;
	import flash.events.MouseEvent;
	import GameScreens.MapSelectScreen;
	import flash.display.StageScaleMode;
	import common.Commons;
	import GameScreens.StartScreen;

	public class Main extends MovieClip
	{

		private var soundManager:SoundManager;
		private var queue:LoaderMax;
		private var myLoader:URLLoader;
		private var towerList:Array;
		private var towerManager:TowerManager;
		private var roundsList:Array;
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

			queue.append(new MP3Loader("sounds/sfx/fire/fire.mp3", {name:"flame", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/stab/stab.mp3", {name:"stab", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/shieldBlock.mp3", {name:"shieldblock", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/swordStrike.mp3", {name:"swordhit", volume:1, autoPlay:false, estimatedBytes: 50000}));
			queue.append(new MP3Loader("sounds/sfx/arrowShot.mp3", {name:"arrowShot", volume:1, autoPlay:false, estimatedBytes: 50000}));
			
			queue.append(new MP3Loader("sounds/music/MainTheme.mp3", {name:"mainTheme", volume:1, autoPlay:false, estimatedBytes: 50000}));
			queue.append(new MP3Loader("sounds/music/BattleMap1.mp3", {name:"BattleMap1", volume:1, autoPlay:false, estimatedBytes: 50000}));
			//queue.append(new MP3Loader("sounds/music/BattleMap2.mp3", {name:"BattleMap2", volume:1, autoPlay:false, estimatedBytes: 50000}));

			queue.load();
			// constructor code
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

			while (i < myXML.Row.length())
			{

				var tower:Object = new Object();
				tower.tName = String(myXML.Row[i].Name);
				tower.tId = int(myXML.Row[i].ID);
				tower.tAoe = int(myXML.Row[i].AoE);
				tower.tRange = int(myXML.Row[i].Range);
				tower.tNumberOfTargets = int(myXML.Row[i].of_Targets);
				tower.tDmg = int(myXML.Row[i].Dmg);
				tower.tAtkSpeed = int(myXML.Row[i].Atk_Speed);
				tower.tCost = int(myXML.Row[i].Cost);
				tower.tType = String(myXML.Row[i].Type);
				tower.tbSpeed = int(myXML.Row[i].bulletSpeed);
				tower.bFrame = int(myXML.Row[i].bulletFrame);
				tower.tFrame = int(myXML.Row[i].towerFrame);
				tower.fireSoundString = String(myXML.Row[i].fireSoundString);
				tower.tDescription = String(myXML.Row[i].tDescription);
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
				towerList.push(tower);

				//var waveData:Array = [maxHp,maxMoveSpeed,goldValue,maxArmor,numberOfEnemies,freq,roundNumber,armorType,endBonus];
				i++;
			}
			Preload.PreloadText.text = "Done!";
			towerManager = new TowerManager(towerList);
			myLoader = null;
			setupRounds();
		}
		private function setupRounds():void
		{
			myLoader = new URLLoader  ;
			myLoader.addEventListener(Event.COMPLETE,compileRoundsList);
			myLoader.load(new URLRequest("RoundsList.xml"));
		}
		private function compileRoundsList(e:Event):void
		{
			var myXML = new XML(e.target.data);
			var i:int = 0;
			roundsList = new Array  ;
			while (i < myXML.Row.length())
			{
				var roundNumber:int = int(myXML.Row[i].currentRound);
				var maxHp:int = int(myXML.Row[i].maxHp);
				var maxMoveSpeed:Number = Number(myXML.Row[i].maxMoveSpeed);
				var goldValue:int = int(myXML.Row[i].goldValue);
				//var numberOfEnemies:int = 1;
				var numberOfEnemies:int = int(myXML.Row[i].numberOfEnemies);
				var endBonus:int = int(myXML.Row[i].roundEndBonus);
				var freq:int = int(myXML.Row[i].freq);
				var armorType:String = String(myXML.Row[i].armorType);
				var maxArmor:int = int(myXML.Row[i].maxArmor);
				var eName:String = String(myXML.Row[i].eName);
				var waveData:Array = [maxHp,maxMoveSpeed,goldValue,maxArmor,numberOfEnemies,freq,roundNumber,armorType,endBonus,eName];
				roundsList.push(waveData);
				i++;
			}
			common.Commons.setRoundsList(roundsList);
			startMenu();
		}
		private function startMenu():void
		{
			soundManager = new SoundManager(queue);
			sounds.SoundManager.bgfx("mainTheme");
			removeChild(Preload);
			Preload = null;
			startScreenUI()
			//Skip clicking NewGame:;
			//startGame(MouseEvent(undefined));
		}
		private function startScreenUI():void
		{
			startScreen = new StartScreen();
			addChild(startScreen)
			startScreen.newGame.addEventListener(MouseEvent.CLICK, startGame);
		}
		private function startGame(e:Event):void
		{
			startScreen.newGame.removeEventListener(MouseEvent.CLICK, startGame);
			TweenLite.to(startScreen, .5, {alpha:0, onComplete:endThis})
		}
		private function endThis():void
		{
			removeChild(startScreen);
			startScreen = null;

			var mapSelectScreen:MapSelectScreen = new MapSelectScreen();
			addChild(mapSelectScreen);
			TweenLite.from(mapSelectScreen, .3, {alpha:0});
		}

	}

}