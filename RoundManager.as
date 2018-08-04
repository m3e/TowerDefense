package 
{

	import flash.display.Sprite;
	import flash.events.*;
	import enemies.InitiateEnemies;

	public class RoundManager extends Sprite
	{

		public var currentRound:int;
		public var roundInProgress:Boolean;
		private var enemyTimer:int;
		private var initEnemies:InitiateEnemies;
		private var numberToSend:int;
		private var frameTimer:int;
		private var waveArray:Array;

		public function RoundManager(_initEnemies:InitiateEnemies)
		{
			enemyTimer = 0;
			currentRound = 1;
			initEnemies = _initEnemies;
			// constructor code
		}
		public function startRound(increaseRound:Boolean):void
		{
			
			if (increaseRound)
			{
				compileRoundsData();
				currentRound++;
			}
			frameTimer = 0;
			roundInProgress = true;
			addEventListener(Event.ENTER_FRAME, spawnTimer);
		}
		private function stopRound():void
		{
			
			waveArray = []
			frameTimer = 0;
			roundInProgress = false;
			removeEventListener(Event.ENTER_FRAME, spawnTimer);
		}
		private function spawnTimer(e:Event):void
		{

			if (frameTimer % waveArray[5] == 0)
			{

				initEnemies.customEnemy(waveArray);
				waveArray[4] = (waveArray[4] - 1);
			}

			if (waveArray[4] == 0)
			{
				stopRound();
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
		private function compileRoundsData():void
		{
			waveArray = new Array  ;
			var hp:int;
			var ms:int;
			var gold:int;
			var armor:int;
			var numSend:int;
			var freq:int;
			var eFrame:int = 5;
			
			if (currentRound > 12)
			{
				currentRound = 12;
			}


			switch (currentRound)
			{
				case 1 :
					hp = 50;
					ms = 2.5;
					gold = 7;
					armor = 0;
					numSend = 1;
					freq = 12
					
					;
					break;

				case 2 :
					hp = 70;
					ms = 3;
					gold = 8;
					armor = 0;
					numSend = 1;
					freq = 12
					
					break;

				case 3 :
					hp = 45;
					ms = 6;
					gold = 15;
					armor = 0;
					numSend = 1;
					freq = 12
					break;

				case 4 :
					hp = 140;
					ms = 3;
					gold = 30;
					armor = 0;
					numSend = 1;
					freq = 12
					break;

				case 5 :
					hp = 140;
					ms = 4;
					gold = 25;
					armor = 0;
					numSend = 1;
					freq = 12
					break;

				case 6 :
					hp = 120;
					ms = 5;
					gold = 20;
					armor = 0;
					numSend = 1;
					freq = 12
					break;

				default :
					hp = 120;
					ms = 5;
					gold = 20;
					armor = 0;
					numSend = 1;
					freq = 12
			}
			eFrame = currentRound;
			waveArray = [hp,ms,gold,armor,numSend,freq,eFrame];
		}
	}

}