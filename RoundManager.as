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
		public var roundsList:Array;
		private var enemyWaveTracker:Array;
		private var enemyAlive:Array;
		private var actualRound:Boolean;

		public function RoundManager(_initEnemies:InitiateEnemies,rL:Array)
		{
			enemyWaveTracker = new Array  ;
			roundsList = rL;
			enemyAlive = new Array  ;
			enemyTimer = 0;
			currentRound = 1;
			initEnemies = _initEnemies;
			// constructor code
		}
		public function startRound(increaseRound:Boolean):void
		{
			//SoundManager.sfx("roundstart2");
			enemyAlive = new Array  ;
			enemyWaveTracker.push(enemyAlive);
			actualRound = false;
			if (increaseRound)
			{
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

			enemyAlive = new Array  ;
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
						UserInfo.changeGold(enemyWaveTracker[i][0]);
						enemyWaveTracker.splice(i,1);
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
	}

}