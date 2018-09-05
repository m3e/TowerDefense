package 
{

	import flash.display.Sprite;
	import flash.events.*;
	import enemies.InitiateEnemies;
	import sounds.SoundManager;
	import enemies.Enemy;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class RoundManager extends Sprite
	{

		public var currentRound:int;
		public var roundInProgress:Boolean;
		private var enemyTimer:int;
		private var initEnemies:InitiateEnemies;
		private var frameTimer:int;
		private var waveArray:Array;
		private var roundEndBonus:int;
		private var myLoader:URLLoader;
		private var roundsList:Array;
		private var enemyWaveTracker:Array;
		private var enemyAlive:Array;
		private var actualRound:Boolean;

		public function RoundManager(_initEnemies:InitiateEnemies)
		{
			enemyWaveTracker = new Array  ;
			roundsList = new Array  ;
			enemyAlive = new Array  ;
			myLoader = new URLLoader  ;
			myLoader.addEventListener(Event.COMPLETE,compileRoundsList);
			myLoader.load(new URLRequest("RoundsList.xml"));
			enemyTimer = 0;
			currentRound = 1;
			initEnemies = _initEnemies;
			// constructor code
		}
		public function startRound(increaseRound:Boolean):void
		{
			//SoundManager.sfx("roundstart2");
			enemyAlive = new Array;
			enemyWaveTracker.push(enemyAlive)
			actualRound = false;
			if (increaseRound)
			{
				trace("Starting wave");
				actualRound = true;
				waveArray = roundsList[currentRound - 1];
				roundEndBonus = waveArray[8];
				enemyAlive.push(roundEndBonus);
				if (currentRound < roundsList.length)
				{
					currentRound++;
				}

			}

			if (waveArray[4] < 1)
			{
				waveArray[4] = 10;
			}
			frameTimer = 0;
			roundInProgress = true;

			addEventListener(Event.ENTER_FRAME, spawnTimer);
		}
		private function endWaveSend():void
		{
			waveArray = [];
			frameTimer = 0;
			roundInProgress = false;
			
			enemyAlive = new Array;
			removeEventListener(Event.ENTER_FRAME, spawnTimer);
		}
		private function enemyDead(e:Event):void
		{

			for (var i:int=0; i < enemyWaveTracker.length; i++)
			{
				if (enemyWaveTracker[i].indexOf(e.currentTarget) != -1)
				{
					enemyWaveTracker[i].splice(enemyWaveTracker[i].indexOf(e.currentTarget),1);
					if (enemyWaveTracker[i].length == 1)
					{
						UserInfo.changeGold(enemyWaveTracker[i][0])
						enemyWaveTracker.splice(i,1)
					}
				}
			}
			e.currentTarget.removeEventListener(Event.REMOVED,enemyDead);
		}
		private function spawnTimer(e:Event):void
		{

			if (frameTimer % waveArray[5] == 0)
			{
				var newEnemy:Enemy = initEnemies.customEnemy(waveArray);
				newEnemy.addEventListener(Event.REMOVED,enemyDead);
				enemyAlive.push(newEnemy);
				waveArray[4] = (waveArray[4] - 1);
			}
			if (waveArray[4] == 0)
			{
				endWaveSend();
			}
			else if (waveArray[4] < 0)
			{
				trace("RoundManager.numberToSend < 0?");
				frameTimer++;
			}
			else
			{
				frameTimer++;
			}
		}
		public function sendWave(WaveArray:Array)
		{
			waveArray = WaveArray;
			startRound(false);
		}
		private function compileRoundsList(e:Event):void
		{
			var myXML = new XML(e.target.data);
			var i:int = 0;
			while (i < myXML.Row.length())
			{
				var roundNumber:int = int(myXML.Row[i].currentRound);
				var maxHp:int = int(myXML.Row[i].maxHp);
				var maxMoveSpeed:Number = Number(myXML.Row[i].maxMoveSpeed);
				var goldValue:int = int(myXML.Row[i].goldValue);
				var numberOfEnemies:int = int(myXML.Row[i].numberOfEnemies);
				var endBonus:int = int(myXML.Row[i].roundEndBonus);
				var freq:int = int(myXML.Row[i].freq);
				var armorType:String = String(myXML.Row[i].armorType);
				var maxArmor:int = int(myXML.Row[i].maxArmor);
				var waveData:Array = [maxHp,maxMoveSpeed,goldValue,maxArmor,numberOfEnemies,freq,roundNumber,armorType,endBonus];
				roundsList.push(waveData);
				i++;
			}
		}
	}

}