package  {
	import flash.display.MovieClip;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;	
	import sounds.SoundManager;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import towers.TowerManager;
	
	public class Main extends MovieClip{

		private var soundManager:SoundManager;
		private var queue:LoaderMax;
		private var myLoader:URLLoader;
		private var towerList:Array;	
		private var towerManager:TowerManager;
		
		
		public function Main() {
			queue = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete: completeHandler});
			
			
			/*
			queue.append(new MP3Loader("https://dl.dropboxusercontent.com/s/fkdlcr3e9ge5krb/buttonclick.mp3", {name:"clickbutton", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("https://dl.dropboxusercontent.com/s/oyfhcudrxqvpil4/shblock.mp3", {name:"shieldblock", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("https://dl.dropboxusercontent.com/s/wykubut91hcocgq/swhit.mp3", {name:"swordhit", volume:1, autoPlay:false, estimatedBytes: 2000}));
			*/
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
			
			
			queue.load();
			// constructor code
		}
		private function progressHandler(e:LoaderEvent):void
		{
			
		}
		private function setupTowerManager():void
		{
			myLoader = new URLLoader  ;
			myLoader.addEventListener(Event.COMPLETE,setupTowers);
			myLoader.load(new URLRequest("towers/TowersList.xml"));
		}
		private function setupTowers(e:Event):void
		{
			towerList = new Array;
			
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
				
				towerList.push(tower);
				
				//var waveData:Array = [maxHp,maxMoveSpeed,goldValue,maxArmor,numberOfEnemies,freq,roundNumber,armorType,endBonus];
				
				//roundsList.push(waveData);
				i++;
			}
			towerManager = new TowerManager(towerList);
			startGame();
		}
		private function completeHandler(e:LoaderEvent):void
		{
			setupTowerManager()
		}
		private function startGame():void
		{
			soundManager = new SoundManager(queue);
			var map:Map = new Map();
			addChild(map);
		}

	}
	
}
