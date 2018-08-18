package 
{

	import flash.display.Sprite;
	import flash.events.*;
	import enemies.InitiateEnemies;
	import sounds.SoundManager;

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
			SoundManager.sfx("roundstart2");
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
			var armorType:String
			armorType = "pure"
			
			if (currentRound > 12)
			{
				currentRound = 12;
			}

			switch (currentRound)
			{
				case 1 :
					hp = 24;
					ms = 3;
					gold = 5;
					armor = 0;
					numSend = 12;
					freq = 14
					armorType = "medium"
					
					;
					break;

				case 2 :
					hp = 60;
					ms = 3;
					gold = 8;
					armor = 0;
					numSend = 10;
					freq = 16
					armorType = "medium"
					
					break;

				case 3 :
					hp = 55;
					ms = 6;
					gold = 5;
					armor = 0;
					numSend = 20;
					freq = 14
					armorType = "light"
					break;

				case 4 :
					hp = 140;
					ms = 3;
					gold = 9;
					armor = 0;
					numSend = 14;
					freq = 16
					armorType = "heavy"
					break;

				case 5 :
					hp = 160;
					ms = 4;
					gold = 10;
					armor = 0;
					numSend = 14;
					freq = 16
					armorType = "medium"
					break;

				case 6 :
					hp = 160;
					ms = 5;
					gold = 9;
					armor = 0;
					numSend = 20;
					freq = 12
					armorType = "heavy"
					break;
					
				case 7 :
					hp = 240
					ms = 4
					gold = 10
					armor = 0
					numSend = 18
					freq = 14
					armorType = "light"
					break;
					
				case 8 :
					hp = 300
					ms = 4
					gold = 11
					armor = 0
					numSend = 18
					freq = 14
					armorType = "heavy"
					break;
					
				case 9 :
					hp = 560
					ms = 3
					gold = 0
					armor = 0
					numSend = 16
					freq = 16
					armorType = "medium"
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
			waveArray = [hp,ms,gold,armor,numSend,freq,eFrame,armorType];
		}
	}

}